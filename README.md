# OmniAI Documentation

[![Built with Starlight](https://astro.badg.es/v2/built-with-starlight/tiny.svg)](https://starlight.astro.build)

OmniAI 文档站点，基于 Astro Starlight 构建，提供统一的 API 接口文档，支持多种 AI 模型的无缝调用。

## 🚀 快速开始

### 开发环境

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

访问 `http://localhost:4321` 查看文档站点。

### Docker 部署

```bash
# 构建 Docker 镜像
./build.sh

# 运行容器
./dev.sh
```

或使用 Docker Compose：

```bash
docker-compose up -d
```

## 📁 项目结构

```
omniai_doc/
├── docker/              # Docker 配置文件
│   ├── Dockerfile      # 多阶段构建配置
│   └── nginx.conf      # Nginx 配置（包含安全头和缓存）
├── public/             # 静态资源
│   └── omniai/brands/  # 品牌 Logo
├── src/
│   ├── content/docs/   # 文档内容
│   └── pages/          # 页面文件
├── astro.config.mjs    # Astro 配置
├── docker-compose.yaml # Docker Compose 配置
└── package.json        # 项目依赖
```

## 🧞 可用命令

| 命令                | 说明                            |
| :----------------- | :------------------------------ |
| `npm install`      | 安装项目依赖                      |
| `npm run dev`      | 启动开发服务器 `localhost:4321`   |
| `npm run build`    | 构建生产版本到 `./dist/`          |
| `npm run preview`  | 预览构建结果                      |
| `npm run lint`     | 运行 ESLint 检查                 |
| `npm run format`   | 使用 Prettier 格式化代码          |

## 🔧 配置说明

### 环境变量

复制 `.env.example` 为 `.env` 并根据需要修改：

```bash
cp .env.example .env
```

### Docker 配置

- 使用多阶段构建减少镜像大小
- Nginx 配置包含安全头、Gzip 压缩和缓存策略
- 支持健康检查和资源限制

## 🛡️ 安全特性

- 严格的 TypeScript 配置
- 安全的 HTTP 响应头
- 速率限制保护
- 非 root 用户运行容器

## 📝 文档编写

文档文件位于 `src/content/docs/` 目录，支持 Markdown 和 MDX 格式。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目基于 MIT 许可证开源。