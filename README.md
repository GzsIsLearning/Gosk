# GOSK

> **Git can be the OS for knowledge.**
> Your wiki has a kernel now.

---

You already use Git for code. You know `commit`, `branch`, `merge`, `PR review`, `blame`. You use them every day.

**So why does your knowledge — paper notes, experiment logs, reading summaries — live outside of Git?**

Git spent a decade perfecting a collaboration infrastructure: version history, exploratory branches, human review, incremental diffs, conflict resolution. Code got all of it. Knowledge got nothing.

GOSK does one simple thing: **use Git to manage knowledge, as-is.** No abstraction layer. No dedicated database. No new learning curve. Your knowledge base is a Git repository. `git log` is your knowledge evolution history. `git blame` is your provenance trace. PR review is your human approval workflow.

GOSK is not a note-taking app. It's not a "chat with your PDF" tool.

GOSK is a **knowledge repository runtime**. Git is the kernel. Markdown is the filesystem. Agents are the processes. The Git skills you already have are your entry ticket.

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

## Architecture

```
File system  = knowledge body (markdown + YAML frontmatter)
Git          = OS kernel (version, branch, review, blame)
Issue        = agent-human dialogue surface
PR           = knowledge proposal, requires human approval
Agent        = OS process (scout / reader / curator / lint / share)
Cron         = scheduler (daily scout, weekly lint)
```

### OS primitives (Git)

| Git primitive | OS equivalent   | Knowledge meaning          |
|---------------|-----------------|----------------------------|
| `git init`    | mkfs            | Create a knowledge base    |
| `git add`     | write           | Propose a knowledge claim  |
| `git commit`  | checkpoint      | Record a knowledge claim   |
| `git branch`  | fork process    | Explore a hypothesis       |
| `git merge`   | commit decision | Human accepts or rejects   |
| `git log`     | audit trail     | Trace knowledge evolution  |

### Higher-level primitives (GitHub / GitLab)

| Platform primitive | OS equivalent    | Knowledge meaning          |
|--------------------|------------------|----------------------------|
| Issue              | message queue    | Agent-human dialogue       |
| Pull Request       | capability check | Human must approve         |
| Review comment     | signal           | Human feedback to agent    |
| Actions / CI       | cron scheduler   | Automated agent processes  |

### OS processes (Agents)

| Agent      | Git action                        | Trigger        |
|------------|-----------------------------------|----------------|
| **scout**  | Opens Issue with candidates       | Cron (daily)   |
| **reader** | Serves items via web UI           | On demand      |
| **curator**| Proposes PRs to maps/             | Issue event    |
| **lint**   | Opens Issue with findings         | Cron (weekly)  |
| **share**  | Pushes to external channels       | PR merge event |

---

## Repository structure (instance convention)

GOSK does not enforce structure. Each instance declares its own conventions in `GOSK.md`. A typical paper library layout:

```
<repo>/
├── items/              ← Knowledge atoms (source papers, notes)
│   └── <slug>/
│       ├── body.md     ← Immutable source content
│       └── meta.yaml   ← Metadata (tags, sources, confidence)
├── maps/               ← Compiled knowledge (cross-item synthesis)
│   ├── lineage/        ← How methods evolve
│   ├── problems/       ← What remains unsolved
│   └── experience/     ← Lessons from doing, not from reading
├── index.md            ← Catalog
├── GOSK.md             ← This instance's constitution
└── log.md              ← Append-only event log
```

---

## vs RAG

RAG re-searches from scratch on every query. Knowledge sits in vector stores — no structure, no audit trail, no version history.

GOSK compiles once, retrieves anytime. Knowledge lives in a Git repository — with history, review, and provenance. Agents compile knowledge. Humans approve the merge. Anyone can challenge any claim by opening an Issue. After the debate settles, `git log` shows exactly how the conclusion was reached.

This is not a technical choice. This is a **difference in epistemology**.

---

## The human role

You are the kernel's **capability system**. Nothing enters `maps/` without your merge.

Your responsibilities:
- **Review** agent PRs (accept, reject, request changes)
- **Calibrate** scout taste (feedback in Issues: why this paper is worth reading, why that one isn't)
- **Highlight** key passages while reading (triggers curator update workflow)
- **Resolve** conflicts (two contradictory knowledge claims — you decide)

Everything else is automation.

---

## What GOSK does not define

- `items/` structure — declared per-instance in `GOSK.md`
- `maps/` layers — domain-specific
- Agent implementation — any program that can open Issues and PRs is a GOSK agent
- Web reader — optional, decoupled component
- Share pipeline — optional, decoupled component

---

## Status

Pre-release. Building in the open.

First instance: remote sensing AI paper library (130 papers, 5-layer knowledge model).
First agent: scout (autonomous arXiv scanning + taste scoring).

---

## License

MIT
