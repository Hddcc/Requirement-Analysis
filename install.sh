#!/usr/bin/env sh

set -eu

agent="${1:-codex}"
target="${2:-}"
skill_name="requirement-tech-docs"
source_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

case "$agent" in
  codex)
    skills_root="$HOME/.codex/skills"
    ;;
  claude)
    skills_root="$HOME/.claude/skills"
    ;;
  custom)
    if [ -z "$target" ]; then
      echo "使用 custom 时必须把 Agent 的 Skills 目录作为第二个参数。" >&2
      exit 1
    fi
    skills_root="$target"
    ;;
  *)
    echo "支持的 Agent：codex、claude、custom。" >&2
    exit 1
    ;;
esac

destination="$skills_root/$skill_name"
mkdir -p "$destination/references" "$destination/adapters"

for file in SKILL.md README.md INSTALL.md LICENSE install.ps1 install.sh; do
  cp "$source_dir/$file" "$destination/$file"
done

cp -R "$source_dir/references/." "$destination/references/"
cp -R "$source_dir/adapters/." "$destination/adapters/"

echo "已安装到 $destination"
echo "请重新启动 $agent 会话，使 Skill 被重新扫描。"
