# Etherpad-Lite Dockerfile
#
# https://github.com/ether/etherpad-docker
#
# Developed from a version by Evan Hazlett at https://github.com/arcus-io/docker-etherpad 
#
# Version 1.0

# Use Docker's nodejs, which is based on ubuntu
FROM node:latest
MAINTAINER John E. Arnold, iohannes.eduardus.arnold@gmail.com

# Get Etherpad-lite's other dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  gzip \
  git-core \
  libssl-dev \
  pkg-config \
  python \
  supervisor

RUN ln -fs /usr/share/zoneinfo/Europe/Zurich /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN cd /opt && git clone https://github.com/ether/etherpad-lite.git etherpad
RUN /opt/etherpad/bin/installDeps.sh
RUN echo "3"
RUN cd /opt/etherpad && git clone https://github.com/throwException/ep_oauth2 && npm install ep_oauth2
RUN cd /opt/etherpad && npm install ep_adminpads
RUN cd /opt/etherpad && npm install ep_disable_change_author_name
RUN cd /opt/etherpad && npm install ep_pad-lister
RUN cd /opt/etherpad && npm install ep_set_title_on_pad

# Add conf files
ADD supervisor.conf /etc/supervisor/supervisor.conf

EXPOSE 9001
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n"]
