# ihaskell-quarto-jupytext

Custom Docker image based on [`ghcr.io/ihaskell/ihaskell-notebook:master`](https://github.com/IHaskell/IHaskell) with [Quarto](https://quarto.org) and [Jupytext](https://jupytext.readthedocs.io) added.

- **Base**: `ghcr.io/ihaskell/ihaskell-notebook:master` (IHaskell + JupyterLab already included)
- **Added**: Quarto (linux-amd64 `.deb`) + Jupytext (pip)
- **Architecture**: amd64 only

## Build

```bash
docker build -t ihaskell-quarto-jupytext:latest docker/ihaskell-quarto-jupytext/
```

To pin a specific Quarto version:

```bash
docker build --build-arg QUARTO_VERSION=1.5.57 \
  -t ihaskell-quarto-jupytext:latest \
  docker/ihaskell-quarto-jupytext/
```

## Run

```bash
docker run --rm -it -p 8888:8888 ihaskell-quarto-jupytext:latest
```

## Apple Silicon (arm64)

The image targets `linux/amd64`. On Apple Silicon Macs, force emulation with `--platform`:

```bash
# Build
docker build --platform=linux/amd64 \
  -t ihaskell-quarto-jupytext:latest \
  docker/ihaskell-quarto-jupytext/

# Run
docker run --platform=linux/amd64 --rm -it -p 8888:8888 ihaskell-quarto-jupytext:latest
```
