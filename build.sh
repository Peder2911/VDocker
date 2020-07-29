DOCKER_BUILDKIT=1 docker build --secret id=credentials,src=$1 -t views . 
