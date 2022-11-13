FROM pytorch/pytorch:1.7.0-cuda11.0-cudnn8-devel
#FROM nvidia/cuda:10.1-devel-ubuntu18.04
RUN apt-get -y -o Acquire::AllowInsecureRepositories=true \
-o Acquire::AllowDowngradeToInsecureRepositories=true \
update
RUN apt-get -y --allow-unauthenticated install libsparsehash-dev
RUN apt-get -y --allow-unauthenticated install git
RUN apt-get -y --allow-unauthenticated install ffmpeg libsm6 libxext6
RUN apt-get -y --allow-unauthenticated install freeglut3-dev

WORKDIR /app
COPY environment.yaml .
COPY requirements.txt .


RUN conda env create -f environment.yaml
COPY . .
CMD ["/bin/bash"]