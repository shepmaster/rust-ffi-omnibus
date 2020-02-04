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
        && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
        && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
        && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
        && apt-get update \
        \
        && apt-get install -y \
        ghc-8.8.1 \
        mono-devel='6.8.*' \
        nodejs='12.14.*' \
        python3.8 \
        ruby2.6 \
        ruby2.6-dev \
        \
        && rm -rf /var/lib/apt/lists/*

# Install Julia from the official website

RUN \
        curl -L https://julialang-s3.julialang.org/bin/linux/x64/1.3/julia-1.3.1-linux-x86_64.tar.gz --output julia-1.3.1-linux-x86_64.tar.gz \
        && echo 'faa707c8343780a6fe5eaf13490355e8190acf8e2c189b9e7ecbddb0fa2643ad  julia-1.3.1-linux-x86_64.tar.gz' > .sha256 \
        && sha256sum -c .sha256 \
        && rm .sha256 \
        && tar xvf julia-1.3.1-linux-x86_64.tar.gz -C /root
ENV PATH /root/julia-1.3.1/bin:$PATH

# Haskell

ENV PATH /opt/ghc/bin/:$PATH
ENV LC_ALL C.UTF-8

# Ruby

RUN gem install bundler

# Python

RUN \
        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 \
        && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 2

# Rust

ENV USER=root
ENV PATH=/root/.cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

ADD . /omnibus
