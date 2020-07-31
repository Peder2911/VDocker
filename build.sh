
export SECRETLOC=$1
shift
echo "Secrets are in $SECRETLOC"
echo $@
DOCKER_BUILDKIT=1 docker build --secret id=credentials,src=$SECRETLOC -t views $@ . 
