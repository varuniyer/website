# AGENTS.md

## Shell style

- Keep commands compact, 1-2 lines. Don't split into one-flag-per-line backslash continuations.

## Git

- Run `git log -1` before any `git commit --amend`. The user makes commits between turns, so HEAD may not be the commit you expect.
- Remove tracked files with `git rm`, not plain `rm`.
- When one "commit" instruction covers several changes from the conversation, write one combined commit instead of per-subsystem splits.

## CI

- CI builds with `podman build --layers=false`. Don't suggest docker buildx, `--cache-from`, or other layer caching. The publish job runs in under 2 minutes, so caching has little to save.

## Publishing

- The repo stays public, nothing may depend on the `site` branch's history, and `layouts/404.html` keeps its name. README.md says why.
- `GH_WORKFLOW_TOKEN` is the same PAT that bootc-setup's Cloud Scheduler job `bootc-build` holds. Rotate it with bootc-setup's README snippet for the PAT, which updates both copies.

## Rulings

The author settled these on 2026-11-10 while applying an audit. Treat each as decided, and raise one again only when the code it describes changes.

- README.md owns the publishing facts and their reasons. AGENTS.md keeps only the prohibitions.
- `params.author` in `hugo.toml` holds the owner's name, and every template reads it there. The site has no `title` key, and the `rss` kind is disabled.
- `data/contact.yaml` and `data/positions.yaml` are the one source for the contact links and positions that the site and the CV both state. The bio, the CV bullets, and the phone number stay hand-written, and only the CV shows the phone.
- Every `data/publications.yaml` row states `selected` explicitly, since the homepage shows the selected subset.
- Both author lists follow the Chicago join (`A and B`, `A, B, and C`), and the equal-contribution star sits outside the bolded owner name.
- Each equal-contribution legend appears only when a listed author carries the mark.
- `.nav-link`, `.mobile-nav-toggle`, and `.contact-link` share one hover background and one 0.15s fade. `--color-hover-bg` stays a named palette token with one reference.
- The CV compiles in one lualatex pass with `bookmark`.
- `publish.yml` carries no comment on why it dispatches through the API.
- `static/robots.txt` stays as an explicit allow-all policy.
- The published branch is `site`, written in code quotes in prose, comments, and the publish step's name, where Actions shows the backticks literally.
- `.containerignore` lists only `built`.
- Publication records store `year` alone, because no reader uses the month.
- The CV names the satellite system Elasticsearch throughout.
- The profile photo does not stick on scroll.
- The breakpoint queries use `not all and (min-width: 768px)` and `(min-width: 768px)`, because range syntax needs Safari 16.4 while the stylesheet's `:has()` works from Safari 15.4.
- The role line links "Computer Science" to `https://cs.uic.edu/`, with the URL in the template, and it may wrap to two lines.
- Output formats and CV fragments are named for what they hold (`publications`, `author`, `contact`, `education`, `experience`), and the site's link row uses the `contact-*` classes.
- The build fails on an Anthology author with no family name and on a contact URL holding `\`, `{`, `}`, or `^`.
- The BLooP bullet claims ROUGE and BARTScore gains on CNN/DM, CCSum, Multi-News, and SciTLDR scientific abstracts, because the paper reports ROUGE gains on SciTLDR only for abstract input.
