# SPDX-FileCopyrightText: 2023 Frederik Zorn <federdaemn@mail.de>
#
# SPDX-License-Identifier: Apache-2.0

# use the official Rust image with debian base as builder
FROM docker.io/library/rust:latest as builder

# set anki version
ARG anki_version

# upgrade system a. install dependency
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install protobuf-compiler -y

# git clone source repository of anki (only last commit, init submodules)
RUN \
  git clone https://github.com/ankitects/anki.git \
    --branch $anki_version --depth 1 --recurse-submodules \
    /build

# Set build directory (like cd)
WORKDIR /build

# build anki-sync-server
# set PROTOC to use the installed protobuf compiler (error if not set)

# set RUSTFLAGS (--target needed) to build static binary
# source: https://msfjarvis.dev/posts/building-static-rust-binaries-for-linux/

# build with release optimizations
RUN \
  PROTOC=/usr/bin/protoc RUSTFLAGS='-C target-feature=+crt-static' \
    cargo build --release --target x86_64-unknown-linux-gnu \
    --package anki-sync-server

# copy binary to debian-slim container to reduce container size
FROM docker.io/library/debian:stable-slim

# copy binary from builder
COPY --from=builder /build/target/x86_64-unknown-linux-gnu/release/anki-sync-server /app/anki-sync-server

ENV \
# stores data in /config (VOLUME for persistence)
  SYNC_BASE="/config" \
  
# set default port
  SYNC_PORT="27701"

# don't forget to set at least SYNC_USER1
CMD [ "/app/anki-sync-server" ]
