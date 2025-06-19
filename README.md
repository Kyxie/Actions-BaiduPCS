### 简介

源码仓库：https://github.com/qjfoidnh/BaiduPCS-Go.git

GitHub Actions仓库：https://github.com/Kyxie/Actions-BaiduPCS.git

参考：[Debian使用Docker部署BaiduPCS Go | Kunyang's Blog](http://localhost:1313/zh/blog/tech/router/baidupcs-go/)

### 运行容器

#### 直接运行

```bash
docker run -it \
  --name baidupcs-go \
  -v $(pwd)/upload:/upload \
  -v $(pwd)/pcs_config:/root/.config/BaiduPCS-Go \
  -w /upload \
  kyxie/baidupcs-go \
  sleep infinity
```

#### Docker Compose（推荐）

`docker-compose.yml`

```yml
services:
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