### 简介

源码仓库：https://github.com/qjfoidnh/BaiduPCS-Go.git

GitHub Actions仓库：https://github.com/Kyxie/Actions-BaiduPCS.git

参考：

### 运行容器

#### 直接运行

```bash
# 拉取最新版
docker pull kyxie/baidupcs-go:latest

# 以交互模式启动
docker run -it --rm \
  -v $(pwd)/data:/data \
  -v $(pwd)/config:/home/pcs/.config/BaiduPCS-Go \
  kyxie/baidupcs-go login
```

#### Docker Compose（推荐）

`docker-compose.yml`

```

```