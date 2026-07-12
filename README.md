# Requirement-Analysis

`Requirement-Analysis` 是一个面向后端开发者的通用需求分析 Skill。它会先阅读真实代码仓库和产品需求，再经过不限轮次的技术方案讨论、用户决策和对抗式审查，最终生成两份正式中文文档：

- `solution.md`：解释需求、当前代码、候选方案、最终选型、接口与数据设计、联调边界、风险和验收标准。
- `implementation.md`：说明精确到文件、类型、函数、完整调用链、配置、MySQL、Redis、Lua、消息队列、测试和联调的实现步骤。

Skill 不预设语言、框架、数据库、消息队列和外部平台。每次执行都会以当前仓库源代码为准，识别实际技术栈、服务挂载、代码分层、命名方式、错误处理、数据结构和测试习惯。

## 主要能力

Skill 会先建立项目事实地图，再拆解产品需求。代码能够确认的事实由 Agent 自行查证，存在真实技术分歧时会向用户展示多个方案、影响和推荐意见。用户可以选择、组合、否定或提出自己的方案，交互轮数没有上限。

当用户仍在补充、纠正或追问时，Skill 会继续维护上下文，不会提前写文档。用户明确表示“可以写”“按推荐方案写”等意图，并且后端阻塞决策已经解决后，才会进入最终写入阶段。

正式写入前会进行对抗式审查，重点检查需求遗漏、代码适配、过度设计、协议兼容、MySQL 旧数据、Redis key 与 Lua、消息重复和乱序、幂等、事务、配置、前端及客户端联调、测试和发布回滚。发现会影响旧代码或旧数据的问题时，会先交给用户决定。

## 仓库结构

```text
Requirement-Analysis/
├── SKILL.md
├── README.md
├── INSTALL.md
├── LICENSE
├── install.ps1
├── install.sh
├── adapters/
│   └── generic-project-rule.md
└── references/
    ├── project-discovery.md
    ├── decision-workflow.md
    ├── solution-template.md
    ├── implementation-template.md
    ├── adversarial-review.md
    └── writing-style-zh.md
```

`SKILL.md` 保存工作状态、阶段闸门和核心规则。`references` 保存项目分析、决策、文档模板、对抗审查和中文写作要求。Agent 使用本 Skill 时需要完整读取主文件引用的规则。

## 快速安装

### Codex

Windows PowerShell：

```powershell
git clone https://github.com/Hddcc/Requirement-Analysis.git
cd Requirement-Analysis
.\install.ps1 -Agent codex
```

macOS 或 Linux：

```bash
git clone https://github.com/Hddcc/Requirement-Analysis.git
cd Requirement-Analysis
./install.sh codex
```

安装位置分别为 `%USERPROFILE%\.codex\skills\requirement-tech-docs` 和 `~/.codex/skills/requirement-tech-docs`。

### Claude Code

Windows PowerShell：

```powershell
.\install.ps1 -Agent claude
```

macOS 或 Linux：

```bash
./install.sh claude
```

安装位置分别为 `%USERPROFILE%\.claude\skills\requirement-tech-docs` 和 `~/.claude/skills/requirement-tech-docs`。安装后重新启动 Claude Code 会话。

### CodeBuddy 和其他 Agent

CodeBuddy 及其他 Agent 的技能目录可能随产品版本和部署方式变化。先在 Agent 设置中找到用户级或项目级 Skills 目录，再执行自定义目录安装。

Windows PowerShell：

```powershell
.\install.ps1 -Agent custom -Target "D:\path\to\agent\skills"
```

macOS 或 Linux：

```bash
./install.sh custom "/path/to/agent/skills"
```

目标 Agent 暂未原生识别 `SKILL.md` 时，把本仓库保留在项目内，并将 `adapters/generic-project-rule.md` 导入 CodeBuddy 项目规则、`AGENTS.md`、`CLAUDE.md` 或该 Agent 的规则配置。适配文件会要求 Agent 在处理产品需求时读取 `SKILL.md` 和全部引用文件。

## 使用方法

安装完成后重新启动 Agent 会话。推荐显式点名 Skill：

```text
请使用 requirement-tech-docs skill，完整分析当前项目和
docs/需求/xxx.docx。存在多种技术方案时先和我讨论，
完成对抗式审查并解决所有阻塞问题后，再生成 solution
和 implementation 文档。
```

也可以直接描述目标：

```text
请先分析完整代码，再把这个产品需求拆成技术方案和详细实现文档。
技术分歧先让我决定，写入前进行一次对抗式审查。
```

首次调用时可以提供需求文件路径、目标文档目录、后端负责范围和已知限制。仓库中能够确认的信息无需重复说明，Agent 会先分析代码。

在方案讨论阶段可以持续补充背景、修改约束、否定推荐或提出新的实现思路。准备生成时回复“可以写”“按推荐方案写”或含义相同的自然语言。

## 输出约束

最终文档以中文为主，代码标识会配中文解释。实现步骤会写清调用方、入口文件和函数、下一层对象、配置与存储、返回值、后续消费者和异步处理。

文档会沿用当前项目风格并保持最小改动，避免无需求依据的兜底、降级、抽象和顺手重构。中文行文会规避“不是 xxx，而是 xxx”“不只是 xxx，而是 xxx”“不仅 xxx，而是 xxx”等先否定再肯定句式。

最终文件直接创建或覆盖原有 solution 和 implementation，不添加 v1、v1.1、新版、修订版等标记，也不保留对话过程和阻塞占位符。

## 更新

在仓库目录执行 `git pull`，然后重新运行对应安装命令。安装脚本会覆盖同名文件并保留标准目录结构。重新启动 Agent 会话后使用新规则。

## 许可证

本项目使用 MIT License。
