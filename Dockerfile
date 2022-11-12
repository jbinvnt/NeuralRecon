FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-devel
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
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
RUN echo "conda activate neucon" >> ~/.profile
# see https://pythonspeed.com/articles/activate-conda-dockerfile/
# Make RUN commands use the new environment:
#ENV PATH /opt/conda/envs/$conda_env/bin:$PATH
#ENV CONDA_DEFAULT_ENV $conda_env
#RUN /bin/bash -c "source activate neucon"
COPY . .
CMD ["bash"]