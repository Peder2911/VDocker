# syntax = docker/dockerfile:1.0-experimental
FROM continuumio/miniconda 
RUN apt update
RUN apt install git -y
RUN --mount=type=secret,id=credentials,dst=/credentials bash -c 'git clone "https://$(cat /credentials)@github.com/UppsalaConflictDataProgram/ViEWS2"'
RUN (cd ViEWS2; ./install_views2.sh)

COPY run.py .
ENTRYPOINT ["conda","run","-n","views2","python","run.py"]
