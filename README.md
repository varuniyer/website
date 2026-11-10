# website

Hugo source for the public site and LaTeX source for its CV. The `bootc-setup` image serves the result.

The `publish` workflow runs on each push to `main` and on manual dispatch. It builds `Containerfile`, which renders the Hugo site, precompresses it with gzip and Brotli, and compiles `cv/CV.tex` into `CV.pdf`. It then replaces the `static` branch with a single commit of the built tree and dispatches the [bootc-setup](https://github.com/varuniyer/bootc-setup) build, which copies that branch into the image. The dispatch reads the `GH_WORKFLOW_TOKEN` Actions secret, which `bootc-setup`'s `provision.sh` sets.

The repo must stay public, because the `bootc-setup` build downloads the `static` branch without authentication.

## Layout

- `hugo.toml`, `assets/`, `content/`, `data/`, `layouts/`, `static/`: Hugo source, including the `404.html` page Caddy serves for unknown paths. `data/publications.yaml` lists papers by ACL Anthology ID, and each build fetches their records from the Anthology.
- `cv/CV.tex`: LaTeX source of `CV.pdf`, compiled with the publication list that the Hugo build generates.

To build locally, run `rm -rf public && podman build -o public .` and inspect `public/`.
