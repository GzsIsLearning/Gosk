#!/usr/bin/env bash
# GOSK post-merge hook — 合并 PR 后自动运行
# 安装: ln -sf ../../scripts/post-merge.sh .git/hooks/post-merge
# 或通过 GitHub Action 触发

set -e

cd "$(git rev-parse --git-dir)/.."
MERGE_COMMIT=$(git log -1 --format="%s" HEAD)

# 只处理 merge commit
if [[ "$MERGE_COMMIT" != Merge* ]]; then
    exit 0
fi

echo "[gosk] Detected merge: $MERGE_COMMIT"

# 清理测试文件
if [ -f PR_TEST.md ]; then
    git rm PR_TEST.md
    echo "[gosk] Removed PR_TEST.md"
fi

# 检查是否有新 items
NEW_ITEMS=$(git diff --name-only HEAD~1 HEAD -- items/*/meta.yaml 2>/dev/null | wc -l)
if [ "$NEW_ITEMS" -gt 0 ]; then
    echo "[gosk] $NEW_ITEMS new items detected, could trigger curator..."
    # 后续: 在这里触发 curator
fi

# 更新索引
echo "[gosk] Post-merge hook complete"
