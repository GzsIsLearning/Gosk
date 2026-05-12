# GOSK

> **Git can be the OS for knowledge.**
> Your wiki has a kernel now.

---

你已经在用 Git 管理代码了。你懂 `commit`、`branch`、`merge`、`PR review`、`blame`。你每天都在用。

**那为什么你的知识——论文笔记、实验日志、读书摘要——不用同一套东西来管？**

Git 用十年时间打磨出了一整套完美的协作基础设施：版本追溯、分支探索、人类审查、增量变更、冲突裁决。代码享受了这一切。知识没有。

GOSK 做的事情极其简单：**把 Git 原样搬过来管知识。** 不加一层抽象的壳，不加一个专用的数据库，不加一个新的学习曲线。你的知识库就是一个 Git 仓库。`git log` 就是你的知识演化史。`git blame` 就是你的知识溯源。PR review 就是你的人类审查流程。

GOSK 不是笔记软件。不是"和你的 PDF 聊天"。

GOSK 是一个**知识仓库的运行时**。Git 是内核。Markdown 是文件系统。Agent 是进程。你已有的 Git 技能是入场券。

---

## What it does

- Any knowledge that can live in markdown files gets a full OS stack: version history (git log), exploration branches (git branch), human review (PR), provenance (git blame), incremental understanding (git diff).
- AI agents operate as OS processes — they open issues, propose changes, respond to human review.
- Human judgment is the scheduler. Nothing enters the knowledge base without your merge.

---

## What it's not

- Not a database. Git is the database.
- Not a RAG pipeline. Knowledge is compiled, not retrieved.
- Not tied to any domain. Run a paper library. Run a lab notebook. Run a company wiki.

---

## 架构原则

```
文件系统 = 知识本体（Markdown + YAML frontmatter）
Git      = OS 内核（版本、分支、审查、溯源）
Issue    = 人机对话界面
PR       = 知识提案，人类审批
Agent    = OS 进程（scout / reader / curator / lint / share）
Cron     = 调度器（每日侦察、每周巡检）
```

### 内核原语（Git）

| Git 操作 | OS 等价 | 知识含义 |
|-----------|---------|----------|
| `git init` | mkfs | 创建知识库 |
| `git add` | 写操作 | 提出知识声明 |
| `git commit` | 检查点 | 记录知识声明 |
| `git branch` | fork 进程 | 探索假设 |
| `git merge` | 提交判决 | 人类接受或拒绝 |
| `git log` | 审计追踪 | 追溯知识演化 |

### 上层原语（GitHub / GitLab）

| 平台操作 | OS 等价 | 知识含义 |
|-----------|---------|----------|
| Issue | 消息队列 | Agent 与人类对话 |
| Pull Request | 能力检查 | 人类必须批准才能合入 |
| Review Comment | 信号 | 人类对 Agent 的反馈 |
| Actions / CI | 调度器 | 定时运行的 Agent 进程 |

### OS 进程（Agent）

| Agent | Git 行为 | 触发方式 |
|-------|----------|----------|
| **scout**（侦察兵） | 发现候选，开 Issue | 每日定时 |
| **reader**（阅读器） | 起 Web 服务，渲染知识 | 按需启动 |
| **curator**（策展人） | 对 maps/ 发起 PR | Issue 事件触发 |
| **lint**（巡检员） | 检查完整性，开 Issue | 每周定时 |
| **share**（分享者） | 推送到外部渠道 | PR 合并事件触发 |

---

## 知识库结构（实例约定）

GOSK 不强制约束结构。每个实例通过 `GOSK.md` 声明自己的规则。以下是一个论文库的典型布局：

```
<repo>/
├── items/              ← 知识原子（论文原文、笔记）
│   └── <slug>/
│       ├── body.md     ← 不可变内容（原文）
│       └── meta.yaml   ← 元数据（标签、来源、置信度）
├── maps/               ← 合成知识（跨篇提炼）
│   ├── lineage/        ← 方法演化
│   ├── problems/       ← 未解决问题
│   └── experience/     ← 经验教训（来自实验，不是来自论文）
├── index.md            ← 目录
├── GOSK.md             ← 本实例的宪法（领域、规则、标签体系）
└── log.md              ← 追加式事件日志
```

---

## 与 RAG 的本质区别

RAG 是"每次提问重新搜索"。知识在向量库里，没有结构，没有审计，没有版本。

GOSK 是"编译一次，随时取用"。知识在 Git 仓库里——有历史、有审查、有溯源。Agent 编译知识，人类批准合入。任何人对任何一条知识有异议，开 Issue 讨论。结论沉淀之后，`git log` 里能看到结论是如何形成的。

这不是技术选择差异。这是**知识观**的差异。

---

## 人类的角色

你是内核的**能力系统**。未经你 merge，任何内容不得进入 `maps/`。

你的职责：
- **审查** Agent 发起的 PR（接受、拒绝、要求修改）
- **校准** scout 的品味（在 Issue 里反馈：为什么这篇值得读、那篇不值得）
- **高亮** 阅读时的关键段落（触发 curator 的更新流程）
- **裁决** 争议（两条矛盾的知识声明，你决定哪个对）

其余都是自动化。

---

## GOSK 不定义的部分

- `items/` 的具体结构——由 `GOSK.md` 按领域声明
- `maps/` 的层数——由领域决定
- Agent 的实现——任何能开 Issue 和 PR 的程序，都可以是 GOSK agent
- Web 阅读器——可选组件，无耦合
- 分享管道——可选组件，无耦合

---

## 当前状态

预发布。正在公开构建中。

第一个实例：遥感 AI 论文知识库（130 篇，5 层知识模型）。
第一个 Agent：scout（arXiv 自主扫描 + 品味评分）。

---

## License

MIT
