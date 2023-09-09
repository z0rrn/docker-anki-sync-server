# SPDX-FileCopyrightText: 2023 Frederik Zorn <federdaemn@mail.de>
#
# SPDX-License-Identifier: Apache-2.0

# use the official Rust image with debian base as builder
FROM docker.io/library/rust:latest as builder

# Set build directory (like cd)
WORKDIR /build

# upgrade system a. install dependency
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install protobuf-compiler -y

RUN \
  cargo install --root /app \
  --git https://github.com/ankitects/anki.git --tag 2.1.66 \
  anki-sync-server

# copy binary to debian-slim container to reduce container size
FROM docker.io/library/debian:stable-slim

# copy binary from builder
COPY --from=builder /app/bin/anki-sync-server /app/bin/anki-sync-server

# create directory for anki config
RUN mkdir -p /config

# stores data in /config (VOLUME for persistence)
ENV SYNC_BASE="/config"

# set default port
ENV SYNC_PORT="27701"

# don't forget to set at least SYNC_USER1
CMD [ "/app/bin/anki-sync-server" ]
