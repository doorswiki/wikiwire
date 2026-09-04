import fs from 'node:fs';
import path from 'node:path';

const API_URL = 'https://doorsgame.wiki/w/api.php';
const TARGET_DIR = 'mediawiki/shared-lang';

const PAGES = {
  'MediaWiki:Common.css': 'Common.css',
  'MediaWiki:Common.js': 'Common.js',
  'MediaWiki:Citizen.css': 'Citizen.css',
  'MediaWiki:Citizen-preferences.json': 'Citizen-preferences.json',
  'MediaWiki:Gadget-SpoilersByDefault': 'Gadget-SpoilersByDefault',
  'MediaWiki:Gadget-SpoilersByDefault.js': 'Gadget-SpoilersByDefault.js',
  'MediaWiki:Gadgets-definition': 'Gadgets-definition',
  'MediaWiki:Welcome-enabled': 'Welcome-enabled',
  'MediaWiki:Welcome-user-page': 'Welcome-user-page',
  'MediaWiki:Welcome-user': 'Welcome-user',
  'MediaWiki:Welcome-message-user': 'Welcome-message-user',
};

async function main() {
  fs.mkdirSync(TARGET_DIR, { recursive: true });

  const titles = Object.keys(PAGES).join('|');
  const params = new URLSearchParams({
    action: 'query',
    prop: 'revisions',
    titles,
    rvprop: 'content',
    rvslots: '*',
    format: 'json',
    formatversion: '2',
  });

  const res = await fetch(`${API_URL}?${params.toString()}`, {
    headers: { 'User-Agent': 'WikiWire-Sync/1.0' },
  });

  if (!res.ok) {
    throw new Error(`Failed to fetch from MediaWiki API: ${res.status} ${res.statusText}`);
  }

  const data = await res.json();
  const pages = data.query?.pages ?? [];

  for (const page of pages) {
    const filename = PAGES[page.title];
    if (!filename) {
      console.warn(`[WARN] Unknown page title returned: ${page.title}`);
      continue;
    }

    if (page.missing) {
      console.warn(`[WARN] Page does not exist on wiki: ${page.title}`);
      continue;
    }

    const content = page.revisions?.[0]?.slots?.main?.content ?? page.revisions?.[0]?.content ?? '';
    const filePath = path.join(TARGET_DIR, filename);

    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`[SYNCED] ${page.title} -> ${filePath} (${Buffer.byteLength(content, 'utf8')} bytes)`);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
