import fs from 'node:fs';
import path from 'node:path';

const UPSTREAM_API = 'https://doorsgame.wiki/w/api.php';
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
  'Template:DOORS Wiki/Home Navigation': 'templates/shared-lang/DOORS Wiki/Home Navigation.wikitext',
  'Template:DOORS Wiki/Home Navigation/item': 'templates/shared-lang/DOORS Wiki/Home Navigation/item.wikitext',
  'Template:DOORS Wiki/Featured Articles': 'templates/shared-lang/DOORS Wiki/Featured Articles.wikitext',
  'Template:DOORS Wiki/Fun Facts': 'templates/shared-lang/DOORS Wiki/Fun Facts.wikitext',
  'Template:DOORS Wiki/Socials': 'templates/shared-lang/DOORS Wiki/Socials.wikitext',
  'Template:DOORS Wiki/Container': 'templates/shared-lang/DOORS Wiki/Container.wikitext',
  'Template:Documentation': 'templates/shared-lang/Documentation/Documentation.wikitext',
  'Template:Documentation/doc': 'templates/shared-lang/Documentation/doc.wikitext',

  // Main / Article namespace
  'DOORS Wiki': 'pages/shared-lang/DOORS Wiki/DOORS Wiki.wikitext',

  // User namespace
  'User:DoorsWiki': 'users/shared-lang/DoorsWiki/DoorsWiki.wikitext',

  // User talk namespace
  'User talk:DoorsWiki': 'user_talk/shared-lang/DoorsWiki/DoorsWiki.wikitext',
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

async function main() {
  const username = process.env.WIKI_USERNAME || '';
  const password = process.env.WIKI_PASSWORD || '';

  const upstreamClient = new MediaWikiClient(UPSTREAM_API, username, password);

  console.log(`Connecting to English upstream wiki (${UPSTREAM_API})...`);
  console.log(`User-Agent: ${WIKIWIRE_UA}`);
  await upstreamClient.login();

  console.log(`Querying all ${Object.keys(PAGES).length} pages individually...`);

  let updatedCount = 0;
  for (const [title, relPath] of Object.entries(PAGES)) {
    try {
      const pageMap = await upstreamClient.fetchPages(title);
      const upstreamContent = pageMap[title];
      if (upstreamContent === undefined) {
        console.warn(`[WARN] Page not found upstream: ${title}`);
        continue;
      }

      const dir = path.dirname(relPath);
      fs.mkdirSync(dir, { recursive: true });
      fs.writeFileSync(relPath, upstreamContent, 'utf8');
      updatedCount++;

      console.log(`[SYNCED] ${title} -> ${relPath} (${Buffer.byteLength(upstreamContent, 'utf8')} bytes)`);
    } catch (err) {
      console.warn(`[REQUEST FAILED] ${title}: ${err.message}`);
      // Continue without stopping!
    }
  }

  console.log(`Completed requests across all pages (${updatedCount}/${Object.keys(PAGES).length} succeeded).`);
}

main().catch((err) => {
  console.warn(`[WARN] Process finished: ${err.message}`);
});
