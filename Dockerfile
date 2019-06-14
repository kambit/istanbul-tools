FROM ubuntu:16.04 as builder

WORKDIR /

RUN apt-get update && \
    apt-get install -y \
            build-essential \
            git \
            libdb-dev \
            libsodium-dev \
            libtinfo-dev \
            sysvbanner \
            unzip \
            wget \
            wrk \
            zlib1g-dev \
            libleveldb-dev

ENV GOREL go1.12.5.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /root/

RUN wget -q https://storage.googleapis.com/golang/$GOREL && \
    tar xfz $GOREL && \
    mv go /usr/local/go && \
    rm -f $GOREL

RUN git clone https://github.com/jpmorganchase/istanbul-tools.git && \
    cd istanbul-tools && \ 
    make

ENV PATH $PATH:/istanbul-tools/build/bin/
