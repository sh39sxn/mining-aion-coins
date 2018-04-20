# mining-aion-coin
This repo contains docker-compose script for mining AION coins on the testnet.

## Getting Started

These instructions will let you mine AION coins on Ubuntu 16.04 using CPU. The mined coins are only mined on the testnet. They DON'T have any monetary value!
But if the public net is launched in the near future this repo can you help you starting mining AION coins.


### Prerequisites

You need the following setup:

```
Ubuntu 16.04
Docker (tested Docker version 18.03.0-ce, build 0520e24)
Docker-Compose (tested docker-compose version 1.19.0, build 9e633ef)
```

### Installing

clone this project:

```
git clone https://github.com/sh39sxn/mining-aion-coins.git
```

In order to adjust settings please edit the environment files [aion-cpu-miner.env](aion-cpu-miner.env) [aion-cpu-miner.env](aion-gpu-miner.env) [aion-kernel.env](aion-kernel.env) [aion-solo-mining-pool.env](aion-solo-mining-pool.env)


For more explanations about the environment variables please visit my Repo at the Docker Hub: https://hub.docker.com/u/sh39sxn/


Now run docker-compose:
```
cd mining-aion-coins
docker-compose up
```

This command will build the Docker Containers and starts them immediately afterwards.
If you want to not show the logs please run:
```
docker-compose up -d
```





## Donation
Thank's for any donations to enable further development!

AION ETH address: 0xC83658738795f5Dfbf91Da5d1E37A1B1c3Ad344c

Litecoin address: LdxTMGSUGLWfcULQQ6UWTNcJGGCLysefJ7

Bitcoin address: 1H7GZ2SGQcDiEcbqdimn2C9AM4VGbqrBdx

Ethereum address: 0x2a427da268c081466be59b41e0a7ad556f57e755

## Built With

* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)


## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details