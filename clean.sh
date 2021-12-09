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

echo
echo "**********************************************************************"
echo "* CLEANING HOMESEER DOCKER IMAGES                                    *"
echo "**********************************************************************"
echo

# remove the builder instance
docker buildx rm homeseer-builder || true

# remove any containers from local Docker registry
docker images -a | grep "homeseer/homeseer" | awk '{print $3}' | xargs docker rmi