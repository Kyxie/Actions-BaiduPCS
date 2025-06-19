# BaiduPCS-Go Docker 镜像构建文件
# Maintained by Kyxie <github.com/Kyxie>

FROM alpine:latest

LABEL maintainer="Kyxie <github.com/Kyxie>"
LABEL description="A lightweight BaiduPCS-Go Docker image, built from qjfoidnh/BaiduPCS-Go"

ARG BPCS_VER=v3.9.7
ENV BPCS_VER=${BPCS_VER}

RUN apk add --no-cache curl unzip bash \
  && curl -L -o /tmp/BaiduPCS-Go.zip https://github.com/qjfoidnh/BaiduPCS-Go/releases/download/${BPCS_VER}/BaiduPCS-Go-${BPCS_VER}-linux-amd64.zip \
  && unzip /tmp/BaiduPCS-Go.zip -d /usr/bin \
  && chmod +x /usr/bin/BaiduPCS-Go \
  && rm -rf /tmp/*

VOLUME ["/data", "/root/.config/BaiduPCS-Go"]

WORKDIR /data
ENTRYPOINT ["BaiduPCS-Go"]
CMD ["--help"]
