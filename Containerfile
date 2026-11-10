FROM ghcr.io/gohugoio/hugo:latest AS hugo
WORKDIR /src
COPY --chown=hugo:hugo . .
RUN hugo build --minify && mv public/publications/publications.tex /src/


FROM docker.io/library/alpine:latest AS compress

RUN apk add --no-cache gzip brotli

WORKDIR /work
COPY --from=hugo /src/public ./public

RUN find public -type f \( -name '*.html' -o -name '*.xml' -o -name '*.css' -o -name '*.js' \) \
    -exec gzip --best --keep {} \; -exec brotli --best --keep {} \;


FROM quay.io/fedora/fedora:latest AS cv
RUN dnf install -y texlive-luahbtex texlive-luaotfload texlive-latex texlive-fontspec texlive-preprint texlive-titlesec texlive-graphics texlive-enumitem texlive-hyperref texlive-babel texlive-babel-english texlive-ulem texlive-sourceserif texlive-amsfonts
WORKDIR /cv
COPY cv/CV.tex .
COPY --from=hugo /src/publications.tex .
RUN lualatex -interaction=nonstopmode -halt-on-error CV.tex && lualatex -interaction=nonstopmode -halt-on-error CV.tex


# The served tree, which the publish workflow exports with `podman build -o`.
FROM scratch
COPY --from=compress /work/public /
COPY --from=cv /cv/CV.pdf /CV.pdf
