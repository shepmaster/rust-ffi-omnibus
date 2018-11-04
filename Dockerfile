FROM ubuntu:18.04

SHELL ["bash", "-c"]

RUN \
        apt-get update \
        \
        && apt-get install -y \
        build-essential \
        clang \
        curl \
        software-properties-common \
        \
        && rm -rf /var/lib/apt/lists/*

# Install Julia from the official website

RUN \
        curl \
        -vvvvvvv \
        -L \
        https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.1-linux-x86_64.tar.gz \
        --output julia-1.0.1-linux-x86_64.tar.gz \
        && file julia-1.0.1-linux-x86_64.tar.gz \
        && ls -l julia-1.0.1-linux-x86_64.tar.gz \
        && cat julia-1.0.1-linux-x86_64.tar.gz \
        \
        && echo '9ffbcf7f4a111e13415954caccdd1ce90b5c835cee9f62d6ac708f5b752c87dd  julia-1.0.1-linux-x86_64.tar.gz' > .sha256 \
        && sha256sum -c .sha256 \
        && rm .sha256 \
        && tar xvf julia-1.0.1-linux-x86_64.tar.gz -C /root \
        && rm julia-1.0.1-linux-x86_64.tar.gz \

ENV PATH /root/julia-1.0.1/bin:$PATH

# Rust

ENV USER=root
ENV PATH=/root/.cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

ADD . /omnibus
