# AGENTS.md

## Shell style

- Keep commands compact, 1-2 lines. Don't split into one-flag-per-line backslash continuations.

## Git

- Run `git log -1` before any `git commit --amend`. The user makes commits between turns, so HEAD may not be the commit you expect.
- Remove tracked files with `git rm`, not plain `rm`.
- When one "commit" instruction covers several changes from the conversation, write one combined commit instead of per-subsystem splits.

## CI

- CI builds with `podman build --layers=false`. Don't suggest docker buildx, `--cache-from`, or other layer caching. The whole publish job runs in under 2 minutes, so caching has little to save.

## Publishing

- The repo stays public. bootc-setup's `website` stage downloads the `static` branch tarball from codeload.github.com without authentication.
- Each publish run replaces `static` with one orphan commit of the built tree. Nothing may depend on that branch's history.
- `GH_WORKFLOW_TOKEN` is the same PAT the `bootc-build` Cloud Scheduler job in bootc-setup holds. Rotate it with bootc-setup's README PAT snippet, which updates both copies.
- bootc-setup's Caddyfile rewrites unknown paths to `/404.html`, so `layouts/404.html` keeps its name.
