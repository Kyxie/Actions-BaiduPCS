FROM ubuntu:22.04

ENV TZ=America/Toronto
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential libncurses5-dev libncursesw5-dev \
    git python3 gawk curl wget unzip file \
    sudo time rsync \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash builduser && \
    echo "builduser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER builduser
WORKDIR /home/builduser
RUN git clone --depth 1 https://github.com/coolsnowwolf/lede.git openwrt-source

WORKDIR /home/builduser/openwrt-source
RUN ./scripts/feeds update -a || true && \
    ./scripts/feeds install -a && \
    rm -rf .git && \
    rm -rf feeds/*/.git

WORKDIR /home/builduser/openwrt-source
CMD ["/bin/bash"]
