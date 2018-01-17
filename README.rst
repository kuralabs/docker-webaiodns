======================
Web AsyncIO DNS Server
======================

``webaiodns`` is a REST API for ultrafast DNS resolution.

Implemented in Python 3.6 using a ultrafast AsyncIO stack including aiohttp_,
aiodns_, uvloop_, among others.

.. _aiohttp: https://aiohttp.readthedocs.io/
.. _aiodns: https://github.com/saghul/aiodns
.. _uvloop: https://github.com/MagicStack/uvloop


Endpoints
=========

:``/ipv6/[domain]``:
 Perform a DNS resolution for given domain and return the associated IPv6
 addresses.

 ::

     {
         addresses: [
             "2a01:91ff::f03c:7e01:51bd:fe1f"
         ]
     }

:``/ipv4/[domain]``:
 Perform a DNS resolution for given domain and return the associated IPv4
 addresses.

 ::

     {
         addresses: [
             "139.180.232.162"
         ]
     }

Both endpoints return 400 Bad Request if requested domain is invalid or
404 Not Found if DNS resolution failed.


Security
========

This micro-service was intended for intranet usage, for monitoring of DNS
propagation and server availability. There is no particular feature implemented
to avoid abuse. Be careful and use common sense for deployment and exposure.


Deployment
==========

Docker automated build is available at:

    https://hub.docker.com/r/kuralabs/docker-webaiodns/

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
        kuralabs/docker-webaiodns:latest


Development
===========

Build me with::

    docker build --tag kuralabs/docker-webaiodns:latest .

In development, run me with::

    docker run --interactive --tty --init \
        --publish 8084:8084 \
        kuralabs/docker-webaiodns:latest


License
=======

::

   Copyright (C) 2018 KuraLabs S.R.L

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing,
   software distributed under the License is distributed on an
   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
   KIND, either express or implied.  See the License for the
   specific language governing permissions and limitations
   under the License.
