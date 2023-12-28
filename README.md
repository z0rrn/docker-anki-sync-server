<!--
SPDX-FileCopyrightText: 2023 Frederik Zorn <fz@zorrn.net>

SPDX-License-Identifier: Apache-2.0
-->

# docker anki-sync-server repository

This contains a dockerfile and CI/CD scripts to build a container image for
[Anki Sync Server](https://apps.ankiweb.net/) using a scratch image as base
image.

## Warning

This image is not official. Use at your own risk.

## Images

## Host Architecture

This image is cross-compiled and thus available for

- linux/amd64
- linux/arm64

I sadly can not build for linux/arm/v7
(because of [build errors](https://github.com/rust-lang/cargo/issues/9545#issue-911773248))
and for linux/riscv64 (because of missing
[rust](https://hub.docker.com/_/rust/tags) container support).

## Updates and Versions

- The container is auto-updated every Monday whenever a new version of anki is
  released. This is done by a GitHub Action and happens without any manual
  intervention or review.
- The actions are also auto-updated through dependabot.
- The image which is used to build is always the latest version of Debian Linux.

Result: The container is always up-to-date (at least after every Monday) and I
can forget this project exists :).

## Hosting

### Git

This project is hosted on [GitHub](https://github.com) at the
[z0rrn/docker-anki-sync-server](https://github.com/z0rrn/docker-anki-sync-server)
project.

### Container Registry

You can find this image on
[GitHub Container Registry](https://github.com/z0rrn/docker-anki-sync-server/pkgs/container/anki-sync-server)
(recommended) and on
[Docker Hub](https://hub.docker.com/r/zorrn/anki-sync-server) for
redundancy.

There are four tags available:

- `latest`: Always the latest version of anki.
- `<anki-version>`: The version specified of anki.
- `<time-of-build>`: The exact time (+ date) when the container was built
  (using (`date` syntax): %Y-%m-%dt%H-%M-%Sz).

## Setup

- See SETUP.md for detailed instructions.

## Contributing

- Contributions for newer versions or files are gracefully accepted. Even things
  like small speed improvements are helpfull.
- Please try to wrap all lines at 80 characters.

## License

TL;DR before we dive in to legalese:

- Most files are licensed under Apache-2.0, unless noted in the file header or
  the `.reuse/dep5` file.
- For contributors who wish to send patches, an agreement to the
  [DCO](https://developercertificate.org/) (via `--signoff` flag on commits) is
  required.
