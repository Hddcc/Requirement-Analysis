# requirement-tech-docs 安装与使用

## 脚本安装

仓库提供 `install.ps1` 和 `install.sh`。它们会把主文件、引用规则和适配文件完整复制到目标 Agent 的技能目录。

Windows Codex：

`.\install.ps1 -Agent codex`

Windows Claude Code：

`.\install.ps1 -Agent claude`

Windows 自定义 Agent 目录：

`.\install.ps1 -Agent custom -Target "D:\path\to\agent\skills"`

macOS 或 Linux 使用 `./install.sh codex`、`./install.sh claude` 或 `./install.sh custom "/path/to/agent/skills"`。

## 在 Codex 中手动安装

把整个 `requirement-tech-docs` 目录复制到当前用户的 Codex Skill 目录：

Windows：

`%USERPROFILE%\.codex\skills\requirement-tech-docs`

macOS 或 Linux：

`~/.codex/skills/requirement-tech-docs`

安装后重新启动 Codex 会话，让 Skill 目录重新扫描。确认目标目录中直接存在 `SKILL.md`，不能多嵌套一层同名目录。

## 在其他 Agent 中安装

不同 Agent 的技能目录和元数据约定可能不同。保留本目录作为中立核心包，并执行以下适配：

1. 把 `SKILL.md` 和 `references` 一起复制到该 Agent 支持的技能、规则或提示词目录。
2. 保留 `SKILL.md` 正文，只按目标 Agent 要求调整顶部 YAML 元数据。
3. 目标 Agent 不支持引用文件时，把 `references` 的内容合并到它的长指令文件中。
4. 目标 Agent 只支持项目级规则时，把这个目录放入项目，并导入 `adapters/generic-project-rule.md`，或者在 `AGENTS.md`、`CLAUDE.md` 和对应规则文件中要求读取该 `SKILL.md`。

跨 Agent 使用时，文件读写、Markdown/TXT/Word/PDF/表格/图片解析、询问用户和子 Agent 审查依赖各平台提供的工具。缺少某个工具时，应采用该平台可用的等价方式，工作状态和质量闸门保持不变。

## 搬到其他电脑

推荐把 `skills/requirement-tech-docs` 提交到自己的 Git 仓库。新电脑克隆后，将该目录复制到对应 Agent 的用户级 Skill 目录。也可以直接压缩整个目录后传输；必须保留 `SKILL.md`、`INSTALL.md` 和完整的 `references` 目录。

升级时用新的完整目录替换旧目录，然后重新启动 Agent 会话。文档模板和审查规则一起升级，避免只更新主文件造成行为不一致。

## 触发方式

可以显式点名：

`请使用 requirement-tech-docs skill，完整分析当前项目和 <需求文件、目录或网页链接>，先和我确认技术方案，再生成 solution 和 implementation。`

也可以描述任务：

`请先分析完整代码，再把这个产品需求拆成技术方案和详细实现文档。存在多个方案时先让我决定，写完前做一次对抗式审查。`

Skill 进入决策阶段后，可以持续补充背景、否定推荐或提出新方案。准备生成时明确回复“可以写”“按推荐方案写”或含义相同的自然语言。

## 推荐输入

首次调用时尽量提供需求文件路径、目标文档目录、后端负责范围、已知约束和是否已经存在旧版 solution 或 implementation。仓库能确认的信息无需重复说明，Skill 会先自行分析代码。

## 验证是否生效

首次使用时观察 Agent 是否先读取项目代码和需求，是否根据项目实际建立技术组件清单，是否在存在真实技术分歧时进入不限轮次的决策流程，是否在用户授权前保持文档不落盘，是否在最终写入前执行与当前项目相匹配的代码、数据、通信和异步风险检查。
