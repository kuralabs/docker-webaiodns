Build me with::

    docker build --tag kuralabs/webaiodns:latest .

In development, run me with::

    docker run --interactive --tty --init \
        --publish 8084:8084 \
        kuralabs/webaiodns:latest

In production, run me with::

    #!/usr/bin/env bash

    set -o errexit
    set -o nounset

    docker stop webaiodns || true
    docker rm webaiodns || true

    docker run --detach --init \
        --hostname webaiodns \
        --name webaiodns \
        --restart always \
        --publish 8084:8084 \
        kuralabs/webaiodns:latest bash
