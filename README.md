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
sudo docker build -t FastPhyser .
sudo docker run -it test
```
