FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
#FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y build-essential wget git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /worker

ENV CONDA_DIR /opt/conda

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

ENV PATH=$CONDA_DIR/bin:$PATH

COPY ./environment.yaml ./
COPY ./setup.py ./

RUN conda env create -f environment.yaml
RUN conda activate ldm
