---
source_url: https://arxiv.org/abs/1810.04805
ingested: 2026-05-12
---

# BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding

**Authors:** Jacob Devlin, Ming-Wei Chang, Kenton Lee, Kristina Toutanova (Google AI Language)
**Paper:** arXiv:1810.04805

---

## Abstract

BERT is designed to pre-train deep bidirectional representations from unlabeled text by jointly conditioning on both left and right context in all layers.

Unlike previous models (ELMo, OpenAI GPT), BERT uses a masked language model (MLM) to enable bidirectional pre-training. It achieves state-of-the-art results on 11 NLP tasks:

- GLUE score: **80.5%** (7.7% absolute improvement)
- MultiNLI accuracy: **86.7%** (4.6% absolute)
- SQuAD 1.1 Test F1: **93.2** (1.5 absolute)
- SQuAD 2.0 Test F1: **83.1** (5.1 absolute)

---

## Key Contributions

1. Bidirectional pre-training via masked language model (MLM), not unidirectional.
2. Fine-tuning approach with minimal task-specific architecture changes.
3. State-of-the-art on 11 tasks, outperforming heavily engineered systems.

---

## Model Architecture

- Multi-layer bidirectional Transformer encoder (Vaswani et al., 2017).
- Two model sizes:
  - **BERT_BASE** (L=12, H=768, A=12, 110M parameters)
  - **BERT_LARGE** (L=24, H=1024, A=16, 340M parameters)
- Uses WordPiece embeddings with 30,000 token vocabulary.
- Input representation: token embeddings + segment embeddings + position embeddings.
- Special tokens: [CLS] (classification), [SEP] (separator between sentences).

---

## Pre-training Tasks

### Task #1: Masked LM (MLM)
- Randomly mask 15% of tokens per sequence.
- For each masked token: 80% replaced with [MASK], 10% replaced with random token, 10% kept unchanged.
- Objective: predict original token from context (cross-entropy loss over vocabulary).

### Task #2: Next Sentence Prediction (NSP)
- Binary classification: is sentence B the actual next sentence after A?
- 50% positive (IsNext), 50% negative (NotNext, random sentence).
- Critical for QA and NLI tasks.

### Pre-training Data
- BooksCorpus (800M words) + English Wikipedia (2,500M words).
- 4 days on 16 Cloud TPUs (BERT_LARGE).

---

## Fine-tuning Procedure

- Add a task-specific output layer on top of BERT.
- All parameters are fine-tuned end-to-end.
- Hyperparameters: batch size 16/32, learning rate (2e-5 to 5e-5), epochs 2-4.
- Fine-tuning is fast (≤1 hour on Cloud TPU).

---

## Experimental Results

### GLUE Benchmark

| System | Average |
|--------|---------|
| Pre-OpenAI SOTA | 74.0 |
| OpenAI GPT | 75.1 |
| **BERT_BASE** | **79.6** |
| **BERT_LARGE** | **82.1** |

### SQuAD 1.1

| System | Test F1 |
|--------|---------|
| Human | 91.2 |
| **BERT_LARGE (Single)** | **90.9** |
| **BERT_LARGE (Ensemble)** | **93.2** |

### SQuAD 2.0

| System | Test F1 |
|--------|---------|
| Human | 89.5 |
| **BERT_LARGE (Single)** | **83.1** |

---

## Significance

BERT revolutionized NLP by introducing deep bidirectional pre-training via MLM, achieving unprecedented results across 11 benchmarks. It became the foundation for an entire ecosystem of pre-trained language models (RoBERTa, ALBERT, DistilBERT, etc.) and established the "pre-train then fine-tune" paradigm.
