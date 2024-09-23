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
echo "* BUILDING HOMESEER LINUX DOCKER IMAGE                               *"
echo "**********************************************************************"
echo

# use buildx to create a new builder instance; if needed
docker buildx create --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10485760   \
                     --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=100000000 \
                     --use --name homseer-builder || true;

build () {
  # extract function argument values
  VERSION=$1
  DOWNLOAD=$2
  TAGS=$3
  ARGS=$4

  # perform multi-arch platform image builds; push the resulting image to the HomeSeer.sh DockerHub repository
  # (https://hub.docker.com/r/homeseer/homeseer)
  docker buildx build \
    --build-arg BUILDDATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg VERSION="$VERSION"     \
    --build-arg DOWNLOAD="$DOWNLOAD"   \
    --platform linux/amd64,linux/arm64 \
    --tag homeseer/homeseer:$VERSION   \
    $TAGS . $ARGS
}

# previous builds (in order oldest .. latest)
#build "4.1.2"    "https://homeseer.sh/download/archive/release/linux_4_1_2_0.tar.gz" ""  $@
#build "4.1.3"    "https://homeseer.sh/download/archive/release/linux_4_1_3_0.tar.gz" ""  $@
#build "4.1.4"    "https://homeseer.sh/download/archive/release/linux_4_1_4_0.tar.gz" ""  $@
#build "4.1.5"    "https://homeseer.sh/download/archive/release/linux_4_1_5_0.tar.gz" ""  $@
#build "4.1.6"    "https://homeseer.sh/download/archive/release/linux_4_1_6_0.tar.gz" ""  $@
#build "4.1.7"    "https://homeseer.sh/download/archive/beta/linux_4_1_7_0.tar.gz" ""     $@
#build "4.1.8"    "https://homeseer.sh/download/archive/beta/linux_4_1_8_0.tar.gz" ""     $@
#build "4.1.9"    "https://homeseer.sh/download/archive/beta/linux_4_1_9_0.tar.gz" ""     $@
#build "4.1.11"   "https://homeseer.sh/download/archive/release/linux_4_1_11_0.tar.gz" "" $@
#build "4.1.12"   "https://homeseer.sh/download/archive/release/linux_4_1_12_0.tar.gz" "" $@
#build "4.1.13"   "https://homeseer.sh/download/archive/release/linux_4_1_13_0.tar.gz" "" $@
#build "4.1.14"   "https://homeseer.sh/download/archive/release/linux_4_1_14_0.tar.gz" "" $@
#build "4.1.15"   "https://homeseer.sh/download/archive/release/linux_4_1_15_0.tar.gz" "" $@
#build "4.1.16"   "https://homeseer.sh/download/archive/release/linux_4_1_16_0.tar.gz" "" $@
#build "4.1.17"   "https://homeseer.sh/download/archive/release/linux_4_1_17_0.tar.gz" "" $@
#build "4.1.18"   "https://homeseer.sh/download/archive/release/linux_4_1_18_0.tar.gz" "" $@
#build "4.1.100"  "https://homeseer.sh/download/archive/beta/linux_4_1_100_0.tar.gz" ""   $@
#build "4.2.0"    "https://homeseer.sh/download/archive/release/linux_4_2_0_0.tar.gz" ""  $@
#build "4.2.0.5"  "https://homeseer.sh/download/archive/beta/linux_4_2_0_5.tar.gz" ""     $@
#build "4.2.0.8"  "https://homeseer.sh/download/archive/beta/linux_4_2_0_8.tar.gz" ""     $@
#build "4.2.1"    "https://homeseer.sh/download/archive/beta/linux_4_2_1_0.tar.gz" ""     $@
#build "4.2.2"    "https://homeseer.sh/download/archive/beta/linux_4_2_2_0.tar.gz" ""     $@
#build "4.2.4"    "https://homeseer.sh/download/archive/beta/linux_4_2_4_0.tar.gz" ""     $@
#build "4.2.5"    "https://homeseer.sh/download/archive/release/linux_4_2_5_0.tar.gz" ""  $@
#build "4.2.6"    "https://homeseer.sh/download/archive/release/linux_4_2_6_0.tar.gz" ""  $@
#build "4.2.7"    "https://homeseer.sh/download/archive/release/linux_4_2_7_0.tar.gz" ""  $@
#build "4.2.8"    "https://homeseer.sh/download/archive/release/linux_4_2_8_0.tar.gz" ""  $@
#build "4.2.11"   "https://homeseer.sh/download/archive/release/linux_4_2_11_0.tar.gz" "" $@
#build "4.2.11.3" "https://homeseer.sh/download/archive/beta/linux_4_2_11_3.tar.gz"   ""  $@
#build "4.2.12"   "https://homeseer.sh/download/archive/release/linux_4_2_12_0.tar.gz" "" $@
#build "4.2.13"   "https://homeseer.sh/download/archive/release/linux_4_2_13_0.tar.gz" "" $@
#build "4.2.14"   "https://homeseer.sh/download/archive/release/linux_4_2_14_0.tar.gz" "" $@
#build "4.2.15"   "https://homeseer.sh/download/archive/release/linux_4_2_15_0.tar.gz" "" $@
#build "4.2.16"   "https://homeseer.sh/download/archive/release/linux_4_2_16_0.tar.gz" "" $@
#build "4.2.16.7" "https://homeseer.sh/download/archive/beta/linux_4_2_16_7.tar.gz"   ""  $@
#build "4.2.17"   "https://homeseer.sh/download/archive/release/linux_4_2_17_0.tar.gz" "" $@
#build "4.2.17.2" "https://homeseer.sh/download/archive/beta/linux_4_2_17_2.tar.gz"   ""  $@
#build "4.2.17.4" "https://homeseer.sh/download/archive/beta/linux_4_2_17_4.tar.gz" ""    $@
#build "4.2.18.3" "https://homeseer.sh/download/archive/release/linux_4_2_18_3.tar.gz" "" $@
#build "4.2.18.5" "https://homeseer.sh/download/archive/release/linux_4_2_18_5.tar.gz" "" $@
#build "4.2.18.8" "https://homeseer.sh/download/archive/beta/linux_4_2_18_8.tar.gz" ""    $@
#build "4.2.18.9" "https://homeseer.sh/download/archive/beta/linux_4_2_18_9.tar.gz" ""    $@
#build "4.2.18.12" "https://homeseer.sh/download/archive/beta/linux_4_2_18_12.tar.gz" ""  $@
#build "4.2.18.18" "https://homeseer.sh/download/archive/beta/linux_4_2_18_18.tar.gz" ""  $@
#build "4.2.18.19" "https://homeseer.sh/download/archive/beta/linux_4_2_18_19.tar.gz" ""  $@
#build "4.2.18.20" "https://homeseer.sh/download/archive/beta/linux_4_2_18_20.tar.gz" ""  $@
#build "4.2.18.21" "https://homeseer.sh/download/archive/beta/linux_4_2_18_21.tar.gz" ""  $@
#build "4.2.18.29" "https://homeseer.sh/download/archive/beta/linux_4_2_18_29.tar.gz" "" $@
#build "4.2.19.0"  "https://homeseer.sh/download/archive/release/linux_4_2_19_0.tar.gz" "" $@
#build "4.2.19.1"  "https://homeseer.sh/download/archive/beta/linux_4_2_19_1.tar.gz" "" $@
#build "4.2.19.4"  "https://homeseer.sh/download/archive/beta/linux_4_2_19_4.tar.gz" "" $@
#build "4.2.19.5"  "https://homeseer.sh/download/archive/release/linux_4_2_19_5.tar.gz" "" $@
#build "4.2.19.9"  "https://homeseer.sh/download/archive/beta/linux_4_2_19_9.tar.gz" "" $@
#build "4.2.20.0"  "https://homeseer.sh/download/archive/release/linux_4_2_20_0.tar.gz" "" $@
#build "4.2.20.6"  "https://homeseer.sh/download/archive/beta/linux_4_2_20_6.tar.gz" "" $@
#build "4.2.20.7"  "https://homeseer.sh/download/archive/beta/linux_4_2_20_7.tar.gz" "" $@
#build "4.2.20.9"  "https://homeseer.sh/download/archive/beta/linux_4_2_20_9.tar.gz" "" $@
#build "4.2.20.11" "https://homeseer.sh/download/archive/beta/linux_4_2_20_11.tar.gz" "" $@
#build "4.2.20.12" "https://homeseer.sh/download/archive/beta/linux_4_2_20_12.tar.gz" "" $@
#build "4.2.21.0"  "https://homeseer.sh/download/archive/release/linux_4_2_21_0.tar.gz" "" $@

# latest beta build
build "4.2.20.13" "https://homeseer.sh/download/archive/beta/linux_4_2_20_13.tar.gz" "--tag homeseer/homeseer:beta" $@

# latest release build
build "4.2.21.2"  "https://homeseer.sh/download/archive/release/linux_4_2_21_2.tar.gz" "--tag homeseer/homeseer:latest" $@
