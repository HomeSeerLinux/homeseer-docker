#!/bin/bash -e

############################################
# HOMESEER (V4) LINUX - DOCKER BUILD SCRIPT
############################################

#-----------------------------------------------------------------------------------------
# !! THIS DOCKER BUILD REQUIRES THE EXPERIMENTAL DOCKER BUILDX PLUGIN !!
#-----------------------------------------------------------------------------------------
#
# REF: https://docs.docker.com/buildx/working-with-buildx/
#
# Docker Buildx is a CLI plugin that extends the docker command with the
# full support of the features provided by Moby BuildKit builder toolkit.
# It provides the same user experience as docker build with many new
# features like creating scoped builder instances and building against
# multiple nodes concurrently.
#
# This is an experimental feature.
#
# Experimental features provide early access to future product functionality.
# These features are intended for testing and feedback only as they may change
# between releases without warning or can be removed entirely from a future
# release. Experimental features must not be used in production environments.
# Docker does not offer support for experimental features.
#
#-----------------------------------------------------------------------------------------

# docker image version
VERSION="4.0"

echo
echo "**********************************************************************"
echo "* BUILDING HOMESEER LINUX BASE DOCKER IMAGE                          *"
echo "**********************************************************************"
echo

# use buildx to create a new builder instance; if needed
docker buildx create --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10485760   \
                     --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=100000000 \
                     --use --name homseer-builder || true;

# perform multi-arch platform image builds; push the resulting image to the HomeSeer.sh DockerHub repository
# (https://hub.docker.com/r/homeseer/homeseer)
docker buildx build \
  --build-arg BUILDDATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
  --build-arg VERSION="$VERSION" \
  --platform linux/amd64,linux/arm64 \
  --tag homeseer/base:$VERSION \
  --tag homeseer/base:latest \
  . $@
