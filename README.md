
# A docker image for ViEWS2

Includes [vcli](https://github.com/peder2911/VCLI) which acts as the entrypoint, exposing views functionality.

This build currently requires you to provide git credentials, as the ViEWS repository is private.
To build run `build.sh [credentials]` where `credentials` is a path to a file containing your git username and token / password in the format `USERNAME:PASSWORD`. Any further arguments are passed on to docker build.
Note that this image requires Docker >= 17.6.
