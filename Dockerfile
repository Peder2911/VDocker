# syntax = docker/dockerfile:1.0-experimental
# ViEWS2 Docker file ====================================
# Needs to be provided with a secret called credentials,
# which is a file containing your github username:password.
#  
# By default, exposes the command views, which is used to 
# do things with the ViEWS library.

FROM continuumio/miniconda 
RUN apt update
RUN apt install git -y

# REMOTES ===============================================
# Download and install ViEWS
RUN --mount=type=secret,id=credentials,dst=/credentials bash -c 'git clone -b quickspec "https://$(cat /credentials)@github.com/UppsalaConflictDataProgram/ViEWS2"'
RUN (cd ViEWS2; ./install_views2.sh)

# Download VCLI
RUN --mount=type=secret,id=credentials,dst=/credentials bash -c 'git clone "https://$(cat /credentials)@github.com/peder2911/VCLI"'
RUN ["conda","run","-n","views2","pip","install","/VCLI"]

# UTIL ==================================================
# Populate cache
RUN ["mkdir","-p","ViEWS2/storage/cache"]
ENV VIEWS_CACHE=1

# CONVENIENCE ===========================================
RUN printf '#!/bin/bash\nconda run -n views2 views $@' > /bin/views
RUN chmod +x /bin/views

RUN ln -s /ViEWS2/storage /storage

ENTRYPOINT ["views"]
