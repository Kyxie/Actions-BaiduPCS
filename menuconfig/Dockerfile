FROM debian:bookworm-slim

ENV TZ=America/Toronto
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libncurses5-dev libncursesw5-dev \
    git python3 gawk curl wget unzip file ca-certificates \
    python3-distutils \
    sudo time rsync \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m -s /bin/bash builduser && \
    echo "builduser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER builduser
WORKDIR /home/builduser

RUN git clone --depth 1 https://github.com/coolsnowwolf/lede.git openwrt-source && \
    cd openwrt-source && \
    ./scripts/feeds update -a || true && \
    ./scripts/feeds install -a && \
    rm -rf .git && \
    rm -rf feeds/*/.git && \
    rm -rf dl/*

WORKDIR /home/builduser/openwrt-source
CMD ["/bin/bash"]
