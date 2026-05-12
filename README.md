# GOSK

> **Git can be the OS for knowledge.**
> Your wiki has a kernel now.

---

GOSK is not a note-taking app. It's not a "chat with your PDF" tool.

GOSK is a **knowledge repository runtime**. Git is the kernel. Markdown is the filesystem. Agents are the processes. You are the reviewer.

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

## Architecture (principles)

```
File system  = knowledge (markdown + frontmatter)
Git          = operating system kernel (version, branch, review, blame)
Issues       = agent-human dialogue surface
PRs          = knowledge proposals, require human merge
Agents       = OS processes (scout, reader, curator, reviewer)
Cron         = scheduler (daily scout, weekly lint)
```

---

## Quick Start

```bash
# Create a GOSK instance
gosk init ~/my-knowledge-base

# Start the built-in web reader
gosk serve

# Run a scout agent to discover new content
gosk scout --source arxiv
```

Status: **pre-release. Building in the open.**

---

## License

MIT
