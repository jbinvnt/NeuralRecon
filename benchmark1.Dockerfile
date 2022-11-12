FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-devel
#FROM nvidia/cuda:10.1-devel-ubuntu18.04
RUN apt-get -y -o Acquire::AllowInsecureRepositories=true \
-o Acquire::AllowDowngradeToInsecureRepositories=true \
update
RUN apt-get -y --allow-unauthenticated install libsparsehash-dev
RUN apt-get -y --allow-unauthenticated install git
RUN apt-get -y --allow-unauthenticated install ffmpeg libsm6 libxext6
RUN apt-get -y --allow-unauthenticated install freeglut3-dev

# installing conda, provided by https://fabiorosado.dev/blog/install-conda-in-docker/
# Install base utilities
#RUN apt-get -y --allow-unauthenticated install build-essential wget
# Install miniconda
#ENV CONDA_DIR /opt/conda
#RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
#ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda update conda
WORKDIR /app
COPY environment.yaml .
COPY requirements.txt .
RUN conda env create -f environment.yaml
# see https://pythonspeed.com/articles/activate-conda-dockerfile/
# Make RUN commands use the new environment:
#SHELL ["conda", "run", "-n", "neucon", "/bin/bash", "-c"]
ENV PATH /opt/conda/envs/$conda_env/bin:$PATH
ENV CONDA_DEFAULT_ENV $conda_env
RUN /bin/bash -c "source activate neucon"
COPY . .
ENTRYPOINT ["conda", "run", "--no-buffer-output", "-n", "neucon", "python", "demo.py", "--cfg", "./config/demo.yaml"]