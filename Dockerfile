FROM ubuntu:18.04

# Use baseimage-docker's init system:
CMD ["/sbin/my_init"]

# Install dependencies:
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    sudo \
    wget \
    python \
    python-pip \
    git \
    make \
    busybox \
    build-essential \
    unzip
    
# && mkdir -p -vv /stuff

# Set work dir:
WORKDIR /home
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
&&sudo apt-get install -y nodejs
# Copy files:
COPY startbot.sh /home/
COPY startup.sh /home/
COPY extras.sh /home/
#COPY /stuff /stuff

# Run extras.sh and clean up APT:
RUN sh /home/extras.sh \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the bot:
#RUN git clone https://github.com/cddc22/her.git \
# && cd her \
# && npm install \
 
 
# Run bot script:
CMD bash /home/startbot.sh
