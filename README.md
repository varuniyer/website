# website

Hugo source for the public site and LaTeX source for its CV. Caddy in the `bootc-sealed-vm` image serves the built tree.

The primary copy lives in the CodeCommit repository that the [bootc-sealed-vm](https://github.com/varuniyer/bootc-sealed-vm) stack creates, and this GitHub repository mirrors it. Each bootc-sealed-vm build clones `main` from CodeCommit and builds `Containerfile`, which renders the Hugo site, precompresses its frontend code with gzip and Brotli, and compiles `cv/CV.tex` into `CV.pdf`. A push to `main` in CodeCommit starts a build, and the VM applies the new image at its next hourly update. Each build runs on a fresh instance, so it builds every layer.

`Containerfile` pins each base image by tag and digest, because the bootc-sealed-vm build checks no signature on them. The digest holds each build to the images a commit names, so updating an image takes a commit that changes its tag and digest.

## Layout

- `hugo.toml`, `assets/`, `content/`, `data/`, `layouts/`, `static/`: Hugo source, including the `404.html` page Caddy serves for unknown paths. `data/publications.yaml` lists publications by ACL Anthology ID, and each build fetches their MODS documents from the Anthology.
- `cv/CV.tex`: LaTeX source of `CV.pdf`, compiled with the author name, contact links, positions, and publication list that the Hugo build generates.

To build locally, run `rm -rf built && podman build -o built .` and inspect `built/`.
