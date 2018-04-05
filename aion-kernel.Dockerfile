FROM ubuntu:16.04

ENV AION_MINING_ADDRESS=0x618d1ce29422bb29f280dc8533bcbcf6ff8b9d85651a21a6073fa31de26e2e7a

RUN apt-get update && apt-get install -y \
        bzip2 \
        lsb-release \
        wget \
        locales

WORKDIR /opt

# change locales to UTF-8 in order to avoid bug https://bugs.java.com/bugdatabase/view_bug.do?bug_id=6452107 when changing config.xml for AION kernel
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG de_DE.UTF-8  
ENV LANGUAGE de_DE:de  
ENV LC_ALL de_DE.UTF-8    

RUN wget https://github.com/aionnetwork/aion/releases/download/v0.1.16/aion-v0.1.16.c46ff11-2018-03-20.tar.bz2
RUN tar -xvjf ./aion-v0.1.16.c46ff11-2018-03-20.tar.bz2

# allow external access to AION kernel
RUN sed 's/ip=\"127.0.0.1\"/ip=\"0.0.0.0\"/g' -i /opt/aion/config/config.xml

# set miner address
RUN sed "s/<miner-address>.*\/miner-address>/<miner-address>$AION_MINING_ADDRESS<\/miner-address>/g" -i /opt/aion/config/config.xml

# add sleep command before starting java environment because it leaded to some textfile busy errors when starting the AION kernel
RUN sed '/\/rt\/bin\/java/ i\sleep \5;' -i /opt/aion/aion.sh

# start AION kernel
WORKDIR /
CMD /opt/aion/aion.sh


#    docker build -f aion-kernel.Dockerfile -t aion:kernel .
#    docker run -it --net=miningaiontokens_default --rm -p 8545:8545 --name kernel aion:kernel bash