# GOSK.md — Instance Constitution

> Every GOSK instance has a `GOSK.md`. It declares the domain, conventions, and agent rules for this specific knowledge repository.
> Agents read this file before any operation. Humans edit it to steer the system.

---

## Domain

[What knowledge lives here? E.g., "Remote sensing AI literature", "Lab experiment log", "Company decision archive"]

## Conventions

- File naming: [lowercase, hyphens, no spaces]
- Frontmatter: YAML required on every item and map page
- Tags: controlled vocabulary — add new tags here before using

## Map Layers

Define how compiled knowledge is organized. Examples:

```
maps/
├── lineage/     ← How things evolve over time
├── problems/    ← What remains unsolved
├── experience/  ← Lessons from doing (not from reading)
└── editorial/   ← Where to publish or share
```

## Tag Taxonomy

[List domain-specific tags here. Agents must only use tags from this list.]

## Agent Rules

- What agents can do autonomously
- What requires human review
- Confidence markers: high / medium / low
- Contradiction policy: never silently overwrite

## Scout Configuration

- Sources to monitor [arxiv categories, RSS feeds, GitHub repos]
- Taste calibration [what to prioritize, what to deprioritize]

---

**This file is version-controlled.** Every change to the constitution is a commit. git log shows how your knowledge system evolved.
