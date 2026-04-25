FROM ghcr.io/ihaskell/ihaskell-notebook:master

USER root

ARG QUARTO_VERSION=1.5.57
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
  && curl -fsSL -o /tmp/quarto.deb \
      https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb \
  && apt-get install -y /tmp/quarto.deb \
  && rm -f /tmp/quarto.deb \
  && rm -rf /var/lib/apt/lists/*

USER jovyan

RUN python3 -m pip install --no-cache-dir -U jupytext

RUN quarto --version && jupytext --version
