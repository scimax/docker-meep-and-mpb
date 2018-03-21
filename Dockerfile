# docker run -it ubuntu:16.04 /bin/bash
FROM ubuntu:16.04
LABEL maintainer="max.kellermeier at hotmail.de"

RUN apt-get update && \
apt-get install -y wget vim nano git
# apt-get install -y python3 

ADD build_meep_python.sh /home
RUN /bin/bash /home/build_meep_python.sh
RUN apt-get install python3-matplotlib

# Optional
RUN apt-get install imagemagick

RUN echo "LS_COLORS=\$LS_COLORS:'di=0;93:' ; export LS_COLORS" >> ~/.bashrc
RUN echo 'export export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial"
export LDFLAGS="-L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/hdf5/serial"
export CPPFLAGS="-I/usr/local/include -I/usr/include/hdf5/serial"
export PYTHONPATH="$HOME/install/meep/python"
export GUILE_WARN_DEPRECATED="no"
export MPLBACKEND=Agg' >> ~/.bashrc
RUN mkdir /home/hostSRC
VOLUME /home/hostSRC

WORKDIR /home/hostSRC
