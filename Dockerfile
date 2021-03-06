FROM ubuntu:latest

RUN apt update -y
RUN apt install -y wget bzip2 make

# Turns out we need libX11-6
RUN apt install -y libx11-6

# CONDA
ARG CONDA_INSTALL_PATH=/opt/conda
RUN wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
  && chmod +x miniconda.sh \
  && bash miniconda.sh -b -p $CONDA_INSTALL_PATH \
  && rm miniconda.sh
ENV PATH=$CONDA_INSTALL_PATH/bin:$PATH

# install via pip
RUN conda install -c conda-forge oommfc
# this installs the conda-forge tk, the default tk doesn't work:

# Debug output 1
RUN conda search -c conda-forge tk
RUN conda install -c conda-forge tk
# Debug output 2
RUN conda search -c conda-forge tk

# make the Makefile available
RUN mkdir /io
COPY . /io
WORKDIR /io
