FROM ubuntu:16.04
MAINTAINER Zachary Waldowski <zach@waldowski.me>
RUN installDeps='curl apt-transport-https ca-certificates' \
    && set -x \
    && apt-get -q update \
    && apt-get -q install -y $installDeps --no-install-recommends \
    && curl -L https://repo.vapor.codes/apt/keyring.gpg | apt-key add - \
    && echo "deb https://repo.vapor.codes/apt xenial main" | tee /etc/apt/sources.list.d/vapor.list \
    && apt-get -q update \
    && apt-get -q install -y --no-install-recommends \
    libpython2.7-dev \
    libsqlite3-dev \
    libpq-dev \
    libxml2 \
    clang-3.8 \
    swift \
    vapor \
    && update-alternatives --quiet --install /usr/bin/clang clang /usr/bin/clang-3.8 100 \
    && update-alternatives --quiet --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100 \
    && apt-get remove -y $installDeps --autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && swift --version \
    && vapor version
