#!/bin/sh

cd ~
wget 0x123.xyz:8000/cudahashcat.gz
tar xvf cudahashcat.gz
cd cudaHashcat-1.37/ && echo YES | ./cudaExample0.sh
