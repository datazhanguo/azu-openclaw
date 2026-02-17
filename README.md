# 阿祖的 OpenClaw 🤖

> 个人 AI 助手一键部署工具

基于 [OpenClaw](https://github.com/openclaw/openclaw) 的个人 AI 助手，支持飞书、Telegram 等多平台接入。

## 功能特性

- 🤖 **AI 对话** - 接入了 Kimi、MiniMax、GLM-4 等大模型
- 💬 **多平台支持** - 飞书、Telegram、Discord 等
- 🧠 **长期记忆** - 自动保存对话上下文
- 🔗 **工具集成** - 浏览器自动化、网页搜索、文档处理等

## 快速开始

### 一键安装（Linux/macOS）

```bash
curl -sSL https://raw.githubusercontent.com/datazhanguo/azu-openclaw/main/install.sh | bash
```

### 或者手动安装

1. 克隆仓库
```bash
git clone https://github.com/datazhanguo/azu-openclaw.git
cd azu-openclaw
```

2. 运行安装脚本
```bash
chmod +x install.sh
./install.sh
```

3. 配置

复制配置模板并编辑：
```bash
cp config.example.json ~/.openclaw/openclaw.json
# 编辑配置，填入你的 API Key
nano ~/.openclaw/openclaw.json
```

4. 启动
```bash
openclaw gateway start
```

## 配置说明

### 模型 API Key

在 `openclaw.json` 中配置：

```json
{
  "models": {
    "providers": {
      "kimicode": {
        "apiKey": "你的 Kimi API Key"
      },
      "minimax": {
        "apiKey": "你的 MiniMax API Key"
      },
      "glmcode": {
        "apiKey": "你的 GLM API Key"
      }
    }
  }
}
```

### 飞书配置

```json
{
  "channels": {
    "feishu": {
      "enabled": true,
      "appId": "你的 App ID",
      "appSecret": "你的 App Secret"
    }
  }
}
```

## 常用命令

```bash
# 启动 Gateway
openclaw gateway start

# 查看状态
openclaw status

# 查看日志
openclaw logs --follow

# 健康检查
openclaw doctor
```

## 项目结构

```
azu-openclaw/
├── install.sh          # 一键安装脚本
├── config.example.json # 配置模板
├── .gitignore
└── README.md
```

## 获取 API Key

- [Kimi](https://platform.moonshot.cn/) - 月之暗面
- [MiniMax](https://platform.minimaxi.com/) - 稀宇科技
- [GLM](https://open.bigmodel.cn/) - 智谱清言

## 文档

- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [飞书机器人配置](https://open.feishu.cn/)

## License

MIT
