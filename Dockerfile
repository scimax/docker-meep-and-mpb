# docker run -it ubuntu:16.04 /bin/bash
FROM ubuntu:16.04
LABEL maintainer="max.kellermeier at hotmail.de"

RUN apt-get update && \
apt-get install -y wget vim nano git
# apt-get install -y python3 

ADD build_meep_python.sh /home
RUN /bin/bash /home/build_meep_python.sh

# Optional
RUN apt-get install imagemagick

RUN echo "LS_COLORS=\$LS_COLORS:'di=0;93:' ; export LS_COLORS" >> ~/.bashrc
RUN mkdir /home/hostSRC
VOLUME /home/hostSRC

WORKDIR /home/hostSRC
