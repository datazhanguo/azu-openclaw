#!/bin/bash

# 阿祖的 OpenClaw 一键安装脚本
# 作者: 阿祖 (东坡)
# 支持: Linux, macOS

set -e

echo "🤖 阿祖的 OpenClaw 安装程序"
echo "================================"

# 检查系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    SYSTEM="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    SYSTEM="linux"
else
    echo "❌ 不支持的操作系统: $OSTYPE"
    exit 1
fi

echo "📋 检测到系统: $SYSTEM"

# 检查 Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo "✅ Node.js 已安装: $NODE_VERSION"
else
    echo "❌ Node.js 未安装"
    echo "请先安装 Node.js: https://nodejs.org/"
    exit 1
fi

# 检查 npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm 未安装"
    exit 1
fi
echo "✅ npm 已安装"

# 创建配置目录
OPENCLAW_DIR="$HOME/.openclaw"
mkdir -p "$OPENCLAW_DIR"

echo "📁 配置目录: $OPENCLAW_DIR"

# 安装 OpenClaw
echo "📦 安装 OpenClaw..."
npm install -g openclaw

# 验证安装
if command -v openclaw &> /dev/null; then
    echo "✅ OpenClaw 安装成功"
    openclaw --version
else
    echo "❌ OpenClaw 安装失败"
    exit 1
fi

# 创建配置文件（如果不存在）
CONFIG_FILE="$OPENCLAW_DIR/openclaw.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "📝 创建配置文件..."
    cat > "$CONFIG_FILE" << 'EOF'
{
  "meta": {
    "lastTouchedVersion": "2026.2.15"
  },
  "agents": {
    "defaults": {
      "workspace": "~/.openclaw/workspace",
      "compaction": {
        "mode": "safeguard"
      },
      "maxConcurrent": 4,
      "subagents": {
        "maxConcurrent": 8
      },
      "model": {
        "primary": "kimicode/kimi-k2.5"
      }
    }
  },
  "messages": {
    "ackReactionScope": "group-mentions"
  },
  "commands": {
    "native": "auto",
    "nativeSkills": "auto"
  },
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "change-me-after-install"
    },
    "tailscale": {
      "mode": "off"
    }
  },
  "skills": {
    "install": {
      "nodeManager": "npm"
    }
  },
  "models": {
    "mode": "merge",
    "providers": {
      "kimicode": {
        "baseUrl": "https://api.kimi.com/coding",
        "apiKey": "YOUR-KIMI-API-KEY-HERE",
        "api": "anthropic-messages",
        "models": [
          {
            "id": "kimi-k2.5",
            "name": "Kimi K2.5"
          }
        ]
      }
    }
  },
  "channels": {
    "feishu": {
      "enabled": false,
      "appId": "YOUR-APP-ID",
      "appSecret": "YOUR-APP-SECRET",
      "domain": "feishu"
    }
  }
}
EOF
    echo "✅ 配置文件已创建: $CONFIG_FILE"
    echo "⚠️  请编辑配置文件，填入你的 API Key"
fi

# 创建工作区目录
WORKSPACE_DIR="$OPENCLAW_DIR/workspace"
mkdir -p "$WORKSPACE_DIR"

# 复制基础文件
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 复制 workspace 基础文件
if [ -f "$SCRIPT_DIR/workspace/SOUL.md" ]; then
    cp -n "$SCRIPT_DIR/workspace/"* "$WORKSPACE_DIR/" 2>/dev/null || true
fi

# 创建常用脚本
echo "📜 创建快捷命令..."

# 添加到 .bashrc 或 .zshrc
SHELL_RC="$HOME/.bashrc"
if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

# 创建 openclaw 命令别名
if ! grep -q "alias oc=" "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo "# 阿祖的 OpenClaw" >> "$SHELL_RC"
    echo "alias oc='openclaw'" >> "$SHELL_RC"
    echo "alias ocs='openclaw status'" >> "$SHELL_RC"
    echo "alias ocg='openclaw gateway'" >> "$SHELL_RC"
    echo "alias ocl='openclaw logs --follow'" >> "$SHELL_RC"
    echo "✅ 已添加快捷命令到 $SHELL_RC"
    echo "   使用 oc 代替 openclaw"
fi

# 完成
echo ""
echo "================================"
echo "🎉 安装完成！"
echo "================================"
echo ""
echo "下一步："
echo "1. 编辑配置文件: nano $CONFIG_FILE"
echo "2. 填入你的 API Key"
echo "3. 启动: openclaw gateway start"
echo "4. 查看状态: openclaw status"
echo ""
echo "快捷命令:"
echo "  oc   = openclaw"
echo "  ocs  = openclaw status"
echo "  ocg  = openclaw gateway"
echo "  ocl  = openclaw logs --follow"
echo ""
