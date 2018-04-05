# ltc-mining-aws
This repo contains docker-compose script for mining AION Tokens on the testnet.

## Getting Started

These instructions will let you mine AION Tokens on Ubuntu 16.04 using CPU. The mined tokens are only mined on the testnet. They DON'T have any monetary value!
But if the public net is launched in the near future this repo can you help you starting mining AION tokens.


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
git clone https://github.com/sh39sxn/mining-aion-tokens.git
```

Then change to the project folder and adjust the mining address in the file [aion-kernel.Dockerfile](aion-kernel.Dockerfile)
```
ENV AION_MINING_ADDRESS=0x618d1ce29422bb29f280dc8533bcbcf6ff8b9d85651a21a6073fa31de26e2e7a
```

In order to create an mining address please run:
```
docker run -it --rm aion:kernel /opt/aion/aion.sh -a create
```
This will create a temporary Docker Container. Just type your password and you will receive a mining address.


Now run docker-compose:
```
cd mining-aion-tokens
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
XMR address: 42hnfZMm78hPwKmjhN6pNffHpnaUBjCzddGctFRN5yTVHCmm4hFJcQaDgffcjUv6Q3GfirfyyqHLijfnDrJyyntwMSLZc6p
Litecoin address: LdxTMGSUGLWfcULQQ6UWTNcJGGCLysefJ7
Bitcoin address: 1H7GZ2SGQcDiEcbqdimn2C9AM4VGbqrBdx

## Built With

* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)


## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details