FROM nvidia/cuda:9.1-base-ubuntu16.04

ENV NUMBER_BLOCKS=64
ENV NUMBER_THREADS=64
ENV DEVICE=0
ENV CUDA_SOLVER=1

ENV MINING_POOL_ADDRESS=localhost
ENV MINING_POOL_PORT=3333
ENV MINING_ADDRESS=0xa002b257cdc41ec76cbc9e30e1f1d93d0fe702201a45ab588ccabaadd5606e22

# replaceholder for downloading specific version
#ARG MINER_VERSION=v0.1.10  # use v as prefix for this version
ARG MINER_VERSION=0.2.0

RUN rm /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list && apt-get update && apt-get install -y \
        jq \
        curl \
        wget \
        bzip2

WORKDIR /opt

RUN curl -s https://api.github.com/repos/aionnetwork/aion_miner/releases/tags/$MINER_VERSION | jq --raw-output '.assets[2] | .browser_download_url' | xargs wget -O aionminer_GPU.tar.bz2
RUN tar -xvjf ./aionminer_GPU.tar.bz2

# start GPU Miner
CMD ./aionminer -cd $DEVICE -cv $CUDA_SOLVER -cb $NUMBER_BLOCKS -ct $NUMBER_THREADS -l $MINING_POOL_ADDRESS:$MINING_POOL_PORT -u $MINING_ADDRESS


#   docker build -f aion-gpu-miner.Dockerfile -t aion:gpu-miner .
#   docker run -it -e MINING_POOL_ADDRESS=solo-mining-pool --net=miningaioncoins_default --runtime=nvidia --rm --name sh39sxn/aion-miner-gpu:latest bash
#   docker run -it --env-file ./aion-gpu-miner.env --net=miningaioncoins_default --runtime=nvidia --rm --name gpu_miner aion:gpu-miner bash
#   ./aionminer -cd 0 -cv 1 -cb 64 -ct 64 -l solo-mining-pool