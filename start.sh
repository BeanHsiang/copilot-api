#!/bin/sh
# 自动检测宿主机 VS Code 版本并启动 docker compose

# 尝试从 VS Code CLI 读取版本号
if command -v code >/dev/null 2>&1; then
  DETECTED=$(code --version 2>/dev/null | head -1)
fi

# 尝试从 VS Code app bundle 读取（macOS，CLI 未配置时的备选）
if [ -z "$DETECTED" ] && [ -f "/Applications/Visual Studio Code.app/Contents/Resources/app/package.json" ]; then
  DETECTED=$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['version'])" \
    "/Applications/Visual Studio Code.app/Contents/Resources/app/package.json" 2>/dev/null)
fi

VSCODE_VERSION="${DETECTED:-1.110.1}"

echo "VSCODE_VERSION=${VSCODE_VERSION}" > .env
echo "[start.sh] Using VS Code version: ${VSCODE_VERSION}"

exec docker compose "$@"
