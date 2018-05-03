FROM ubuntu:16.04

ENV NUMBER_CPU_THREADS=1
ENV MINING_POOL_ADDRESS=localhost
ENV MINING_POOL_PORT=3333
ENV MINING_ADDRESS=0xa002b257cdc41ec76cbc9e30e1f1d93d0fe702201a45ab588ccabaadd5606e22

# replaceholder for downloading specific version
#ARG MINER_VERSION=v0.1.10  # use v as prefix for this version
ARG MINER_VERSION=0.2.0

RUN apt-get update && apt-get install -y \
        bzip2 \
        curl \
        jq \
        wget

WORKDIR /opt

#RUN wget https://github.com/aionnetwork/aion_miner/releases/download/v0.1.10/aionminer_CPU.tar.bz2

RUN curl -s https://api.github.com/repos/aionnetwork/aion_miner/releases/tags/$MINER_VERSION | jq --raw-output '.assets[1] | .browser_download_url' | xargs wget -O aionminer_CPU.tar.bz2
RUN tar -xvjf ./aionminer_CPU.tar.bz2

# start CPU Miner with maximum of CPU Threads
CMD ./aionminer -t $NUMBER_CPU_THREADS -l $MINING_POOL_ADDRESS:$MINING_POOL_PORT -u $MINING_ADDRESS

#   docker build -f aion-cpu-miner.Dockerfile -t aion:cpu-miner .
#   docker run -it --net=miningaioncoins_default --rm --name cpu_miner sh39sxn/aion-miner-cpu:latest bash
#   docker run -it --network=miningaioncoins_default -e NUMBER_CPU_THREADS=1 -e MINING_POOL_ADDRESS=solo-mining-pool -e MINING_POOL_PORT=3333 --rm --name cpu_miner sh39sxn/aion-miner-cpu:latest
 

