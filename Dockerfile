FROM ubuntu:20.04

COPY . /coppercoin
WORKDIR /coppercoin

#shared libraries and dependencies
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libfmt-dev wget

#BerkleyDB for wallet support
RUN apt-get install -y software-properties-common
RUN apt-get update  

RUN wget https://launchpad.net/~bitcoin-abc/+archive/ubuntu/ppa/+files/libdb4.8_4.8.30-xenial4_arm64.deb
RUN dpkg -i libdb4.8_4.8.30-xenial4_arm64.deb
RUN wget https://launchpad.net/~bitcoin-abc/+archive/ubuntu/ppa/+files/libdb4.8-dev_4.8.30-xenial4_arm64.deb
RUN dpkg -i libdb4.8-dev_4.8.30-xenial4_arm64.deb
RUN wget https://launchpad.net/~bitcoin-abc/+archive/ubuntu/ppa/+files/libdb4.8++_4.8.30-xenial4_arm64.deb
RUN dpkg -i libdb4.8++_4.8.30-xenial4_arm64.deb
RUN wget https://launchpad.net/~bitcoin-abc/+archive/ubuntu/ppa/+files/libdb4.8++-dev_4.8.30-xenial4_arm64.deb
RUN dpkg -i libdb4.8++-dev_4.8.30-xenial4_arm64.deb 

#upnp
RUN apt-get install -y libminiupnpc-dev

#ZMQ
RUN apt-get install -y libzmq3-dev

#build coppercoin source
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

#open service port (default: 7333, testnet: 19335, signet: 19335, regtest: 19444)
EXPOSE 7332 7333 17332 17333 19444

CMD ["coppercoind", "--conf=/etc/coppercoin.conf", "--printtoconsole"]