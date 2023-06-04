FROM ubuntu:20.04

WORKDIR /

# Dependencias incluyendo nodejs 18 y ignite-cli
RUN apt-get update && apt-get install -y curl build-essential wget gcc && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    wget https://dl.google.com/go/go1.19.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz && \
    rm go1.19.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

RUN export GOROOT=/usr/local/go && \
    export PATH=$PATH:$GOROOT/bin && \
    export PATH=$PATH:/root/go/bin

RUN curl https://get.ignite.com/cli | bash

RUN mv ignite /usr/local/bin/

COPY . /home

VOLUME [ "/home" ]

WORKDIR /home

RUN ignite scaffold chain smart-blockchain

EXPOSE 26657 26656 6060 9090 1317