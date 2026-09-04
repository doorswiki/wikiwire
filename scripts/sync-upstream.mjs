import fs from 'node:fs';
import path from 'node:path';

const API_URL = 'https://doorsgame.wiki/w/api.php';

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
};

async function main() {
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
    const relPath = PAGES[page.title];
    if (!relPath) {
      console.warn(`[WARN] Unknown page title returned: ${page.title}`);
      continue;
    }

    if (page.missing) {
      console.warn(`[WARN] Page does not exist on wiki: ${page.title}`);
      continue;
    }

    const content = page.revisions?.[0]?.slots?.main?.content ?? page.revisions?.[0]?.content ?? '';
    const dir = path.dirname(relPath);
    fs.mkdirSync(dir, { recursive: true });

    fs.writeFileSync(relPath, content, 'utf8');
    console.log(`[SYNCED] ${page.title} -> ${relPath} (${Buffer.byteLength(content, 'utf8')} bytes)`);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
