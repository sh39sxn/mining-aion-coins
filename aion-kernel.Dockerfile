FROM ubuntu:16.04

ENV AION_MINING_ADDRESS=0x618d1ce29422bb29f280dc8533bcbcf6ff8b9d85651a21a6073fa31de26e2e7a
ENV AION_NETWORK=mainnet
# replaceholder for downloading specific version
ARG KERNEL_VERSION=v0.1.16

RUN apt-get update && apt-get install -y \
        bzip2 \
        lsb-release \
        wget \
        locales \
        curl \
        jq

WORKDIR /opt

# change locales to UTF-8 in order to avoid bug https://bugs.java.com/bugdatabase/view_bug.do?bug_id=6452107 when changing config.xml for AION kernel
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG de_DE.UTF-8  
ENV LANGUAGE de_DE:de  
ENV LC_ALL de_DE.UTF-8    

# download latest
#RUN curl -s https://api.github.com/repos/aionnetwork/aion/releases/latest |   jq --raw-output '.assets[0] | .browser_download_url' | xargs wget -O kernel.tar.bz2

# download specific AION Kernel version
RUN curl -s https://api.github.com/repos/aionnetwork/aion/releases/tags/$KERNEL_VERSION | jq --raw-output '.assets[0] | .browser_download_url' | xargs wget -O kernel.tar.bz2
RUN tar -xvjf ./kernel.tar.bz2

# set miner address, previously used, no set in CMD layer
#RUN sed "s/<miner-address>.*\/miner-address>/<miner-address>$AION_MINING_ADDRESS<\/miner-address>/g" -i /opt/aion/config/config.xml

# add sleep command before starting java environment because it leaded to some textfile busy errors when starting the AION kernel
RUN sed '/\/rt\/bin\/java/ i\sleep \5;' -i /opt/aion/aion.sh

## change miner address, allow external access to AION kernel, define genesisStakingDifficulty if you are running kernel on the testnet, then start AION kernel with specified Aion Network
WORKDIR /
CMD sed "s/<miner-address>.*\/miner-address>/<miner-address>$AION_MINING_ADDRESS<\/miner-address>/g" -i /opt/aion/config/$AION_NETWORK/config.xml && \
        sed 's/ip=\"127.0.0.1\"/ip=\"0.0.0.0\"/g' -i /opt/aion/config/$AION_NETWORK/config.xml && \
        if [ "$AION_NETWORK" = "mastery" ] ; then jq --arg genesisStakingDifficulty 2000000000 '. + {genesisStakingDifficulty: $genesisStakingDifficulty}' /opt/aion/config/$AION_NETWORK/genesis.json > /tmp/tmp_genesis.json && \
        mv /tmp/tmp_genesis.json /opt/aion/config/$AION_NETWORK/genesis.json ; fi && \
        /opt/aion/aion.sh -n $AION_NETWORK


#    docker build -f aion-kernel.Dockerfile -t aion:kernel .
#    docker run -it --net=miningaioncoins_default --rm -p 8545:8545 --name kernel aion:kernel bash