FROM nvidia/cuda:9.1-base-ubuntu16.04

ENV NUMBER_BLOCKS=64
ENV NUMBER_THREADS=64
ENV DEVICE=0
ENV CUDA_SOLVER=1


# replaceholder for downloading specific version
#ARG MINER_VERSION=v0.1.10  # use v as prefix for this version
ARG MINER_VERSION=0.2.0

RUN apt-get update && apt-get install -y \
        jq \
        curl \
        wget \
        bzip2

WORKDIR /opt

RUN curl -s https://api.github.com/repos/aionnetwork/aion_miner/releases/tags/$MINER_VERSION | jq --raw-output '.assets[2] | .browser_download_url' | xargs wget -O aionminer_GPU.tar.bz2
RUN tar -xvjf ./aionminer_GPU.tar.bz2

# start GPU Miner GPU Threads
# run benchmark
CMD ./aionminer -cd $DEVICE -cv $CUDA_SOLVER -cb $NUMBER_BLOCKS -ct $NUMBER_THREADS
#CMD ./aionminer -t $NUMBER_CPU_THREADS -l $MINING_POOL_ADDRESS:$MINING_POOL_PORT


#   docker build -f gpu.Dockerfile -t aion:gpu-test .
#   docker run -it --runtime=nvidia --rm --name gpu_miner2342434 aion:gpu-test bash