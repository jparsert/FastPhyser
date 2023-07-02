## REQUIREMENTS
* cmake v3.24
* Sy2CPP
* xgboost
* boost graph, program_options
* (oneTBB)[https://github.com/oneapi-src/oneTBB/blob/master/INSTALL.md]  (It is known that there might be compilation issues with GCC version 11)
* antlr (https://www.antlr.org/download.html) in particular the following tar ball has to be downloaded and installed: https://www.antlr.org/download/antlr4-cpp-runtime-4.12.0-source.zip
* z3 (libraries and headers)

## RUN DOCKER
Note that depending on type of installation the following commands might need to be run using `sudo`

```
sudo docker build -t fastphyser .
sudo docker run -it fastphyser
```

You should no be in the Docker container. Now we run:

```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
```

`./FastPhyser --strategy AlphaZero_complete -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 50`

`./FastPhyser --strategy balancedBDMC -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 51`

## Compile on Amazon EC2

```
sudo yum install -y wget
sudo yum install -y unzip
sudo yum install -y cmake
sudo yum install -y git
sudo yum install -y gcc
sudo yum install -y gcc-c++
sudo yum install boost
sudo yum install boost-static
sudo yum install java-11-amazon-corretto
```


Install oneTBB
```
git clone https://github.com/oneapi-src/oneTBB
cd oneTBB
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr .. 
make
sudo make install
```

Install xgboost
```
git clone --recursive https://github.com/dmlc/xgboost
cd xgboost
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr .. 
make
sudo make install
```

Install Antlr
```
wget https://www.antlr.org/download/antlr4-cpp-runtime-4.12.0-source.zip
mkdir antlr
unzip antlr4-cpp-runtime-4.12.0-source.zip -d antlr
cd antlr
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr .. 
make
sudo make install
```

Install Sy2CPP (Not necessary anymore when using cmake)
```
git clone https://github.com/jparsert/Sy2CPP
cd Sy2CPP
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr .. 
make
sudo make install
```

Now compile FastPhyser
```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
```


## Compile

```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
```
