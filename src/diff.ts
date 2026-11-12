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

type merge_hunk = {
    start : number;
    length : number;
    lines : string[];
};

function diff_hunks(base : string[], side : string[]) : merge_hunk[] {
    const chunks = diff_lines(base, side);
    const hunks : merge_hunk[] = [];
    let base_pos = 0;

    for (const chunk of chunks) {
        if (chunk.type === 'equal') {
            base_pos += 1;
            continue;
        };

        hunks.push({ start: base_pos, length: chunk.a.length, lines: chunk.b });
        base_pos += chunk.a.length;
    };

    return hunks;
};

function same_lines(a : string[], b : string[]) : boolean {
    if (a.length !== b.length) return false;

    for (let i = 0; i < a.length; i++) {
        if (a[i] !== b[i]) return false;
    };

    return true;
};

function normalize_newlines(text : string) : string {
    return text.replace(/\r\n/g, '\n');
};

/**
 * Three-way line merge: base is the repository revision that was last synced,
 * repo is the current repository content and wiki is the live wiki content.
 *
 * - Lines only changed in the repo follow the repo (including deletions).
 * - Lines only changed on the wiki stay as the wiki has them.
 * - Lines changed on both sides are left alone (wiki wins).
 * - Additions at the same spot are combined so both sides keep their new content.
 */
export function merge_three_way(base_text : string, repo_text : string, wiki_text : string) : string {
    const base = base_text.split('\n');
    const repo = repo_text.split('\n');
    const wiki = wiki_text.split('\n');

    const repo_hunks = diff_hunks(base, repo);
    const wiki_hunks = diff_hunks(base, wiki);
    const result : string[] = [];

    let cursor = 0;
    let repo_index = 0;
    let wiki_index = 0;

    while (repo_index < repo_hunks.length || wiki_index < wiki_hunks.length) {
        const next_repo = repo_index < repo_hunks.length ? repo_hunks[repo_index].start : Number.POSITIVE_INFINITY;
        const next_wiki = wiki_index < wiki_hunks.length ? wiki_hunks[wiki_index].start : Number.POSITIVE_INFINITY;
        const region_start = Math.min(next_repo, next_wiki);

        while (cursor < region_start) {
            result.push(base[cursor]);
            cursor += 1;
        };

        // Group hunks from both sides that overlap the same base region.
        let region_end = region_start;
        const repo_group : merge_hunk[] = [];
        const wiki_group : merge_hunk[] = [];

        let expanded = true;
        while (expanded) {
            expanded = false;

            if (repo_index < repo_hunks.length && (repo_hunks[repo_index].start === region_start || repo_hunks[repo_index].start < region_end)) {
                const hunk = repo_hunks[repo_index];
                repo_group.push(hunk);
                region_end = Math.max(region_end, hunk.start + hunk.length);
                repo_index += 1;
                expanded = true;
            };

            if (wiki_index < wiki_hunks.length && (wiki_hunks[wiki_index].start === region_start || wiki_hunks[wiki_index].start < region_end)) {
                const hunk = wiki_hunks[wiki_index];
                wiki_group.push(hunk);
                region_end = Math.max(region_end, hunk.start + hunk.length);
                wiki_index += 1;
                expanded = true;
            };
        };

        const repo_lines = repo_group.flatMap((hunk) => hunk.lines);
        const wiki_lines = wiki_group.flatMap((hunk) => hunk.lines);

        if (repo_group.length === 0) {
            // Only the wiki changed here.
            result.push(...wiki_lines);
        } else if (wiki_group.length === 0) {
            // Only the repo changed here: follow the repo, including deletions.
            result.push(...repo_lines);
        } else if (same_lines(repo_lines, wiki_lines)) {
            result.push(...repo_lines);
        } else {
            const repo_insert_only = repo_group.every((hunk) => hunk.length === 0);
            const wiki_insert_only = wiki_group.every((hunk) => hunk.length === 0);

            if (repo_insert_only || wiki_insert_only) {
                // Both sides added content at the same place: keep both.
                result.push(...repo_lines, ...wiki_lines);
            } else {
                // Both sides rewrote the same lines: mind our own business and keep the wiki.
                result.push(...wiki_lines);
            };
        };

        cursor = region_end;
    };

    while (cursor < base.length) {
        result.push(base[cursor]);
        cursor += 1;
    };

    return result.join('\n');
};

/**
 * Merge repository content with live wiki content.
 *
 * When the previously synced repository revision (base) is known, a three-way
 * merge is used so repo-side edits and deletions are followed unless the wiki
 * also touched the same lines. Without a base, fall back to a conservative
 * two-way merge: equal lines follow the repo, differing wiki lines are kept and
 * repo additions are incorporated.
 */
export function merge_preserving_wiki_edits(repo_text : string, wiki_text : string | null | undefined, base_text ?: string | null) : string {
    if (wiki_text === null || wiki_text === undefined || wiki_text === repo_text) {
        return repo_text;
    };

    const repo = normalize_newlines(repo_text);
    const wiki = normalize_newlines(wiki_text);

    if (base_text !== null && base_text !== undefined) {
        const base = normalize_newlines(base_text);

        // The repo did not change since the last sync: leave the wiki untouched.
        if (base === repo) return wiki;

        // The wiki did not change since the last sync: take the repo verbatim.
        if (base === wiki) return repo;

        return merge_three_way(base, repo, wiki);
    };

    const repo_lines = repo.split('\n');
    const wiki_lines = wiki.split('\n');

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
