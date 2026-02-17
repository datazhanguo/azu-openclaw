# Skill: 同步到 GitHub

将 OpenClaw 工作区同步到 GitHub 仓库。

## 触发条件

- 用户说"同步"、"sync"、"上传"、"保存到 GitHub"
- 定期自动执行

## 执行步骤

### 1. 确定目标仓库

默认同步到: `datazhanguo/azu-openclaw`

如果需要同步到其他仓库，先询问用户。

### 2. 同步文件

需要同步的关键文件：

```bash
# 工作区核心文件
~/.openclaw/workspace/SOUL.md      # AI 人格
~/.openclaw/workspace/USER.md      # 用户信息
~/.openclaw/workspace/MEMORY.md    # 长期记忆
~/.openclaw/workspace/memory/      # 每日记忆

# 配置文件（选择性同步，不含密钥）
~/.openclaw/openclaw.json         # 主配置（脱敏后）
```

### 3. 执行同步

```bash
cd ~/.openclaw/workspace

# 如果是首次同步到 azu-openclaw
git remote add origin https://github.com/datazhanguo/azu-openclaw.git 2>/dev/null || true

# 添加所有文件
git add -A

# 提交
git commit -m "sync: $(date '+%Y-%m-%d %H:%M')"

# 推送
git push origin main || git push origin master
```

### 4. 脱敏处理

同步配置文件时，需要隐藏敏感信息：
- API Key → 替换为 `YOUR-XXX-API-KEY`
- App Secret → 替换为 `YOUR-XXX-SECRET`
- Token → 替换为 `change-me`

## 输出

- 成功: "✅ 已同步到 GitHub: https://github.com/datazhanguo/azu-openclaw"
- 失败: 说明错误原因

## 自动同步触发

可以设置 cron 任务定期同步，或在每次重要更新后手动同步。
