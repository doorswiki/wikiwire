import fs from 'node:fs';
import path from 'node:path';

const UPSTREAM_API = 'https://doorsgame.wiki/w/api.php';
const LANG_API = 'https://zh.doorsgame.wiki/w/api.php';

const PAGES = {
  // MediaWiki namespace
  'MediaWiki:Common.css': 'mediawiki/shared-lang/Common.css',
  'MediaWiki:Common.js': 'mediawiki/shared-lang/Common.js',
  'MediaWiki:Citizen.css': 'mediawiki/shared-lang/Citizen.css',
  'MediaWiki:Citizen-preferences.json': 'mediawiki/shared-lang/Citizen-preferences.json',
  'MediaWiki:Gadget-SpoilersByDefault': 'mediawiki/shared-lang/Gadget-SpoilersByDefault',
  'MediaWiki:Gadget-SpoilersByDefault.js': 'mediawiki/shared-lang/Gadget-SpoilersByDefault.js',
  'MediaWiki:Gadgets-definition': 'mediawiki/shared-lang/Gadgets-definition',
  'MediaWiki:Main page.js': 'mediawiki/shared-lang/Main page.js',
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

async function fetchWikiPages(apiUrl, titles) {
  const params = new URLSearchParams({
    action: 'query',
    prop: 'revisions',
    titles,
    rvprop: 'content',
    rvslots: '*',
    format: 'json',
    formatversion: '2',
  });

  const res = await fetch(`${apiUrl}?${params.toString()}`, {
    headers: { 'User-Agent': 'WikiWire-Sync/1.0' },
  });

  if (!res.ok) {
    throw new Error(`Failed to fetch from ${apiUrl}: ${res.status} ${res.statusText}`);
  }

  const data = await res.json();
  const map = {};
  for (const page of data.query?.pages ?? []) {
    if (!page.missing) {
      map[page.title] = page.revisions?.[0]?.slots?.main?.content ?? page.revisions?.[0]?.content ?? '';
    }
  }
  return map;
}

async function main() {
  const titles = Object.keys(PAGES).join('|');

  console.log('Fetching upstream pages from doorsgame.wiki and language wiki...');
  const [upstreamPages, langPages] = await Promise.all([
    fetchWikiPages(UPSTREAM_API, titles),
    fetchWikiPages(LANG_API, titles).catch((err) => {
      console.warn(`[WARN] Could not fetch from language wiki: ${err.message}`);
      return {};
    }),
  ]);

  for (const [title, relPath] of Object.entries(PAGES)) {
    const upstreamContent = upstreamPages[title];
    if (upstreamContent === undefined) {
      console.warn(`[WARN] Page does not exist upstream: ${title}`);
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

    if (existingContent && existingContent !== upstreamContent) {
      console.log(`[SYNCED (MERGED)] ${title} -> ${relPath} (preserved language modifications)`);
    } else {
      console.log(`[SYNCED] ${title} -> ${relPath} (${Buffer.byteLength(finalContent, 'utf8')} bytes)`);
    }
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
