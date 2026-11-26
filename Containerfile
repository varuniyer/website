FROM ghcr.io/gohugoio/hugo:v0.170.1@sha256:4cc9f383086c0fba180efcf7132cf2f025969c462fedf5fcd2bf921915416797 AS render
WORKDIR /src
COPY --chown=hugo:hugo . .
RUN hugo build --minify && mv public/publications/publications.tex public/*.tex /src/


FROM docker.io/library/alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS precompress

RUN apk add --no-cache gzip brotli

WORKDIR /work
COPY --from=render /src/public ./public

RUN find public -type f \( -name '*.html' -o -name '*.xml' -o -name '*.css' -o -name '*.js' \) \
    -exec gzip --best --keep {} \; -exec brotli {} \;


FROM quay.io/fedora/fedora:45@sha256:92837d4834c1cff45cc2d534b655489b8e536271de1897932117e396cc9980c5 AS cv
RUN dnf install -y --setopt=minrate=100k texlive-luahbtex texlive-luaotfload texlive-latex texlive-fontspec texlive-geometry texlive-titlesec texlive-graphics texlive-enumitem texlive-hyperref texlive-bookmark texlive-ulem texlive-sourceserif texlive-amsfonts
WORKDIR /cv
COPY cv/CV.tex .
COPY --from=render /src/*.tex .
RUN lualatex -interaction=nonstopmode -halt-on-error CV.tex


# The built tree, which bootc-sealed-vm's Caddy serves.
FROM scratch
COPY --from=precompress /work/public /
COPY --from=cv /cv/CV.pdf /CV.pdf
