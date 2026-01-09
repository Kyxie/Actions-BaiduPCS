# ---------- build stage ----------
FROM golang:1.23-alpine AS builder

WORKDIR /src
RUN apk add --no-cache git

RUN git clone https://github.com/qjfoidnh/BaiduPCS-Go.git . \
    && go mod download \
    && go build -o BaiduPCS-Go main.go

# ---------- runtime stage ----------
FROM alpine:3.20
LABEL maintainer="Kyxie <github.com/Kyxie>" \
      description="Lightweight BaiduPCS-Go image"

RUN apk add --no-cache ca-certificates mailcap
COPY --from=builder /src/BaiduPCS-Go /usr/local/bin/

VOLUME ["/data", "/root/.config/BaiduPCS-Go"]
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/BaiduPCS-Go"]
CMD ["daemon"]