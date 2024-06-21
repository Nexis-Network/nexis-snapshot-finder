FROM python:3.9.6-slim


RUN apt-get update \
    && apt-get install -y wget git \
    && rm -rf /var/lib/apt/lists/* \
    && rm /bin/sh \
    && ln -s /bin/bash /bin/sh \
    && groupadd -r user \
    && useradd --create-home --no-log-init -r -g user user \
    && mkdir /nexis \
    && chown user:user /nexis \
    && apt-get clean \
    && apt-get autoclean


WORKDIR /nexis
USER user

COPY --chown=user . .

RUN python3 -m venv venv \
    && source ./venv/bin/activate \
    && pip3 install -r requirements.txt --no-cache

ENTRYPOINT ["/nexis/venv/bin/python3", "snapshot-finder.py"]
