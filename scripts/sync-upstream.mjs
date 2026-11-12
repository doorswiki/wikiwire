import fs from 'node:fs';
import path from 'node:path';

const WIKIWIRE_UA = 'WikiWire/1.0 (https://github.com/doorswiki/wikiwire; github-actions; doorswiki)';

// Overridable for local testing against a fake MediaWiki instance.
const UPSTREAM_API = process.env.UPSTREAM_API || 'https://doorsgame.wiki/w/api.php';
const REPO_ROOT = process.env.SYNC_UPSTREAM_ROOT || process.cwd();

// Dry run prints what would change without touching anything.
const DRY_RUN = process.env.SYNC_UPSTREAM_DRY_RUN === '1';

const PAGES_FILE = path.join(REPO_ROOT, 'scripts', 'pages.json');

class MediaWikiClient {
  constructor(apiUrl, username = '', password = '') {
    this.apiUrl = apiUrl;
    this.username = username;
    this.password = password;
    this.cookies = new Map();
  }

  mergeCookies(headers) {
    const list = typeof headers.getSetCookie === 'function'
      ? headers.getSetCookie()
      : (headers.get('set-cookie') ? [headers.get('set-cookie')] : []);

    for (const item of list) {
      for (const line of item.split(/,(?=[^;]+?=)/)) {
        const nv = line.split(';')[0].trim();
        const eq = nv.indexOf('=');
        if (eq !== -1) {
          this.cookies.set(nv.slice(0, eq).trim(), nv.slice(eq + 1).trim());
        }
      }
    }
  }

  getCookieHeader() {
    if (this.cookies.size === 0) return {};
    return {
      Cookie: [...this.cookies.entries()].map(([k, v]) => `${k}=${v}`).join('; '),
    };
  }

  async post(params) {
    const body = new URLSearchParams({
      format: 'json',
      formatversion: '2',
      ...params,
    });

    const res = await fetch(this.apiUrl, {
      method: 'POST',
      headers: {
        'User-Agent': WIKIWIRE_UA,
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        ...this.getCookieHeader(),
      },
      body,
    });

    this.mergeCookies(res.headers);

    if (!res.ok) {
      const detail = await res.text();
      const cfRay = res.headers.get('cf-ray');
      const isCfChallenge = detail.includes('Checking your connection') || detail.includes('Just a moment') || detail.includes('cf-mitigated') || detail.includes('unusual activity');
      if (isCfChallenge) {
        throw new Error(
          `Cloudflare Bot Challenge (HTTP ${res.status}${cfRay ? `; cf-ray=${cfRay}` : ''})`
        );
      }
      throw new Error(
        `HTTP ${res.status} ${res.statusText}${cfRay ? `; cf-ray=${cfRay}` : ''}: ${detail.slice(0, 150)}`
      );
    }

    return res.json();
  }

  async login() {
    if (!this.username || !this.password) return;
    try {
      const tokenRes = await this.post({
        action: 'query',
        meta: 'tokens',
        type: 'login',
      });
      const loginToken = tokenRes.query?.tokens?.logintoken;
      if (!loginToken) return;

      const loginRes = await this.post({
        action: 'login',
        lgname: this.username,
        lgpassword: this.password,
        lgtoken: loginToken,
      });

      if (loginRes.login?.result === 'Success') {
        console.log(`[AUTH] Logged in to ${this.apiUrl} as ${this.username}`);
      } else {
        console.warn(`[WARN] Login to ${this.apiUrl} returned: ${loginRes.login?.reason ?? loginRes.login?.result}`);
      }
    } catch (err) {
      console.warn(`[WARN] Login attempt to ${this.apiUrl} failed: ${err.message}`);
    }
  }

  // Batched query; up to 50 titles per request. Resolves redirects when the
  // caller asks for them. Returns Map<title, {status, content?, to?}>.
  async fetchPages(titles, { redirects = false } = {}) {
    const out = new Map();

    for (let i = 0; i < titles.length; i += 50) {
      const chunk = titles.slice(i, i + 50);
        const params = {
          action: 'query',
          prop: 'revisions',
          rvprop: 'content',
          rvslots: 'main',
          titles: chunk.join('|'),
        };
        if (redirects) params.redirects = '1';
        const data = await this.post(params);

      const resolved = new Map((data.query?.redirects ?? []).map((r) => [r.from, r.to]));
      const byTitle = new Map((data.query?.pages ?? []).map((p) => [p.title, p]));

      for (const title of chunk) {
        const to = redirects ? resolved.get(title) : undefined;

        if (to !== undefined) {
          const page = byTitle.get(to);
          if (!page || page.missing) {
            out.set(title, { status: 'missing' });
            continue;
          }
          const content = page.revisions?.[0]?.slots?.main?.content ?? page.revisions?.[0]?.content ?? '';
          out.set(title, { status: 'redirect', to, content });
          continue;
        }

        const page = byTitle.get(title);
        if (!page || page.missing) {
          out.set(title, { status: 'missing' });
          continue;
        }
        const content = page.revisions?.[0]?.slots?.main?.content ?? page.revisions?.[0]?.content ?? '';
        out.set(title, { status: 'ok', content });
      }
    }

    return out;
  }
}

function rel(relPath) {
  return relPath.split(path.sep).join('/');
}

function normalizeNewlines(text) {
  return text.replace(/\r\n/g, '\n');
}

function loadManifest() {
  if (!fs.existsSync(PAGES_FILE)) {
    throw new Error(`WikiWire upstream: import manifest missing: ${PAGES_FILE}`);
  }
  const raw = JSON.parse(fs.readFileSync(PAGES_FILE, 'utf8'));
  if (raw === null || typeof raw !== 'object' || Array.isArray(raw)) {
    throw new Error(`WikiWire upstream: ${PAGES_FILE} must contain a JSON object of { "Page title": "relative/path" }`);
  }
  return { ...raw };
}

function saveManifest(manifest) {
  if (DRY_RUN) return;
  const sorted = {};
  for (const title of Object.keys(manifest).sort((a, b) => a.localeCompare(b))) {
    sorted[title] = manifest[title];
  }
  fs.writeFileSync(PAGES_FILE, `${JSON.stringify(sorted, null, 2)}\n`, 'utf8');
}

function writeIfDifferent(filePath, content) {
  const existing = fs.existsSync(filePath) ? fs.readFileSync(filePath, 'utf8') : null;
  if (existing !== null && normalizeNewlines(existing) === normalizeNewlines(content)) {
    return 'unchanged';
  }
  if (DRY_RUN) {
    console.log(`[DRY-RUN] would write ${rel(path.relative(REPO_ROOT, filePath))} (${existing === null ? 'new file' : 'content changed'})`);
    return 'updated';
  }
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, content, 'utf8');
  return 'updated';
}

async function main() {
  const username = process.env.WIKI_USERNAME || '';
  const password = process.env.WIKI_PASSWORD || '';

  const manifest = loadManifest();
  const titles = Object.keys(manifest);

  console.log(`Connecting to English upstream wiki (${UPSTREAM_API})...`);
  console.log(`User-Agent: ${WIKIWIRE_UA}`);
  if (DRY_RUN) console.log('Dry run; no files will be written');

  const upstreamClient = new MediaWikiClient(UPSTREAM_API, username, password);
  await upstreamClient.login();

  console.log(`Querying ${titles.length} pages from upstream (batched)...`);

  let resolved;
  try {
    resolved = await upstreamClient.fetchPages(titles, { redirects: true });
  } catch (err) {
    console.warn(`[WARN] Failed to fetch pages from upstream: ${err.message}`);
    return;
  }

  // For redirect pages, fetch the raw redirect wikitext so the fork keeps a
  // redirect exactly like the upstream wiki instead of the target's content.
  const redirectTitles = titles.filter((title) => resolved.get(title)?.status === 'redirect');
  let rawRedirects = new Map();
  if (redirectTitles.length > 0) {
    try {
      rawRedirects = await upstreamClient.fetchPages(redirectTitles, { redirects: false });
    } catch (err) {
      console.warn(`[WARN] Failed to fetch redirect sources: ${err.message}`);
    }
  }

  let updated = 0;
  let unchanged = 0;
  let mirrored = 0;
  let removed = 0;
  let failed = 0;

  for (const title of titles) {
    const result = resolved.get(title);
    const relPath = manifest[title];
    const absPath = path.join(REPO_ROOT, relPath);

    if (!result) {
      console.warn(`[WARN] No response for ${title}; leaving repo file alone`);
      failed++;
      continue;
    }

    if (result.status === 'missing') {
      if (fs.existsSync(absPath)) {
        if (DRY_RUN) {
          console.log(`[DRY-RUN] would remove ${relPath} (upstream page moved or deleted)`);
        } else {
          fs.rmSync(absPath, { force: true });
        }
      } else {
        console.warn(`[MISSING] ${title} not found upstream and ${relPath} is not in the repo`);
      }
      delete manifest[title];
      removed++;
      console.warn(`[REMOVED] ${title} -> ${relPath} (upstream page moved or deleted; repo copy removed)`);
      continue;
    }

    if (result.status === 'redirect') {
      const raw = rawRedirects.get(title);
      let outcome;
      if (raw && raw.status === 'ok') {
        // Keep the repo copy as the upstream redirect so forks stay in sync.
        outcome = writeIfDifferent(absPath, raw.content);
      } else {
        // The redirect page itself was removed (or no raw content). Treat as deleted.
        if (fs.existsSync(absPath)) {
          if (DRY_RUN) {
            console.log(`[DRY-RUN] would remove ${relPath} (redirect target ${result.to} gone but no redirect source)`);
          } else {
            fs.rmSync(absPath, { force: true });
          }
        }
        delete manifest[title];
        removed++;
        console.warn(`[REMOVED] ${title} -> ${relPath} (upstream page moved or deleted; repo copy removed)`);
        continue;
      }
      if (outcome === 'updated') updated++; else unchanged++;
      mirrored++;
      console.log(`[REDIRECT] ${title} -> ${result.to} (repo copy kept and synced as redirect)`);
      continue;
    }

    const outcome = writeIfDifferent(absPath, result.content);
    if (outcome === 'updated') updated++; else unchanged++;
  }

  if (!DRY_RUN) saveManifest(manifest);

  console.log(`Done. ${updated} updated, ${unchanged} up to date, ${mirrored} redirects mirrored, ${removed} removed, ${failed} failed (of ${titles.length}).`);
}

main().catch((err) => {
  console.warn(`[WARN] Process finished: ${err.message}`);
});
