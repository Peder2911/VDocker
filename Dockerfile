# syntax = docker/dockerfile:1.0-experimental
FROM continuumio/miniconda 
RUN apt update
RUN apt install git -y

# Download and install ViEWS
RUN --mount=type=secret,id=credentials,dst=/credentials bash -c 'git clone -b quickspec "https://$(cat /credentials)@github.com/UppsalaConflictDataProgram/ViEWS2"'
RUN (cd ViEWS2; ./install_views2.sh)

# Download VCLI
RUN --mount=type=secret,id=credentials,dst=/credentials bash -c 'git clone "https://$(cat /credentials)@github.com/peder2911/VCLI"'
RUN ["conda","run","-n","views2","pip","install","/VCLI"]

# Populate cache
RUN ["mkdir","-p","ViEWS2/storage/cache"]
ENV VIEWS_CACHE=1

ENTRYPOINT ["conda","run","-n","views2","views"]
