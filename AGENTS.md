# AGENTS.md

## Shell style

- Keep commands compact, 1-2 lines. Don't split into one-flag-per-line backslash continuations.

## Git

- Run `git log -1` before any `git commit --amend`. The user makes commits between turns, so HEAD may not be the commit you expect.
- Remove tracked files with `git rm`, not plain `rm`.
- When one "commit" instruction covers several changes from the conversation, write one combined commit instead of per-subsystem splits.

## CI

- Don't suggest docker buildx, `--cache-from`, or other layer caching for CI. README.md says why.

## Publishing

- The repo stays public, nothing may depend on the `site` branch's history, and `layouts/404.html` keeps its name. README.md says why.
- Rotate `GH_WORKFLOW_TOKEN` only with bootc-setup's README snippet for the PAT. README.md says why.

## Rulings

The author settled these on 2026-11-10 while applying an audit. Treat each as decided, and raise one again only when the code it describes changes.

- README.md owns the publishing facts and their reasons. AGENTS.md keeps only the prohibitions.
- `params.author` in `hugo.toml` holds the author's name, and every template reads it there. The site has no `title` key, and the `rss` kind is disabled.
- `data/contact.yaml` and `data/positions.yaml` are the one source for the contact links and positions that the site and the CV both state. The bio, the CV bullets, and the phone number stay hand-written, and only the CV shows the phone.
- Every `data/publications.yaml` row states `selected` explicitly, since the homepage shows the selected subset.
- Both author lists follow the Chicago join (`A and B`, `A, B, and C`), and the equal-contribution star sits outside the author's bolded name.
- Each equal-contribution legend appears only when a listed author carries the star.
- `.nav-link`, `.mobile-nav-toggle`, and `.contact-link` share one hover background, one border radius, and one 0.15s fade, and `.bio a` shares that fade duration. `--color-hover-bg` stays a named palette token with one reference.
- The CV compiles in one lualatex pass with `bookmark`.
- `publish.yml` carries no comment on why it dispatches through the API.
- `static/robots.txt` stays as an explicit allow-all policy.
- The published branch is `site`, written in code quotes in prose, comments, and the publish step's name, where Actions shows the backticks literally.
- `.containerignore` lists only `.git` and `built`.
- Publication records store `year` alone, because no reader uses the month.
- The CV names the satellite system Elasticsearch throughout.
- The profile photo scrolls with the page.
- The breakpoint queries use `not all and (min-width: 768px)` and `(min-width: 768px)`, because range syntax needs Safari 16.4 while the stylesheet's `:has()` works from Safari 15.4.
- The degree line links "Computer Science" to `https://cs.uic.edu/`, with the URL in the template, and it may wrap to two lines.
- Output formats and CV fragments are named for what they hold (`publications`, `author`, `contact`, `education`, `experience`), and the site's contact links use the `contact-*` classes.
- The build fails on an Anthology author with no family name, on a paper whose authors include no match for `params.author`, on a `selected` value other than `true` or `false`, on a contact URL or email holding `\`, `{`, `}`, or `^`, and on a TeX special character in education row 0's organization, degree, or discipline.
- The BLooP bullet claims ROUGE and BARTScore gains on CNN/DM, CCSum, Multi-News, and SciTLDR scientific abstracts, because the paper reports ROUGE gains on SciTLDR only for abstract input.
- The AMRPG bullet claims the best BLEU among the tested unsupervised syntactically controlled paraphrase generators, because the paper's Table 1 compares AMRPG against three such models.
- The per-author flag marking the site's author is `is_me`, and prose calls that person the author.
- `equal_contributors` lists 0-based byline positions, and `data/publications.yaml` carries no comment saying so.
- The homepage headline is the degree line (`.about-degree`), since `role` names an experience title. It and the bio both say "the University of Illinois Chicago".
- The contact partial is `contact.html`, named for `data/contact.yaml`.
- The CV writes each position with `\subheading` inside a `subheadinglist` environment defined by `\newenvironment`, because enumitem's `\newlist` gives the list its own depth and drops the nested bullets' `\labelitemii` and `\setlist[itemize,2]` styling.
- README.md says the build precompresses the site's frontend code and leaves the file types to the Containerfile's `find` pattern.
- The stylesheet writes each square box as `width` plus `aspect-ratio: 1`. `--gutter` and `--nav-link-inset` state that the header name's text aligns with the main content's edge.
