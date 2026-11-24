# website

Hugo source for the public site and LaTeX source for its CV. Caddy in the `bootc-sealed-vm` image serves the built tree.

The `publish` workflow runs on manual dispatch and on each push to `main` that changes a file other than `README.md`, `AGENTS.md`, and `LICENSE`. It builds `Containerfile`, which renders the Hugo site, precompresses its frontend code with gzip and Brotli, and compiles `cv/CV.tex` into `CV.pdf`. It then packs the built tree into `site.tar.gz`, attests the tarball with GitHub's build provenance, and replaces the `site-tarball` release's copy. The [bootc-sealed-vm](https://github.com/varuniyer/bootc-sealed-vm) build accepts the tarball only when the attestation verifies as this repo's `publish` workflow, so the image carries a site this workflow built. That build runs daily, so a change to the site goes live with the next one. A run takes 1.5 to 3 minutes, so layer caching has little to save.

The release keeps only the newest tarball, and the `bootc-sealed-vm` build reads its attestation from this public repo.

## Layout

- `hugo.toml`, `assets/`, `content/`, `data/`, `layouts/`, `static/`: Hugo source, including the `404.html` page Caddy serves for unknown paths. `data/publications.yaml` lists publications by ACL Anthology ID, and each build fetches their MODS documents from the Anthology.
- `cv/CV.tex`: LaTeX source of `CV.pdf`, compiled with the author name, contact links, positions, and publication list that the Hugo build generates.

To build locally, run `rm -rf built && podman build -o built .` and inspect `built/`.
