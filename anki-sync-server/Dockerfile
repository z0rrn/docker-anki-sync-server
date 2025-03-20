# use the official rust image with debian base as builder
FROM --platform=$BUILDPLATFORM docker.io/library/rust:latest as builder

# retrieve software version from cli (--build-arg)
ARG software_version

# make multi-platform args available to process
ARG TARGETARCH
ARG TARGETVARIANT

# create empty directory (to be copied into scratch image) a. see script
COPY ../tools/convert-arch-cargo.sh .
RUN mkdir /empty && sh ./convert-arch-cargo.sh

# upgrade system and install dependencies:
# protocol buffer compiler + gcc/g++ compiler for specific arch
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install protobuf-compiler $(cat /.c-compiler.txt) -y

# git clone source repository of anki (only last commit, init submodules)
RUN \
  git clone --recurse-submodules --depth 1 --branch $software_version \
    https://github.com/ankitects/anki.git \
    /build

# set build directory (like cd)
WORKDIR /build

# build anki-sync-server
# install needed rustup targets
# set PROTOC to use the installed protobuf compiler (error if not set)
# set linker for specific arch (https://github.com/rust-lang/rust/issues/28924#issuecomment-442260036)
# (use export because other things don't work)

# set RUSTFLAGS (--target needed) to build static binary
# source: https://msfjarvis.dev/posts/building-static-rust-binaries-for-linux/

# build with release optimizations
# copy binary to standard dir (use cargo build --out when stable)
RUN \
  rustup target add $(cat /.cargo-platform.txt) && \
  export $(cat /.cargo-linker.txt) && \
  PROTOC=/usr/bin/protoc RUSTFLAGS='-C target-feature=+crt-static' \
    cargo build --release --target $(cat /.cargo-platform.txt) \
    --package anki-sync-server && \
  mkdir -p /output && \
  cp /build/target/$(cat /.cargo-platform.txt)/release/anki-sync-server /output/anki-sync-server

# copy binary container with nothing other to reduce container size
FROM scratch

# copy /etc/passwd because docker cannot create one in a scratch container
COPY tools/minimal-passwd.txt /etc/passwd

# copy empty directory to anki config dir (make accessible for the user)
COPY --from=builder --chown=65534:65534 /empty /config

# copy binary from builder
COPY --from=builder /output/anki-sync-server /app/anki-sync-server

ENV \
# stores data in /config (VOLUME for persistence)
  SYNC_BASE="/config" \
# set default port
  SYNC_PORT="27701"

# switch user for better security
USER scratch-user

# don't forget to set at least SYNC_USER1
CMD [ "/app/anki-sync-server" ]

# set labels required for artifacthub.io
LABEL \
# opencontainer labels specified
# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
  "org.opencontainers.image.title"="anki-sync-server" \
  "org.opencontainers.image.description"="Anki Sync Server (anki-sync-server) docker/oci container" \
  "org.opencontainers.image.authors"="Frederik Zorn <fz@zorrn.net>" \
  "org.opencontainers.image.source"="https://github.com/z0rrn/docker-anki-sync-server" \
  "org.opencontainers.image.licenses"="AGPL-3.0-or-later"
