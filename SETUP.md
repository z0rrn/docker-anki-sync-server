<!--
SPDX-FileCopyrightText: 2023 Frederik Zorn <fz@zorrn.net>

SPDX-License-Identifier: Apache-2.0
-->

# Setup

This is a basic docker-compose.yml to setup anki.

```yaml
version: "3.7"

services:
  anki-sync-server:
    # https://github.com/z0rrn/docker-anki-sync-server/blob/main/SETUP.md
    image: ghcr.io/z0rrn/anki-sync-server:23.10.1
    container_name: anki-sync-server
    restart: unless-stopped
    # these are sample passwords, please change them
    environment:
      - SYNC_USER1=panda:rsfPz4NXELBxmJ
      - SYNC_USER2=penguin:2Qtf5nnsDpsQ3b
    volumes:
      - anki-sync-server:/config
    ports:
      - 27701:27701

volumes:
  anki-sync-server:
```

- the important parts are
  - set SYNC_USERX to your desired username and password
  - mount volume anki-sync-server to /config
  - open port 27701

**for more configuration options see <https://docs.ankiweb.net/sync-server.html>**

If you know how to configure another reverse-proxy please open an issue/pull
request.
