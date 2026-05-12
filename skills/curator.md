---
name: gosk-curator
description: "GOSK Curator — 阅读 items/，编织 maps/。跨篇合成知识：方法演化（lineage）、跨领域问题（problems）、核心概念（concepts）、实践经验（experience）。"
version: 0.1.0
author: GOSK
metadata:
  hermes:
    tags: [gosk, curator, maps, compilation]
    category: gosk
---

# GOSK Curator

Scout 收集了原材料。Curator 把它们变成知识。

## 触发条件

- `gosk curator` — 全量编织（扫描所有 items，重建 maps/）
- `gosk curator --stale` — 增量编织（只处理新入库的 items）
- 每次有 items/ 变更后自动触发

## 工作流

### 1. 读取宪法 + 现有 maps/

```
read_file <repo>/GOSK.md     # 了解 map 层定义
ls <repo>/maps/*/             # 已有哪些 map 页面
read_file <repo>/index.md     # 当前完整状态
```

### 2. 扫描 items/

```
ls <repo>/items/*/meta.yaml   # 全部已知 item
```

对每个 item:
- 读取 meta.yaml（title, authors, year, type, tags）
- 读取 body.md 的前 200 行（摘要 + 核心贡献）

### 3. 合成 maps/

按 GOSK.md 定义的 map 层逐层编织：

#### maps/lineage/ 方法演化

创建条件：2 篇以上论文共享同一种方法范式。

**结构：**
```yaml
---
title: Transformer Architecture
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: lineage
tags: [transformer, architecture, attention]
sources:
  - items/attention-is-all-you-need/
  - items/bert-pretraining-of-deep-bidirectional-transformers/
  - items/an-image-is-worth-16x16-words-vision-transformer/
---
## Overview
[简洁描述这条方法谱系]

## Timeline
| Year | Work | Contribution |
|------|------|-------------|
| 2017 | [[items/attention-is-all-you-need]] | Scaled dot-product attention |
| 2019 | [[items/bert-pretraining-of-deep-bidirectional-transformers]] | Bidirectional pre-training |
| 2021 | [[items/an-image-is-worth-16x16-words-vision-transformer]] | Vision Transformer |

## Comparison Table
| Paper | Year | Key Innovation | Influence | Open Source |
|-------|------|---------------|-----------|-------------|
| ...   | ...  | ...           | ...       | ...         |

## Open Issues
[这条谱系仍未解决的问题]
```

#### maps/concepts/ 核心概念

创建条件：在 3+ 篇论文中出现的关键概念。

**结构：**
```yaml
---
title: Attention Mechanism
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: concept
tags: [attention, mechanism]
sources:
  - items/attention-is-all-you-need/
  - items/attention-attention/
  - items/the-illustrated-transformer/
---
## Definition
## Why It Matters
## Across Papers
- In [[items/attention-is-all-you-need]]: scaled dot-product
- In [[items/bert-pretraining-of-deep-bidirectional-transformers]]: bidirectional self-attention
- In [[items/an-image-is-worth-16x16-words-vision-transformer]]: self-attention on image patches
## Key References
```

#### maps/problems/ 跨篇问题

创建条件：在 3+ 篇论文中被提及为限制或开放挑战。

**结构：**
```yaml
---
title: Model Scaling
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: problem
tags: [scaling, efficiency]
sources:
  - items/scaling-laws-for-neural-language-models/
  - items/gpt-4-technical-report/
  - items/language-models-are-few-shot-learners/
---
## Problem Statement
## Why It's Hard
## Evidence Across Papers
## Current Best Attempt
## Remaining Gap
```

#### maps/experience/ 实践教训

创建条件：跨论文发现的工程/实验经验（非论文声称的，是 curator 读后总结的）。

### 4. 更新索引 + 日志

每创建一个 maps/ 页面，更新 index.md 的相应段落。

追加 log.md:

```
## [YYYY-MM-DD] curator | create | maps/lineage/transformer-architecture.md | 4 papers linked
## [YYYY-MM-DD] curator | create | maps/concepts/attention.md | 3 papers linked
```

### 5. commit

```
git add maps/ index.md log.md
git commit -m "curator: <N> maps pages synthesized from <M> items"
```

## 规则

- **不重复创建**：同名 maps 页面存在则不重建，只更新
- **wikilinks 格式**：`[[items/<slug>]]` 指向原文，`[[maps/lineage/<name>]]` 指向其他 map
- **每条推断必须有来源**：maps/ 页面中每个声明必须标注来自哪篇 item
- **置信度标注**：`confidence: high`（明确支持）`medium`（暗示）`low`（推断）
- **矛盾标注**：如果两篇论文对同一问题给出矛盾结论，标注 `contested: true`
