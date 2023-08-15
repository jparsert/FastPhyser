# Installation and Running instructions

To run experiments we recommend using the docker container as that installs all dependencies etc. automatically.
See instructions to build with docker or by hand below.

To run experiments see the last section.

## Project Structure
* `Data` : contains training/testning data. Both old and newly generated problems
* `src` : source code
* `tools` : scripts etc. for producing figures etc.
* after the experiments the results files will be in the folder `results`
* the `Dockerfile` to run a docker container is in the same folder as this readme.


## REQUIREMENTS
* cmake v3.24
* Sy2CPP
* xgboost
* boost libraries (graph, program_options, circular buffer, ...)
* (oneTBB)[https://github.com/oneapi-src/oneTBB/blob/master/INSTALL.md]  (It is known that there might be compilation issues with GCC version 11)
* antlr (https://www.antlr.org/download.html) in particular the following tar ball has to be downloaded and installed: https://www.antlr.org/download/antlr4-cpp-runtime-4.12.0-source.zip
* z3 (libraries and headers)

To evaluate the json files from the experiments we needs
* python3
* numpy
* pandas
* matplotlib


## RUN DOCKER
Note that depending on type of installation the following commands might need to be run using `sudo`

```
sudo docker build -t fastphyser .
sudo docker run -it fastphyser
```

You should no be in the Docker container with the CWD `/home/FastPhyser` 
To build now run:

```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
```

FastPhyser can now be run as follows:
`./FastPhyser -h` : for help

`./FastPhyser --strategy AlphaZero_complete -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 50`

`./FastPhyser --strategy balancedBDMC -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 51`

to run experiments as in the paper and create graphs go to the last section


## Compile by hand
After all dependencies are installed FastPhyser can be compiled as follows:
```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
```

FastPhyser can now be run as follows:
`./FastPhyser -h` : for help

`./FastPhyser --strategy AlphaZero_complete -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 50`

`./FastPhyser --strategy balancedBDMC -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 51`


## Compile by hand on Amazon EC2

```
sudo yum install -y wget
sudo yum install -y unzip
sudo yum install -y cmake
sudo yum install -y git
sudo yum install -y gcc
sudo yum install -y gcc-c++
sudo yum install -y boost
sudo yum install -y boost-static
sudo yum install -y python3
sudo yum install -y python3-matplotlib
sudo yum install -y python3-numpy
sudo yum install -y python3-pandas

sudo yum install -y java-11-amazon-corretto
FastPhyser can now be run as follows:
`./FastPhyser -h` : for help

`./FastPhyser --strategy AlphaZero_complete -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 50`

`./FastPhyser --strategy balancedBDMC -I ../DataSet/sygus_LIA_train --test-set ../DataSet/sygus_LIA_test --num-parallel 50 --timeout 240 --seed 51`


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

## RUN EXPERIMENTS
We assume you are in the same directory as this README. Further, FastPhyser needs to be built
in the `build` subfolder of this directory. For instructions on how to do this in a docker container
or by hand see above.

To run experiments run:    

`make all`


Not that if the hardware is not as specified in the paper (i.e. Amazon Elastic Compute Cloud (EC2) on a r6a.8xlarge instance with an AMD EPYC 7R13 CPU and 256GB of Memory running Amazon Linux 2 with kernel 6.1.34-58.102.amzn2023.x86\_64)
the program might run out of memory. To change this the level of parallelism needs to be adjusted with the `--num-parallel` argument in the Makefile.

The result files will be in the `results` folder.

To present data and generate plots do:

```
cd tools
python3 main.py
```

Now the plots should be in the `plots` folder