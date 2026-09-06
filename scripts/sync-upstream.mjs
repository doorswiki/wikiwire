import fs from 'node:fs';
import path from 'node:path';

const UPSTREAM_API = 'https://doorsgame.wiki/w/api.php';
const LANG_API = 'https://zh.doorsgame.wiki/w/api.php';
const WIKIWIRE_UA = 'WikiWire/1.0 (https://github.com/doorswiki/wikiwire; github-actions; doorswiki)';

const PAGES = {
  // MediaWiki namespace
  'MediaWiki:Common.css': 'mediawiki/shared-lang/Common.css',
  'MediaWiki:Common.js': 'mediawiki/shared-lang/Common.js',
  'MediaWiki:Citizen.css': 'mediawiki/shared-lang/Citizen.css',
  'MediaWiki:Citizen-preferences.json': 'mediawiki/shared-lang/Citizen-preferences.json',
  'MediaWiki:Gadget-SpoilersByDefault': 'mediawiki/shared-lang/Gadget-SpoilersByDefault',
  'MediaWiki:Gadget-SpoilersByDefault.js': 'mediawiki/shared-lang/Gadget-SpoilersByDefault.js',
  'MediaWiki:Gadgets-definition': 'mediawiki/shared-lang/Gadgets-definition',
  'MediaWiki:Welcome-enabled': 'mediawiki/shared-lang/Welcome-enabled',
  'MediaWiki:Welcome-user-page': 'mediawiki/shared-lang/Welcome-user-page',
  'MediaWiki:Welcome-user': 'mediawiki/shared-lang/Welcome-user',
  'MediaWiki:Welcome-message-user': 'mediawiki/shared-lang/Welcome-message-user',

  // Module namespace
  'Module:Transcluder': 'modules/shared-lang/Transcluder/Transcluder.module.lua',
  'Module:InfoboxNeue': 'modules/shared-lang/InfoboxNeue/InfoboxNeue.module.lua',
  'Module:InfoboxNeue/styles.css': 'modules/shared-lang/InfoboxNeue/styles.css',
  'Module:InfoboxNeue/doc': 'modules/shared-lang/InfoboxNeue/doc.wikitext',
  'Module:BadgeRenderer': 'modules/shared-lang/BadgeRenderer/BadgeRenderer.module.lua',
  'Module:BadgeList': 'modules/shared-lang/BadgeList/BadgeList.module.lua',
  'Module:BadgeData': 'modules/shared-lang/BadgeData/BadgeData.module.lua',
  'Module:Arguments': 'modules/shared-lang/Arguments/Arguments.module.lua',
  'Module:AboutDoors': 'modules/shared-lang/AboutDoors/AboutDoors.module.lua',
  'Module:AboutDoors/styles.css': 'modules/shared-lang/AboutDoors/styles.css',

  // Template namespace
  'Template:USERNAME': 'templates/shared-lang/USERNAME/USERNAME.wikitext',
  'Template:Username': 'templates/shared-lang/Username/Username.wikitext',
  'Template:USERNAME/doc': 'templates/shared-lang/USERNAME/doc.wikitext',
  'Template:DOORSWiki userpage': 'templates/shared-lang/DOORSWiki userpage/DOORSWiki userpage.wikitext',
  'Template:Hoverimg': 'templates/shared-lang/Hoverimg/Hoverimg.wikitext',
  'Template:Icons': 'templates/shared-lang/Icons/Icons.wikitext',
  'Template:DOORS Wiki/styles.css': 'templates/shared-lang/DOORS Wiki/styles.css',
};

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
          `Cloudflare Bot Challenge triggered on ${this.apiUrl} (HTTP ${res.status}${cfRay ? `; cf-ray=${cfRay}` : ''}).`
        );
      }
      throw new Error(
        `Failed to fetch from ${this.apiUrl} (HTTP ${res.status} ${res.statusText}${cfRay ? `; cf-ray=${cfRay}` : ''}): ${detail.slice(0, 300)}`
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

  async fetchPages(titles) {
    const data = await this.post({
      action: 'query',
      prop: 'revisions',
      titles,
      rvprop: 'content',
      rvslots: '*',
    });

    const map = {};
    for (const page of data.query?.pages ?? []) {
      if (!page.missing) {
        map[page.title] = page.revisions?.[0]?.slots?.main?.content ?? page.revisions?.[0]?.content ?? '';
      }
    }
    return map;
  }
}

// Myers LCS algorithm
function getLCS(a, b) {
  const m = a.length;
  const n = b.length;
  const dp = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0));
  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      if (a[i - 1] === b[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
      }
    }
  }
  let i = m, j = n;
  const matches = [];
  while (i > 0 && j > 0) {
    if (a[i - 1] === b[j - 1]) {
      matches.unshift({ aIndex: i - 1, bIndex: j - 1 });
      i--;
      j--;
    } else if (dp[i - 1][j] >= dp[i][j - 1]) {
      i--;
    } else {
      j--;
    }
  }
  return matches;
}

// Diff lines between a and b
function diffLines(a, b) {
  const matches = getLCS(a, b);
  const chunks = [];
  let aPos = 0, bPos = 0;
  for (const m of matches) {
    if (aPos < m.aIndex || bPos < m.bIndex) {
      chunks.push({
        type: 'change',
        a: a.slice(aPos, m.aIndex),
        b: b.slice(bPos, m.bIndex),
      });
    }
    chunks.push({
      type: 'equal',
      line: a[m.aIndex],
    });
    aPos = m.aIndex + 1;
    bPos = m.bIndex + 1;
  }
  if (aPos < a.length || bPos < b.length) {
    chunks.push({
      type: 'change',
      a: a.slice(aPos),
      b: b.slice(bPos),
    });
  }
  return chunks;
}

/**
 * Merge upstream content with language wiki / local content.
 * Any line changed by the language wiki or in the local repo is preserved.
 */
function mergePreservingLang(upstreamText, langText) {
  if (!langText || langText === upstreamText) return upstreamText;
  const upstreamLines = upstreamText.split('\n');
  const langLines = langText.split('\n');

  const chunks = diffLines(upstreamLines, langLines);
  const result = [];
  for (const chunk of chunks) {
    if (chunk.type === 'equal') {
      result.push(chunk.line);
    } else {
      if (chunk.b.length > 0) {
        // Language wiki has changed/added lines: preserve them
        result.push(...chunk.b);
      } else if (chunk.a.length > 0) {
        // Upstream has new additions: incorporate them
        result.push(...chunk.a);
      }
    }
  }
  return result.join('\n');
}

async function main() {
  const titles = Object.keys(PAGES).join('|');
  const username = process.env.WIKI_USERNAME || '';
  const password = process.env.WIKI_PASSWORD || '';

  const upstreamClient = new MediaWikiClient(UPSTREAM_API, username, password);
  const langClient = new MediaWikiClient(LANG_API, username, password);

  console.log('Connecting to upstream and language wikis...');
  await Promise.all([
    upstreamClient.login(),
    langClient.login(),
  ]);

  console.log('Fetching pages...');
  let upstreamPages = {};
  let langPages = {};

  try {
    upstreamPages = await upstreamClient.fetchPages(titles);
  } catch (err) {
    console.warn(`[WARN] Could not fetch from upstream English wiki (${UPSTREAM_API}): ${err.message}`);
    console.warn('[WARN] Continuing with existing repository files...');
  }

  try {
    langPages = await langClient.fetchPages(titles);
  } catch (err) {
    console.warn(`[WARN] Could not fetch from language wiki (${LANG_API}): ${err.message}`);
  }

  let updatedCount = 0;
  for (const [title, relPath] of Object.entries(PAGES)) {
    const upstreamContent = upstreamPages[title];
    if (upstreamContent === undefined) {
      continue;
    }

    // Check existing content: local disk file first, then language wiki
    let existingContent = null;
    if (fs.existsSync(relPath)) {
      existingContent = fs.readFileSync(relPath, 'utf8');
    } else if (langPages[title] !== undefined) {
      existingContent = langPages[title];
    }

    // Merge upstream with existing language modifications
    const finalContent = mergePreservingLang(upstreamContent, existingContent);

    const dir = path.dirname(relPath);
    fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(relPath, finalContent, 'utf8');
    updatedCount++;

    if (existingContent && existingContent !== upstreamContent) {
      console.log(`[SYNCED (MERGED)] ${title} -> ${relPath} (preserved language modifications)`);
    } else {
      console.log(`[SYNCED] ${title} -> ${relPath} (${Buffer.byteLength(finalContent, 'utf8')} bytes)`);
    }
  }

  console.log(`Synchronization finished (${updatedCount}/${Object.keys(PAGES).length} pages processed).`);
}

main().catch((err) => {
  console.warn(`[WARN] Upstream sync encountered an issue but continuing: ${err.message}`);
});
