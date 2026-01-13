FROM python:3.14.1-slim-bookworm

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV NO_PROXY=${NO_PROXY}

RUN echo 'Acquire::http::proxy \"${HTTP_PROXY}\";' > /etc/apt/apt.conf.d/proxy.conf && \
  echo 'Acquire::https::proxy \"${HTTP_PROXY}\";' >> /etc/apt/apt.conf.d/proxy.conf

RUN set -eux; \
  useradd -m engine; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    curl \
    libssl-dev \
    pkg-config \
    libmariadb-dev-compat \
    libmariadb-dev \
    iputils-ping \
  ; \
  rm -rf /var/lib/apt/lists/* && \
  python3 -m ensurepip --upgrade && \
  mkdir /app
COPY pyproject.toml /app/pyproject.toml
COPY docker/engine.conf.inc /app/engine.conf

WORKDIR /app

USER root

RUN chown -R engine:engine /app

USER engine

# Needed for celery/uwsgi
ENV PATH=/home/engine/.local/bin:$PATH

COPY scoring_engine /app/scoring_engine

RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -e .
