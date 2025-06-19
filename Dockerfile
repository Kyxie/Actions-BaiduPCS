# ---------- build stage ----------
FROM alpine:3.20 AS downloader

ARG BPCS_VER=v3.9.7
RUN apk add --no-cache curl unzip ca-certificates \
 && curl -L -o /tmp/bpcs.zip \
      https://github.com/qjfoidnh/BaiduPCS-Go/releases/download/${BPCS_VER}/BaiduPCS-Go-${BPCS_VER}-linux-amd64.zip \
 && unzip -j /tmp/bpcs.zip '*/BaiduPCS-Go' -d /usr/local/bin

# ---------- runtime stage ----------
FROM alpine:3.20
LABEL maintainer="Kyxie <github.com/Kyxie>" \
      description="Lightweight BaiduPCS-Go image"

RUN adduser -D pcs

COPY --from=downloader /usr/local/bin/BaiduPCS-Go /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER pcs
VOLUME ["/data", "/home/pcs/.config/BaiduPCS-Go"]
WORKDIR /data

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sleep", "infinity"]
