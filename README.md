# CAIFS Container Collection (v0.0.0)

A collection of CAIFS enabled installers and general purpose configuration that can be enabled via CAIFS
<https://github.com/caifs-org/caifs>

This collection containers docker specific targets for very commonly installed software within containers.

## Installation

See the readme for instructions on how to install the CAIFS installer at <https://github.com/caifs-org/caifs>

The simplest way to enable this within docker images is to use the supplied scratch images

``` dockerfile
FROM debian:trixie-slim

ENV CAIFS_LOCAL_COLLECTIONS=/usr/local/share/caifs-collections
COPY --from=ghcr.io/caifs-org/caifs:latest /caifs/ /usr/local/
COPY --from=ghcr.io/caifs-org/caifs-common:latest /caifs-common/ $CAIFS_LOCAL_COLLECTIONS/caifs-common
# Add this container collection
COPY --from=ghcr.io/caifs-org/caifs-container-collection:latest /caifs-container-collection/ $CAIFS_LOCAL_COLLECTIONS/caifs-container-collection/
RUN caifs add gosu su-exec tini cleanup
```

## Supported installs

| Software target | Description                                                               |
|:----------------|:--------------------------------------------------------------------------|
| gosu            | Simple Go-based setuid+setgid+setgroups+exec                              |
| su-exec         | switch user and group id, setgroups and exec, smaller alternative to gosu |
| tini            | A tiny but valid `init` for containers                                    |
| cleanup         | Meta group for performing common clean up actions (use last)              |
|                 |                                                                           |

> [!TIP]
> All can be installed and configured via `caifs add <name of target>`
