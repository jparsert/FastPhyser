FROM ubuntu:22.04

WORKDIR /home


# Install software

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y cmake
RUN apt-get install -y software-properties-common
RUN apt-get install -y git
RUN apt-get install -y g++-11
RUN apt-get install -y gcc-11
RUN ln -s g++-11 /usr/bin/g++

RUN apt-get install -y libboost-all-dev
#RUN add-apt-repository -y ppa:openjdk-r/ppa
#RUN apt-get update
#RUN apt-get install -y openjdk-11-jdk
RUN add-apt-repository -y ppa:openjdk-r/ppa

RUN apt-get update
RUN apt-get install -y openjdk-11-jdk

WORKDIR /3rdparty


RUN git clone https://github.com/oneapi-src/oneTBB
WORKDIR /3rdparty/oneTBB/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN make -j$(nproc)
RUN make install

WORKDIR /3rdparty
RUN git clone --recursive https://github.com/dmlc/xgboost
WORKDIR /3rdparty/xgboost/build
RUN cmake ..
RUN make -j$(nproc)
RUN make install

WORKDIR /3rdparty
RUN wget https://www.antlr.org/download/antlr4-cpp-runtime-4.12.0-source.zip
RUN mkdir antlr
RUN unzip antlr4-cpp-runtime-4.12.0-source.zip -d antlr
WORKDIR /3rdparty/antlr/build
RUN cmake ..
RUN make -j$(nproc)
RUN make install


WORKDIR /3rdparty
RUN git clone https://github.com/jparsert/Sy2CPP
WORKDIR /3rdparty/Sy2CPP/src/build
RUN cmake ..
RUN make -j$(nproc)
RUN make install



# Get files
ADD . /home/
WORKDIR /home