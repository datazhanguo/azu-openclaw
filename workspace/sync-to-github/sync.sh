#!/bin/bash

# 阿祖的 OpenClaw 同步脚本
# 将工作区同步到 GitHub

set -e

REPO="datazhhang/azu-openclaw"
BRANCH="main"

echo "🔄 开始同步到 GitHub..."

# 工作区目录
WORKSPACE="$HOME/.openclaw/workspace"
cd "$WORKSPACE"

# 检查 git
if [ ! -d ".git" ]; then
    echo "📂 初始化 Git 仓库..."
    git init
    git remote add origin "https://github.com/$REPO.git"
fi

# 添加关键文件
echo "📝 添加文件..."
git add SOUL.md USER.md MEMORY.md 2>/dev/null || true
git add memory/ 2>/dev/null || true
git add AGENTS.md TOOLS.md HEARTBEAT.md 2>/dev/null || true
git add skills/ 2>/dev/null || true

# 检查是否有变更
if git diff --staged --quiet; then
    echo "✅ 没有新变更需要同步"
    exit 0
fi

# 提交
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
git commit -m "sync: $TIMESTAMP"

# 推送
echo "🚀 推送到 GitHub..."
git push origin "$BRANCH" --force

echo "✅ 同步完成!"
echo "📦 仓库: https://github.com/$REPO"
