// Myers LCS algorithm for line-by-line diffing and non-destructive merging

export function get_lcs(a : string[], b : string[]) : Array<{ a_index : number; b_index : number }> {
    const m = a.length;
    const n = b.length;
    const dp : number[][] = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (a[i - 1] === b[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
            };
        };
    };

    let i = m;
    let j = n;
    const matches : Array<{ a_index : number; b_index : number }> = [];

    while (i > 0 && j > 0) {
        if (a[i - 1] === b[j - 1]) {
            matches.unshift({ a_index: i - 1, b_index: j - 1 });
            i--;
            j--;
        } else if (dp[i - 1][j] >= dp[i][j - 1]) {
            i--;
        } else {
            j--;
        };
    };

    return matches;
};

export type diff_chunk =
    | { type : 'equal'; line : string }
    | { type : 'change'; a : string[]; b : string[] };

export function diff_lines(a : string[], b : string[]) : diff_chunk[] {
    const matches = get_lcs(a, b);
    const chunks : diff_chunk[] = [];
    let a_pos = 0;
    let b_pos = 0;

    for (const m of matches) {
        if (a_pos < m.a_index || b_pos < m.b_index) {
            chunks.push({
                type: 'change',
                a: a.slice(a_pos, m.a_index),
                b: b.slice(b_pos, m.b_index),
            });
        };
        chunks.push({
            type: 'equal',
            line: a[m.a_index],
        });
        a_pos = m.a_index + 1;
        b_pos = m.b_index + 1;
    };

    if (a_pos < a.length || b_pos < b.length) {
        chunks.push({
            type: 'change',
            a: a.slice(a_pos),
            b: b.slice(b_pos),
        });
    };

    return chunks;
};

/**
 * Merge repository content with live wiki content line-by-line:
 * - Checks line-by-line between repo (a) and wiki (b).
 * - If there is a difference or wiki has added stuff, DO NOT TOUCH (preserve wiki lines).
 * - If there is no difference (equal line), keep/override that line only.
 * - If repo has newly added lines (not in wiki), append them.
 */
export function merge_preserving_wiki_edits(repo_text : string, wiki_text : string | null | undefined) : string {
    if (!wiki_text || wiki_text === repo_text) {
        return repo_text;
    };

    const repo_lines = repo_text.split('\n');
    const wiki_lines = wiki_text.split('\n');

    const chunks = diff_lines(repo_lines, wiki_lines);
    const result : string[] = [];

    for (const chunk of chunks) {
        if (chunk.type === 'equal') {
            result.push(chunk.line);
        } else {
            if (chunk.b.length > 0) {
                // Wiki has modified or added lines: DO NOT TOUCH, preserve wiki content
                result.push(...chunk.b);
            } else if (chunk.a.length > 0) {
                // Repo has new additions: incorporate them
                result.push(...chunk.a);
            };
        };
    };

    return result.join('\n');
};

export function normalize_site_key(key : string) : string {
    return key.toLowerCase().replace(/[-_]/g, '').trim();
};

export function matches_site_id(prefix : string, site_id : string, site_host ?: string) : boolean {
    const p = normalize_site_key(prefix);
    const s = normalize_site_key(site_id);
    if (p === s || prefix.toLowerCase().trim() === site_id.toLowerCase().trim()) return true;

    if (site_host) {
        const host_sub = normalize_site_key(site_host.split('.')[0]);
        if (p === host_sub) return true;
    };
    return false;
};

/**
 * Transform interwiki / internationalisation tags in wikitext:
 * - Checks tags directly against the site IDs and hosts configured in wikiwire.toml.
 * - Prepends [[en:PAGEHERE]] before all tags (since English is the original version).
 * - Checks the target site ID in wikiwire config and removes self-referential tags (e.g. [[zh:...]] for zh).
 */
export function transform_interwiki_tags(
    content : string,
    target_site_id : string,
    target_site_host ?: string,
    known_site_ids ?: Iterable<string>
) : string {
    const INTERWIKI_TAG_REGEX = /\[\[([a-zA-Z0-9_-]+):([^\]|\n]+)(?:\|[^\]\n]*)?\]\]/g;

    const site_keys = new Set<string>(['en']);
    if (known_site_ids) {
        for (const id of known_site_ids) {
            site_keys.add(normalize_site_key(id));
            site_keys.add(id.toLowerCase().trim());
        };
    } else {
        site_keys.add(normalize_site_key(target_site_id));
        site_keys.add(target_site_id.toLowerCase().trim());
        if (target_site_host) {
            site_keys.add(normalize_site_key(target_site_host.split('.')[0]));
        };
    };

    const matches : Array<{
        full_match : string;
        prefix : string;
        title : string;
        index : number;
        length : number;
    }> = [];

    let match : RegExpExecArray | null;
    while ((match = INTERWIKI_TAG_REGEX.exec(content)) !== null) {
        const prefix = match[1];
        const normalized = normalize_site_key(prefix);
        if (site_keys.has(normalized) || site_keys.has(prefix.toLowerCase().trim())) {
            matches.push({
                full_match : match[0],
                prefix : match[1],
                title : match[2].trim(),
                index : match.index,
                length : match[0].length,
            });
        };
    };

    if (matches.length === 0) return content;

    const first_match = matches[0];
    const last_match = matches[matches.length - 1];
    const page_title = matches[0].title;

    const is_target_en = matches_site_id('en', target_site_id, target_site_host);

    const remaining_tags : string[] = [];
    if (!is_target_en) {
        remaining_tags.push(`[[en:${page_title}]]`);
    };

    for (const m of matches) {
        if (matches_site_id(m.prefix, target_site_id, target_site_host)) continue;
        if (matches_site_id(m.prefix, 'en')) continue;
        remaining_tags.push(`[[${m.prefix}:${m.title}]]`);
    };

    const start_pos = first_match.index;
    const end_pos = last_match.index + last_match.length;

    return content.slice(0, start_pos) + remaining_tags.join('\n') + content.slice(end_pos);
};
