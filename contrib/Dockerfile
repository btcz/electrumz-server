# example of Dockerfile that installs spesmilo electrumz 1.16.0
# ENV variables can be overridden on the `docker run` command

FROM python:3.9.16-bullseye AS builder

WORKDIR /usr/src/app

# Install the libs needed by rocksdb (including development headers)
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        librocksdb-dev libsnappy-dev libbz2-dev libz-dev liblz4-dev \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv venv \
    && venv/bin/pip install --no-cache-dir e-x[rapidjson,rocksdb]==1.16.0


FROM python:3.9.16-slim-bullseye

# Install the libs needed by rocksdb (no development headers or statics)
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        librocksdb6.11 libsnappy1v5 libbz2-1.0 zlib1g liblz4-1 \
    && rm -rf /var/lib/apt/lists/*

ENV SERVICES="tcp://:50001"
ENV COIN=Bitcoin
ENV DB_DIRECTORY=/var/lib/electrumz
ENV DAEMON_URL="http://username:password@hostname:port/"
ENV ALLOW_ROOT=true
ENV DB_ENGINE=rocksdb
ENV MAX_SEND=10000000
ENV BANDWIDTH_UNIT_COST=50000
ENV CACHE_MB=2000

WORKDIR /usr/src/app
COPY --from=builder /usr/src/app .

VOLUME /var/lib/electrumz

RUN mkdir -p "$DB_DIRECTORY" && ulimit -n 1048576

CMD ["/usr/src/app/venv/bin/python", "/usr/src/app/venv/bin/electrumz_server"]

# build it with eg.: `docker build -t electrumz .`
# run it with eg.:
# `docker run -d --net=host -v /home/electrumz/db/:/var/lib/electrumz -e DAEMON_URL="http://youruser:yourpass@localhost:8332" -e REPORT_SERVICES=tcp://example.com:50001 electrumz`
# for a clean shutdown, send TERM signal to the running container eg.: `docker kill --signal="TERM" CONTAINER_ID`
