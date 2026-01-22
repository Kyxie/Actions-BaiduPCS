FROM ubuntu:22.04

# Timezone
ENV TZ=America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND=noninteractive

# Dependencies
RUN apt-get update -y && apt-get full-upgrade -y && \
    apt-get install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
    bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
    git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev \
    libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev \
    libssl-dev libtool lrzsz mkisofs msmtp ninja-build p7zip p7zip-full patch pkgconf python3 \
    python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion swig texinfo \
    uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev sudo time nano

# Non root user
RUN useradd -m -s /bin/bash builduser && \
    echo "builduser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER builduser
WORKDIR /home/builduser

# Clone code and update feeds
RUN git clone https://github.com/coolsnowwolf/lede.git openwrt-source && \
    cd openwrt-source && \
    ./scripts/feeds update -a && \
    ./scripts/feeds install -a

WORKDIR /home/builduser/openwrt-source
CMD ["/bin/bash"]