#!/usr/bin/sh

# Lanch script of the docker image for editing and exeucution of
# Haskell jupyter notebooks, maintaing sync between qmd and ipynb files.
# Befor running this script, docker build should be done.
# See docker/ihaskell-quarto-jupytext for the build instruction.

docker run --rm -it --name ihaskell_quarto_jupytext -v "$PWD":/home/jovyan/pwd -p 8888:8888 ihaskell-quarto-jupytext:latest jupyter lab --LabApp.token=''
