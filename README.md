# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact


## How to Make a Cryptocurrency Using Litecoin v0.15 Source

### 1. Obtain a working codebase and build it
You will want to begin by cloning a local copy of Litecoin down to your dev machine. You will need a working install of git and a github account for this task.

Begin by forking the codebase @ https://github.com/litecoin-project/litecoin


### 1. Rename to copercoin 


Replace litecoin with new ALT coin name in the sources

```sh
cd ~/coopercoin
find . -type f -print0 | xargs -0 sed -i 's/litecoin/coppercoin/g'
find . -type f -print0 | xargs -0 sed -i 's/Litecoin/Coppercoin/g'
find . -type f -print0 | xargs -0 sed -i 's/LiteCoin/CopperCoin/g'
find . -type f -print0 | xargs -0 sed -i 's/LITECOIN/COPPERCOIN/g'
find . -type f -print0 | xargs -0 sed -i 's/LTC/CPR/g'
find . -type f -print0 | xargs -0 sed -i 's/ltc/cpr/g'
find . -type f -print0 | xargs -0 sed -i 's/Ltc/Cpr/g'
```

Replace litecoin with new ALT coin file name 

```sh
cd ~/coopercoin
mv ./src/libmw/include/mw/exceptions/LTCException.h ./src/libmw/include/mw/exceptions/CPRException.h
mv ./test/functional/ltc_replacebyfee.py ./test/functional/cpr_replacebyfee.py
mv ./test/functional/test_framework/ltc_util.py ./test/functional/test_framework/cpr_util.py
mv ./src/qt/res/icons/litecoin_splash.png src/qt/res/icons/coppercoin_splash.png
mv ./doc/man/litecoin-cli.1 ./doc/man/coppercoin-cli.1
mv ./doc/man/litecoind.1 ./doc/man/coppercoind.1
mv ./doc/man/litecoin-tx.1 ./doc/man/coppercoin-tx.1
mv ./doc/man/litecoin-wallet.1 ./doc/man/coppercoin-wallet.1
mv ./doc/man/litecoin-qt.1 ./doc/man/coppercoin-qt.1
```

### 2. Update 'magic number' in pchMessageStart to unique value

```c++
pchMessageStart[0] = 0xea;
pchMessageStart[1] = 0xf7;
pchMessageStart[2] = 0xbc;
pchMessageStart[3] = 0xa5;
```
### 3. Update base58Prefixes to unique values

https://en.bitcoin.it/wiki/List_of_address_prefixes


```c++
base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,28); // C
base58Prefixes[SECRET_KEY] =     std::vector<unsigned char>(1,28);
base58Prefixes[EXT_PUBLIC_KEY] = {0x14, 0x88, 0xB2, 0x1E};
base58Prefixes[EXT_SECRET_KEY] = {0x14, 0x88, 0xAD, 0xE4};
```

### 5. Add log code to find the Genesis Block and associated Merkle Root after change time and phrase timestamp

### 6. Assign the Genesis Block and associated Merkle Root from no.5
  
### 7. Create new checkpointdata and chaintxdata

In checkpointdata, you will need remove all existing checkpoints and create a new one for block 0 which has a value set to the genesis hash.

In chaintxdata, you will need to update the timestamp to the time value supplied to H0 and set everything else to 0.


### 8. Update dnsseeds and seednodes 

### 9. Set Minimum Test Chain Work to 0x00 

### 10. Change the default ports
```sh
find . -type f -print0 | xargs -0 sed -i 's/9333/7333/g'; // P2P port
find . -type f -print0 | xargs -0 sed -i 's/9332/7332/g'; // RPC port
```

### 11. Add seednodes 

To generate the seeds using following steps :

change directory to contrib/seeds then :

- In nodes_test.txt and nodes_main.txt set all your nodes IPs exp 10.11.12.13:8333

Junee's server:
-  mainnet 1 : 152.69.160.185
-  mainnet 2 : 152.67.113.229
-  testnet 1 : 152.69.166.104
 

Jua's server:
-  mainnet 1 : 192.9.184.132
-  mainnet 2 : 192.9.185.56
-  testnet 1 : 152.69.175.220 

- run generate-seeds.py 
 ```sh
python3 generate-seeds.py . > ../../src/chainparamsseeds.h
 ```
- Check your chainparamsseeds.h file


### 12. Install the yum-utils package (which provides the yum-config-manager utility) and set up the repository.


 ```sh
 sudo yum install -y yum-utils
 sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
 yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
 systemctl start docker
 systemctl enable docker 
 docker build -t coppercoin .

 docker tag coppercoin seoyonglim/coppercoin:v2
 docker push seoyonglim/coppercoin:v2
 
 docker run -d --name coppercoin -v /opt/coppercoin.conf:/etc/coppercoin.conf -v /opt/data:/opt/data -p 7332:7332 -p 7333:7333 -p 19444:19444 coppercoin 

 systemctl start firewalld
 sudo firewall-cmd --zone=public --add-port=7332/tcp
 sudo firewall-cmd --zone=public --add-port=7333/tcp
 sudo firewall-cmd --zone=public --add-port=19444/tcp
 systemctl stop firewalld
 systemctl disable firewalld
 ```

### 13. Pull container and run coppercoin
```sh
docker pull seoyonglim/coppercoin:v1
docker run -d --restart=always --name coppercoin -v /opt/coppercoin.conf:/etc/coppercoin.conf -v /opt/data:/opt/data -p 7332:7332 -p 7333:7333 -p 19444:19444 seoyonglim/coppercoin:v1
```

## How to Install Cooperco9in
```sh 
#!/bin/bash
echo "Praying... Press [CTRL+C] to stop"
while :
do
  coppercoin-cli -rpcuser=seoyong -rpcpassword=seoyongpw -generate 1
done
```