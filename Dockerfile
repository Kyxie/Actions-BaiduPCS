# ---------- build stage ----------
FROM golang:1.23-alpine AS builder

WORKDIR /src
COPY . .

RUN go mod download \
    && CGO_ENABLED=0 go build -ldflags="-s -w" -o BaiduPCS-Go main.go

# ---------- runtime stage ----------
FROM alpine:3.20
LABEL maintainer="Kyxie <github.com/Kyxie>" \
      description="Lightweight BaiduPCS-Go image"

RUN apk add --no-cache ca-certificates mailcap tzdata

COPY --from=builder /src/BaiduPCS-Go /usr/local/bin/

VOLUME ["/data", "/root/.config/BaiduPCS-Go"]
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/BaiduPCS-Go"]
CMD ["daemon"]