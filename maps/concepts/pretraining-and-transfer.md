---
title: Pretraining and Transfer
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [pretraining, transfer-learning, fine-tuning, zero-shot, few-shot, self-supervised, contrastive, in-context-learning]
sources: [items/bert-pretraining-of-deep-bidirectional-transformers, items/clip-transferable-visual-models, items/an-image-is-worth-16x16-words-vision-transformer, items/language-models-are-few-shot-learners]
---

## Definition

Pretraining and transfer is the two-stage paradigm where a model first learns general-purpose representations from large-scale, often unlabeled or weakly labeled data (pretraining), and then adapts to specific downstream tasks with minimal additional training or no training at all (transfer). The pretraining objective captures universal patterns — semantic relationships, visual features, linguistic structure — while transfer leverages these representations for specialized tasks through fine-tuning, linear probing, zero-shot prediction, or in-context learning. This paradigm decouples the expensive "learning to understand" phase from the cheap "learning to solve a task" phase.

## Why It Matters

Pretraining and transfer has become the dominant paradigm in machine learning, replacing task-specific training from scratch. It enables: (1) leveraging massive unlabeled data that would be impossible to label for each task; (2) dramatically reduced compute for downstream tasks (hours instead of weeks); (3) strong performance with limited labeled data (few-shot, even zero-shot); (4) emergence of generalist capabilities — a single pretrained model (GPT-3, ViT, CLIP) can perform dozens of tasks without modification. The shift from "train for each task" to "pretrain once, transfer everywhere" has been arguably the most impactful architectural change in modern AI.

## Where It Appears

| Paper | Year | How It's Used | Key Insight |
|-------|------|---------------|-------------|
| BERT: Pre-training of Deep Bidirectional Transformers | 2018 | Masked Language Modeling (MLM) + Next Sentence Prediction (NSP) on BooksCorpus + Wikipedia. Fine-tune on 11 NLP tasks with minimal task-specific heads. | Bidirectional pretraining via MLM enables deep representations that see both left and right context — vastly outperforms left-to-right GPT on understanding tasks |
| An Image is Worth 16x16 Words (ViT) | 2020 | Pretrain on JFT-300M (300M images) or ImageNet-21k, then fine-tune on ImageNet, CIFAR-100, VTAB. Patch embeddings + position embeddings + Transformer encoder. | "Large scale training trumps inductive bias" — with enough pretraining data, a Transformer without any CNN priors matches or beats CNNs |
| CLIP: Learning Transferable Visual Models | 2021 | Contrastive pretraining on 400M (image, text) pairs from the internet. Zero-shot transfer: predict class by computing cosine similarity between image embedding and text embeddings of "a photo of a {class}". | Natural language supervision at scale produces visual representations that enable zero-shot classification — flexible prompt-based transfer without any labeled images |
| Language Models are Few-Shot Learners (GPT-3) | 2020 | Autoregressive language model pretraining on filtered Common Crawl + WebText2 + books + Wikipedia (570GB). No fine-tuning. Transfer via in-context learning: provide task description + a few examples as part of the prompt. | "In-context learning" emerges at scale — the model adapts to new tasks simply by conditioning on a few demonstrations in its context window, with zero gradient updates |

## Variants and Evolution

**Pretraining Objectives (by supervision signal):**

| Paradigm | Example | Signal | When to Use |
|----------|---------|--------|-------------|
| Masked Language Modeling (MLM) | BERT | Reconstruct masked tokens from bidirectional context | Understanding tasks (QA, NLI, NER) |
| Autoregressive (Causal) LM | GPT-3 | Predict next token given previous tokens | Generation tasks, general-purpose few-shot |
| Contrastive (InfoNCE) | CLIP | Maximize similarity of matched (image, text) pairs vs. non-matched | Cross-modal, zero-shot classification |
| Masked Image Modeling | MAE, BEiT | Reconstruct masked image patches | Vision tasks with limited labeled data |
| Next Sentence Prediction (NSP) | BERT | Binary: is sentence B the next sentence after A? | Sentence-pair tasks (QA, NLI) |
| Patch Classification | ViT | Classify image from patch tokens (standard supervised) | Large-scale supervised vision pretraining |

**Transfer Methods (by adaptation cost):**

| Method | Weight Update? | Labeled Data Needed | Latency | Example |
|--------|---------------|---------------------|---------|---------|
| Fine-tuning | Yes, full model | Per-task (100s-1000s examples) | 1-4 hours | BERT on GLUE, ViT on ImageNet |
| Linear probing | Only final layer | Per-task (100s examples) | Minutes | CLIP features + logistic regression |
| Zero-shot | None | None | Immediate | CLIP: "a photo of a {class}" |
| Few-shot / In-context learning | None | None (prompt engineering) | Immediate | GPT-3: k demonstrations in prompt |
| Parameter-efficient (LoRA, adapters) | Yes, small added params | Per-task | Minutes | LoRA on LLaMA for instruction following |
| Prompt tuning | Yes, soft prompt tokens | Per-task | Minutes | Prefix tuning, P-tuning |

**Scale Dynamics:**
- **BERT scale:** 110M (Base) to 340M (Large) — pretraining on 3.3B words, 4 days on 16 TPUs. Fine-tuning takes ≤1 hour.
- **ViT scale:** 86M (Base) to 632M (Huge) — pretraining data matters more than architecture. ImageNet-only pretraining underperforms CNNs; JFT-300M unlocks Transformer potential.
- **GPT-3 scale:** 125M to 175B parameters — in-context learning abilities improve smoothly with model size. The 175B model is 10x larger than any prior non-sparse LM.
- **CLIP scale:** Zero-shot error decreases log-log linearly with compute across 44x compute range. Larger models are more robust to distribution shift.

**Key Design Decisions:**
- **Pretraining data quantity vs. quality:** GPT-3 uses filtered Common Crawl but oversamples high-quality sources (Wikipedia 3.4 epochs vs. Common Crawl 0.44 epochs). ViT shows that JFT-300M quality + quantity matters more than architecture.
- **Bidirectional vs. autoregressive:** MLM (bidirectional) excels at understanding; causal LM (autoregressive) enables generation and in-context learning. Encoder-decoder (T5) combines both.
- **Task specification:** BERT requires a task-specific head; GPT-3 uses natural language prompts; CLIP uses text descriptions of classes. The trend is toward more flexible, language-driven task specification.

## Cross-References

- [[maps/lineage/pretraining-revolution]] — how pretraining paradigms evolved from word2vec through BERT to GPT-3 and CLIP
- [[maps/lineage/from-cnn-to-vit]] — the role of scale in enabling Transformer-based vision pretraining
- [[maps/problems/pretraining-data-quality]] — data contamination, memorization, and filtering in web-scale pretraining corpora
- [[maps/problems/emergence-and-scale]] — what capabilities emerge at what scale, and why in-context learning appears in large models
- [[maps/concepts/attention-mechanisms]] — the architectural backbone (Transformer, self-attention) that enables modern pretraining
- [[maps/concepts/generative-modeling]] — autoregressive and diffusion-based generative pretraining objectives
