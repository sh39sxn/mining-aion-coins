FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        build-essential \
        libboost-all-dev \
        git \
        moreutils \
        jq \
        make \
        gcc

WORKDIR /opt

# install NodeJs 9.x (https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs


# install node-gyp v3.6.2+
RUN npm install -g node-gyp

# install libsodium v1.0.16+
RUN wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
RUN tar -xvzf LATEST.tar.gz
RUN cd libsodium-stable && ./configure && make && make check && make install

# install more prerequisites
RUN npm install --save nan
RUN npm install bindings



RUN git clone https://github.com/aionnetwork/aion_miner.git


# replace 127.0.0.1 with "redis" in order to use docker-compose
RUN jq '.redis.host="redis"' ./aion_miner/aion_solo_pool/config.json | sponge ./aion_miner/aion_solo_pool/config.json
RUN jq '.defaultPoolConfigs.redis.host="redis"' ./aion_miner/aion_solo_pool/config.json | sponge ./aion_miner/aion_solo_pool/config.json

RUN jq '.daemons[0].host="kernel"' ./aion_miner/aion_solo_pool/pool_configs/aion.json | sponge ./aion_miner/aion_solo_pool/pool_configs/aion.json
RUN jq '.paymentProcessing.daemon.host="kernel"' ./aion_miner/aion_solo_pool/pool_configs/aion.json | sponge ./aion_miner/aion_solo_pool/pool_configs/aion.json

RUN cd ./aion_miner/aion_solo_pool/local_modules/equihashverify && node-gyp configure && node-gyp build && ldconfig -v && node-gyp rebuild && node test.js  
#(should print a table, if not try: sudo ldconfig -v --> node-gyp rebuild --> node test.js)

WORKDIR /opt
RUN cd ./aion_miner/aion_solo_pool/ && chown -R root:root . && npm install
#(needed because npm install fails because of missing permissions)


# adjust mining settings
#vim ./aion/config/config.xml


RUN npm install --unsafe-perm bignum && npm rebuild --unsafe-perm

WORKDIR ./aion_miner/aion_solo_pool
CMD ./run.sh

#   docker build -f aion-solo-mining-pool.Dockerfile -t aion:solo_mining_pool .
#   docker run --net=miningaiontokens_default --rm --name solo-mining-pool aion:solo_mining_pool 