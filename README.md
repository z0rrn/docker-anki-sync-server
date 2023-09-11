<!--
SPDX-FileCopyrightText: 2023 Frederik Zorn <federdaemn@mail.de>

SPDX-License-Identifier: Apache-2.0
-->

# oci-anki-sync (anki-sync-server docker container) repository

This contains a Dockerfile and Ci scripts to build a container image for
[Anki](https://apps.ankiweb.net/) using Alpine Linux as base image.

## Updates and Versions

* The container is auto-updated every Monday whenever a new version of anki is
  released. This is done by a GitHub Action and happens without any manual
  intervention or review.
* The actions are also auto-updated through dependabot.
* The base image is always the latest version of Debian Linux.

Result: The container is always up-to-date (atleast after every monday) and I
can forget this project exists :).

## Hosting

### Git

This project is hosted on [GitHub](https://github.com) at the
[federdaemn/oci-anki-sync](https://github.com/federdaemn/oci-anki-sync) project.

### Container Registry

The container images are hosted on
[GitHub Container Registry](https://github.com/federdaemn/oci-anki-sync/pkgs/container/oci-anki-sync)
(recommended) and on
[Docker Hub](https://hub.docker.com/r/federdaemn/oci-anki-sync) for redundancy.

There are three tags availableon both registries:

* `latest`: Always the latest version of anki.
* `<anki-version>`: The version specified of anki.
* `<time-of-build>`: The exact time(+date) when the container was built
  (following RFC 3339).

## Setup

* See SETUP.md for detailed instructions.

## Contributing

* Contributions for newer versions or files are gracefully accepted but the
  is to only generate a Docker/oci container.
* Please try to wrap lines at 80 characters.

## License

TL;DR before we dive in to legalese:

* Most files are licensed under Apache-2.0, unless noted in the file header or
  the `.reuse/dep5` file.
* For contributors who wish to send patches, an agreement to the
  [DCO](https://developercertificate.org/) (via `--signoff` flag on commits) is
  required.
