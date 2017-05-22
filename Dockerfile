FROM ubuntu:16.04
MAINTAINER Zachary Waldowski <zach@waldowski.me>

# Install base packages
RUN apt-get -q update && \
    apt-get -q install -y \
    pkg-config \
    apt-transport-https \
    apt-utils \
    wget \
    libpython2.7-dev

# Set up Vapor apt repo
RUN wget -q https://repo.vapor.codes/apt/keyring.gpg -O- | apt-key add -
RUN echo "deb https://repo.vapor.codes/apt xenial main" | tee /etc/apt/sources.list.d/vapor.list

# Install related packages and set LLVM 3.6 as the compiler
RUN apt-get -q update && \
    apt-get -q install -y \
    clang-3.8 \
    swift \
    vapor \
    libsqlite3-dev \
    && update-alternatives --quiet --install /usr/bin/clang clang /usr/bin/clang-3.8 100 \
    && update-alternatives --quiet --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100 \
    && rm -r /var/lib/apt/lists/*

# Print Installed Swift Version
RUN swift --version

# Print Installed Swift Version
RUN vapor version
