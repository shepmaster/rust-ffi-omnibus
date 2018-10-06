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
        && add-apt-repository -y ppa:deadsnakes/ppa \
        && add-apt-repository -y ppa:brightbox/ruby-ng \
        && add-apt-repository -y ppa:hvr/ghc \
        && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
        && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
        && apt-get update \
        \
        && apt-get install -y \
        ghc-8.4.3 \
        mono-devel='5.14.*' \
        nodejs='8.10.*' \
        npm \
        python3.7 \
        ruby2.5 \
        ruby2.5-dev \
        \
        && rm -rf /var/lib/apt/lists/*

# Haskell

ENV PATH /opt/ghc/bin/:$PATH
ENV LC_ALL C.UTF-8

# Ruby

RUN gem install bundler

# Python

RUN \
        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 \
        && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2

# Rust

ENV USER=root
ENV PATH=/root/.cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

ADD . /omnibus
