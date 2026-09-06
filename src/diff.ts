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
