#########################################
# HOMESEER (V4) LINUX - DOCKERFILE
#########################################
FROM mono:6.12.0.122

# build arguments
ARG TARGETARCH
ARG BUILDDATE
ARG VERSION
ARG DEBIAN_FRONTEND=noninteractive

# custom STOP signal for 'docker stop'
STOPSIGNAL SIGQUIT

# environment variables
ENV LANG en_US.UTF-8
ENV TZ "America/New_York"
ENV HOMESEER_FOLDER "/homeseer"
ENV HOMESEER_CREDENTAILS ""

# docker container image labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILDDATE
LABEL org.label-schema.name="homeseer/base"
LABEL org.label-schema.description="HomeSeer Base Docker Image"
LABEL org.label-schema.url="https://homseer.sh/"
LABEL org.label-schema.vcs-url="https://github.com/HomeSeerLinux/docker"
LABEL org.label-schema.vendor="Homeseer.sh"
LABEL org.label-schema.version=$VERSION

RUN echo "=========================================================" && \
    echo "  BUILDING DOCKER HOMESEER BASE ($VERSION) IMAGE FOR: $TARGETARCH" && \
    echo "========================================================="

# make sure APT packages are up to date
RUN apt-get update && apt-get upgrade

# set non-interactive frontend
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# update locale/language
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

# install container tools
RUN apt-get install --yes tmux curl wget nano apt-utils net-tools iputils-ping etherwake ssh-client mosquitto-clients dos2unix

# install HomeSeer dependencies
# alsa-base (not available in Debian upstream)
RUN apt-get install --yes aha ffmpeg alsa-utils tmux curl wget nano flite chromium \
                          avahi-discover libavahi-compat-libdnssd-dev libnss-mdns  \
                          avahi-daemon avahi-utils mdns-scan mono-complete         \
                          mono-devel mono-vbnc mono-xsp4 && \
    apt-get remove --yes brltty

# clean APT cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# copy container homeseer override scripts
COPY homeseer/*.sh    /scripts/

# copy container runtime scripts
COPY usr/local/sbin/* /scripts/

# ensure scripts are executable
RUN chmod a+x /scripts/*

# ensure scripts are line-encoded for unix/linux
RUN dos2unix /scripts/*

# remove "reboot" and "shutdown" binaries from the container
# (we will replace with symlinks to scripts)
RUN rm -f /sbin/reboot && rm -f /sbin/shutdown

# create symlinks in bin path ("/usr/local/sbin")
RUN ln -sf /scripts/homeseer /usr/local/sbin/homeseer && \
    ln -sf /scripts/reboot   /usr/local/sbin/reboot   && \
    ln -sf /scripts/shutdown /usr/local/sbin/shutdown && \
    ln -sf /scripts/poweroff /usr/local/sbin/poweroff

# copy default configuration files
COPY etc/avahi/avahi-daemon.conf /etc/avahi/avahi-daemon.conf

# make folders for DBUS & AVAHI
# apply folder permissions for DBUS & AVAHI
RUN mkdir -p /var/run/dbus && \
    mkdir -p /var/run/avahi-daemon && \
    chown messagebus:messagebus /var/run/dbus && \
    chown avahi:avahi /var/run/avahi-daemon

# define IP ports to be exposed by this container
# 80    : HTTP/WEB
# 10200 : HS-TOUCH
# 10300 : myHS
# 10401 : SPEAKER CLIENTS
# 11000 : ASCII/JSON REMOTE API
EXPOSE 80 10200 10300 10401 11000

# define required volume
VOLUME ["/homeseer"]

# set the working path
WORKDIR "/homeseer"

# launch homeseer script in container on startup
CMD ["/usr/local/sbin/homeseer"]