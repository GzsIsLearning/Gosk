---
name: gosk-scout
description: "GOSK Scout — 发现、评分、筛选知识候选，摄入 items/。读取 GOSK.md 了解实例规则，从配置的源拉取内容，按品味评分，开 Issue 等待人类审批，批准后写入 items/<slug>/。"
version: 0.1.0
author: GOSK
metadata:
  hermes:
    tags: [gosk, scout, knowledge, ingestion]
    category: gosk
---

# GOSK Scout

GOSK 的知识发现引擎。像侦察兵一样持续扫描信息世界，发现值得入库的内容。

## 触发条件

- 用户说 `gosk scout` 或 `scout`
- 每日 cron 定时触发
- 用户指定源: `gosk scout --source arxiv`

## 工作流

### 1. 读取宪法

```
read_file <repo>/GOSK.md
```
提取：domain、sources、taste rules、tag taxonomy、content types。

### 2. 拉取候选

按 GOSK.md 的 Scout Configuration 访问各源：

**arXiv:**
```
web_search "site:arxiv.org <keywords from domain> 2026"
```
对每篇: 读摘要 → 初筛 → 候选列表。

**技术博客:**
```
web_search "site:karpathy.github.io OR site:lilianweng.github.io OR site:distill.pub <topic>"
```

**技术报告:**
```
web_search "<company> technical report <topic> 2025 2026"
```

**Hacker News:**
```
web_search "site:news.ycombinator.com AI ML <topic>"
```

### 3. 评分

对每个候选按 GOSK.md 的 Taste Rules 评分：

```python
score = 0

# 硬过滤
if not in_domain(candidate, GOSK["domain"]):
    return "REJECT"

# 来源权威性 (+0-3)
if source in ["Nature", "Science", "NeurIPS", "ICML", "ICLR", "CVPR"]:
    score += 2
elif source in ["arXiv", "distill.pub"]:
    score += 1

# 作者权威性 (+0-2)
if author_in_whitelist(candidate["authors"]):
    score += 2

# 开源 (+1)
if candidate.get("open_source"):
    score += 1

# 引用数 (+0-2)
if citations > 1000: score += 2
elif citations > 100: score += 1

# 最终判断
if score >= 4: decision = "HIGH"
elif score >= 2: decision = "MEDIUM"
else: decision = "LOW"
```

### 4. 开 Issue 或直接摄入

- **HIGH (score ≥ 4):** 直接创建 `items/<slug>/`，发通知给人类（"已自动摄入，可撤销"）
- **MEDIUM (score ≥ 2):** 开 Issue，附上摘要和评分理由，等待人类 approve/reject
- **LOW (score < 2):** 丢弃，记录到 log.md（"已过滤: <title> — 原因: ..."），人类可回溯

### 5. 摄入

对每个 approved 候选：

**提取内容:**
```
web_extract <source_url>  → body.md
```

如果是 PDF：使用 MinerU API 或 pdftotext 提取。

**创建 item 目录:**
```
items/<slug>/
├── body.md       ← 提取的全文（不可变）
└── meta.yaml     ← 元数据
```

**meta.yaml 格式:**
```yaml
title: "...""
authors: ["..."]
year: 2024
type: paper | blog | report | article | book-chapter
source_url: "https://..."
tags: [domain, method, task]
score: 4
ingested: 2026-05-12
```

**更新索引:**
在 `index.md` 的 Items 段追加新条目。

**更新日志:**
```
## [2026-05-12] scout | ingested | <title> (score=N, type=<type>)
```

---

## 品味校准

每次人类 approve 或 reject 一个 Issue 后：

1. 记录决策到 `scout_calibration.json`:
```json
{
  "title": "...",
  "decision": "accepted | rejected",
  "reason": "...",
  "date": "2026-05-12"
}
```

2. 每月分析校准记录:
   - 被拒绝的高分论文有什么共同特征？→ 降权
   - 被接受的低分论文有什么共同特征？→ 升权

---

## 并发与节流

- 多源可并行拉取
- arXiv 单次最多 50 篇，按 relevance 排序取 top 20 来评分
- web_extract 串行（避免速率限制），每次间隔 2 秒
- 单次 run 最多摄入 15 个 item（避免人类审核负担过重）

---

## 注意事项

- body.md 摄入后**绝不修改**。补充内容写到 `items/<slug>/notes.md`
- slug 用小写+连字符，从标题生成，限制 80 字符
- 重复检测：摄入前检查 items/ 中是否已有同标题或同 source_url 的 item
- 如果 GOSK.md 不存在：拒绝运行，提示用户先 `gosk init`
