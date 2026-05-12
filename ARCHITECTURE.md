# GOSK Architecture

> **Git can be the OS for knowledge.**
> This document defines the OS primitives. Concrete implementations go in `agents/`.

---

## 1. The Kernel: Git

Git provides six OS primitives. GOSK does not wrap them — it treats them as system calls.

| Git primitive | OS equivalent    | Knowledge meaning              |
|---------------|------------------|--------------------------------|
| `git init`    | mkfs             | Create a new knowledge base    |
| `git add`     | write            | Propose knowledge              |
| `git commit`  | checkpoint       | Record a knowledge claim       |
| `git branch`  | fork process     | Explore a hypothesis           |
| `git merge`   | commit decision  | Human accepts or rejects       |
| `git log`     | audit trail      | Trace knowledge evolution      |

Higher-level primitives:

| GitHub/GitLab  | OS equivalent    | Knowledge meaning              |
|----------------|------------------|--------------------------------|
| Issue          | message queue    | Agent-human dialogue           |
| Pull Request   | capability check | Human must approve before merge|
| Review comment | signal           | Human feedback to agent        |
| Actions/CI     | cron scheduler   | Automated agent processes      |

---

## 2. The Filesystem: Markdown

Every knowledge atom is a markdown file. Structured by convention, not by schema.

```
<repo>/
├── items/              ← Knowledge atoms (papers, notes, entries)
│   └── <slug>/
│       ├── body.md     ← The content (immutable if source material)
│       └── meta.yaml   ← Frontmatter: tags, sources, confidence
├── maps/               ← Compiled knowledge (cross-item synthesis)
│   ├── lineage/        ← How things evolve
│   ├── problems/       ← Open questions
│   └── experience/     ← Lessons learned (NOT from items, from doing)
├── index.md            ← Catalog
├── GOSK.md             ← This repo's constitution (domain, conventions, tags)
└── log.md              ← Append-only event log
```

GOSK does not enforce this structure. `GOSK.md` declares the conventions for a specific instance. Different domains get different `GOSK.md`.

---

## 3. Processes: Agents

Agents are programs (or AI skills) that interact with the repo through Git primitives.

| Agent       | Git action                  | Trigger         |
|-------------|-----------------------------|-----------------|
| **scout**   | Opens Issue with candidates | Cron (daily)    |
| **reader**  | Serves items via web UI     | On demand       |
| **curator** | Proposes PRs to maps/       | Issue event     |
| **lint**    | Opens Issue with findings   | Cron (weekly)   |
| **share**   | Pushes to external channels | PR merge event  |

An agent is **anything** that can:
1. Read files from the repo
2. Propose changes via PR
3. Comment on Issues

This means agents can be: a Python script, a Hermes skill, a GitHub Action, a Claude Code session, your own hand.

---

## 4. The Scheduler: Cron + Events

Two scheduling mechanisms:

| Mechanism      | For                          | Latency     |
|----------------|------------------------------|-------------|
| Cron           | Periodic tasks (scout, lint) | Hours       |
| Webhook/Event  | Reactive tasks (curate on merge) | Seconds |

Events are Git events:
- `push` → someone proposed knowledge
- `pull_request.opened` → agent wants to change maps/
- `issue_comment.created` → human responded to agent
- `pull_request.merged` → knowledge accepted

---

## 5. The Review Surface: Issue + PR

All agent-human dialogue happens in Issues and PRs. Not in chat. Not in a separate UI.

Rationale:
- Issues are permanent, linkable, searchable
- PR review is a well-understood collaboration pattern
- Diff = what the agent is proposing, exactly
- Merge = the moment knowledge becomes accepted

---

## 6. The Human Role

You are the kernel's **capability system**. Nothing enters `maps/` without your merge.

Your specific responsibilities:
- **Review** agent PRs (accept, reject, request changes)
- **Calibrate** scout taste (close issues with feedback)
- **Highlight** items in the reader (trigger curator)
- **Resolve** conflicts (when two agents disagree)

Everything else is automation.

---

## 7. What GOSK Does Not Define

- The structure of `items/` — domain-specific, declared in `GOSK.md`
- The structure of `maps/` — domain-specific
- Agent implementation — any program that can open Issues and PRs
- Web reader — optional, separate component
- Sharing — optional, separate component
