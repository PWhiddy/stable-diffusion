FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
#FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get install -y build-essential wget git \
    libglib2.0-0 libsm6 libxext6 \
    libxrender1 libfontconfig1 libopencv-dev \ 
    libjpeg-dev \ 
    libpng-dev \ 
    libtiff-dev \  
    libgtk2.0-dev && \
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
#RUN conda activate ldm
#SHELL ["conda", "run", "-n", "ldm", "/bin/bash", "-c"]
#RUN python -c "import torch; print(torch.__version__)"

WORKDIR /worker

COPY ./scripts ./scripts
COPY ./ldm ./ldm
COPY ./models ./models
COPY ./configs ./configs
RUN mkdir -p models/ldm/stable-diffusion-v1/
COPY ./sd-v1-4.ckpt ./models/ldm/stable-diffusion-v1/model.ckpt
COPY ./test_img.sh ./
RUN chmod +x test_img.sh
run mkdir -p outputs
ENTRYPOINT ["./test_img.sh"]
