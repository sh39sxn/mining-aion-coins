FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        bzip2 \
        wget 

WORKDIR /opt

RUN wget https://github.com/aionnetwork/aion_miner/releases/download/v0.1.10/aionminer_CPU.tar.bz2
RUN tar -xvjf ./aionminer_CPU.tar.bz2

# start CPU Miner with maximum of CPU Threads
CMD ./aionminer -t $(grep -c ^processor /proc/cpuinfo) -l solo-mining-pool:3333

#   docker build -f aion-cpu-miner.Dockerfile -t aion:cpu-miner .
#   docker run -it --net=miningaiontokens_default --rm --name cpu_miner aion:cpu-miner bash


