### 简介

源码仓库：https://github.com/qjfoidnh/BaiduPCS-Go.git

GitHub Actions仓库：https://github.com/Kyxie/Actions-BaiduPCS.git

DockerHub仓库：https://hub.docker.com/r/kyxie/baidupcs-go

参考：[Debian使用Docker部署BaiduPCS Go | Kunyang's Blog](https://kyxie.me/zh/blog/tech/server/debian/baidupcs-go/)

### 运行容器

#### 直接运行

```bash
docker run -d -it --name baidupcs-go \
  -v $(pwd)/data:/data \
  -v $(pwd)/upload:/upload \
  -v $(pwd)/config:/root/.config/BaiduPCS-Go \
  -w /upload \
  kyxie/baidupcs-go:latest
```

#### Docker Compose（推荐）

`docker-compose.yml`

```yml
services:
  baidupcs-go:
    image: kyxie/baidupcs-go:latest
    container_name: baidupcs-go

    stdin_open: true
    tty: true

    volumes:
      - ./data:/data
      - ./upload:/upload
      - ./config:/root/.config/BaiduPCS-Go

    working_dir: /upload
```

#### 进入容器，登录，下载

详见：[Debian使用Docker部署BaiduPCS Go | Kunyang's Blog](https://kyxie.me/zh/blog/tech/server/debian/baidupcs-go/)

### Overview

- **Source repository:** https://github.com/qjfoidnh/BaiduPCS-Go.git
- **GitHub Actions repository:** https://github.com/Kyxie/Actions-BaiduPCS.git
- **Docker Hub repository:** https://hub.docker.com/r/kyxie/baidupcs-go
- **Reference tutorial:** [Deploying BaiduPCS-Go with Docker on Debian | Kunyang's Blog](https://kyxie.me/zh/blog/tech/server/debian/baidupcs-go/)

### Running the Container

#### Run directly

```bash
docker run -d -it --name baidupcs-go \
  -v $(pwd)/data:/data \
  -v $(pwd)/upload:/upload \
  -v $(pwd)/config:/root/.config/BaiduPCS-Go \
  -w /upload \
  kyxie/baidupcs-go:latest
```

#### Docker Compose (recommended)

```yml
services:
  baidupcs-go:
    image: kyxie/baidupcs-go:latest
    container_name: baidupcs-go

    stdin_open: true
    tty: true

    volumes:
      - ./data:/data
      - ./upload:/upload
      - ./config:/root/.config/BaiduPCS-Go

    working_dir: /uploaddocker-compose.yml
yamlCopyEditservices:
  baidupcs-go:
    image: kyxie/baidupcs-go
    container_name: baidupcs-go
    stdin_open: true
    tty: true
    volumes:
      - ./upload:/upload
      - ./pcs_config:/root/.config/BaiduPCS-Go
    working_dir: /upload
    command: sleep infinity
```

#### Interactive Mode, Login and Download

See: [Deploying BaiduPCS-Go with Docker on Debian | Kunyang's Blog](https://kyxie.me/zh/blog/tech/server/debian/baidupcs-go/)