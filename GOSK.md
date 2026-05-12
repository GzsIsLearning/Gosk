# GOSK.md — Seed Instance Constitution

> 这是 GOSK 的种子知识库。目标是收录 AI/ML 领域的经典文献——论文、博客、技术报告、文章——作为 GOSK 的第一个运行实例和概念验证。

---

## Domain

人工智能与机器学习（AI/ML）。不限子领域——从深度学习基础到前沿应用，从理论到工程。

---

## Conventions

- **文件命名:** 小写 + 连字符，唯一。从标题自动生成 slug。
- **Frontmatter:** YAML，每篇 `items/<slug>/meta.yaml` 必须包含 `title`, `authors`, `year`, `type`, `source_url`, `tags`, `ingested`。
- **Immutable 原则:** `items/<slug>/body.md` 摄入后不可修改。补充内容写入 `items/<slug>/notes.md`。
- **Wikilinks:** `maps/` 页面间至少 2 个 `[[交叉引用]]`。
- **更新:** 每次编辑 bump `updated` 日期。
- **矛盾:** 标注 `contested: true`，永不静默覆盖。

---

## Content Types

| Type | 含义 | body.md 来源 |
|------|------|-------------|
| `paper` | 学术论文 | arXiv / PDF extract |
| `blog` | 技术博客 | web_extract |
| `report` | 技术报告 / 白皮书 | web_extract |
| `article` | 长文 / 论文解读 | web_extract |
| `book-chapter` | 书籍章节 | web_extract |

---

## Map Layers

```
maps/
├── lineage/        ← 方法演化（CNN→Transformer→FM, SSL演变, etc.）
├── problems/       ← 未解决问题（scaling, alignment, efficiency, etc.）
├── experience/     ← 来自实践的教训
└── concepts/       ← 核心概念（attention, residual, normalization, etc.）
```

---

## Tag Taxonomy

**方法:** `transformer`, `cnn`, `rnn`, `mamba`, `diffusion`, `contrastive`, `self-supervised`, `reinforcement-learning`, `gan`, `vae`, `moe`, `mamba`

**领域:** `cv`, `nlp`, `multimodal`, `speech`, `rl`, `graph`, `robotics`, `vision-language`

**任务:** `classification`, `segmentation`, `detection`, `generation`, `translation`, `pretraining`, `finetuning`

**属性:** `benchmark`, `survey`, `theory`, `efficiency`, `scaling`, `alignment`, `interpretability`

**来源:** `paper`, `blog`, `report`, `article`, `book-chapter`

---

## Scout Configuration

### Sources

| Source | Frequency | Notes |
|--------|-----------|-------|
| arXiv (cs.AI, cs.LG, cs.CV, cs.CL, stat.ML) | Daily | Top 50 by relevance |
| Selected blogs (karpathy, lil-log, distill.pub, etc.) | Weekly | New posts |
| Semantic Scholar | Weekly | High-citation recent papers |
| Hacker News | Daily | AI/ML stories with >100 points |

### Taste Rules

- **硬过滤:** 非 AI/ML 领域直接丢弃
- **高优先级:** 来自已知顶级作者/机构的论文，开源代码的论文，有公开数据集的论文
- **中优先级:** 新的 benchmark 或数据集，有趣的博客解读
- **低优先级:** 纯应用论文（除非方法特别新颖），已知的重复工作
- **品味校准:** scout 每次推荐后，根据人类的 accept/reject 反馈调整权重

---

## Agent Rules

- Scout 发现候选 → 开 Issue，包含标题、来源、类型、初步评分
- 人类在 Issue 里 approve → Curator 摄入到 `items/`，创建 body.md + meta.yaml
- 人类在 Issue 里 reject → 记录拒绝原因，更新 scout 的品味校准
- Curator 对每篇摄入自动提取 tags，尝试归类到 `maps/lineage/`
- Lint 每周检查：孤立文件、断链、过期内容（> 90 天未更新）
