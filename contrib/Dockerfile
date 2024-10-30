FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3 python3-dev python3-venv git openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/ezzygarmyz/electrumz-server.git /opt/electrumz


RUN python3 -m venv /opt/electrumz/env && \
    /bin/bash -c "source /opt/electrumz/env/bin/activate && \
    pip install --upgrade pip && \
    pip install -r /opt/electrumz/requirements.txt && \
    rm -rf ~/.cache/pip"


RUN mkdir -p /data && \
    openssl req -newkey rsa:2048 -sha256 -nodes -keyout /data/electrumz.key -x509 -days 1095 -out /data/electrumz.crt -subj "/O=ElectrumZ"


ENV SERVICES=tcp://:50001,ssl://:50002,wss://:50004,rpc://0.0.0.0:8000
ENV COIN=BitcoinZ
ENV DB_DIRECTORY=/data
ENV EVENT_LOOP_POLICY=uvloop
ENV ALLOW_ROOT=1
ENV SSL_CERTFILE=${DB_DIRECTORY}/electrumz.crt
ENV SSL_KEYFILE=${DB_DIRECTORY}/electrumz.key
ENV DB_ENGINE=leveldb
ENV CACHE_MB=1200
#ENV DAEMON_URL="http://rpcuser:rpcpassword@host.docker.internal:1979"
#ENV REPORT_SERVICES="tcp://example.com:50001,ssl://example.com:50002,wss://example.com:50004"


EXPOSE 50001 50002 50004 8000

WORKDIR /opt/electrumz


CMD ["/opt/electrumz/venv/bin/python", "electrumx_server"]
