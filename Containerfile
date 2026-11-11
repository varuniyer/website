FROM ghcr.io/gohugoio/hugo:latest AS render
WORKDIR /src
COPY --chown=hugo:hugo . .
RUN hugo build --minify && mv public/publications/publications.tex public/*.tex /src/


FROM docker.io/library/alpine:latest AS precompress

RUN apk add --no-cache gzip brotli

WORKDIR /work
COPY --from=render /src/public ./public

RUN find public -type f \( -name '*.html' -o -name '*.xml' -o -name '*.css' -o -name '*.js' \) \
    -exec gzip --best --keep {} \; -exec brotli {} \;


FROM quay.io/fedora/fedora:latest AS cv
RUN dnf install -y --setopt=minrate=100k texlive-luahbtex texlive-luaotfload texlive-latex texlive-fontspec texlive-geometry texlive-titlesec texlive-graphics texlive-enumitem texlive-hyperref texlive-bookmark texlive-ulem texlive-sourceserif texlive-amsfonts
WORKDIR /cv
COPY cv/CV.tex .
COPY --from=render /src/*.tex .
RUN lualatex -interaction=nonstopmode -halt-on-error CV.tex


# The built tree, which bootc-setup's Caddy serves.
FROM scratch
COPY --from=precompress /work/public /
COPY --from=cv /cv/CV.pdf /CV.pdf
