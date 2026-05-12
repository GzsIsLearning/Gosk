---
title: Self-Supervised Learning
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [self-supervised, pretraining, masked-language-modeling, contrastive, autoregressive, no-labels]
sources:
  - items/bert-pretraining-of-deep-bidirectional-transformers
  - items/clip-transferable-visual-models
  - items/language-models-are-few-shot-learners
  - items/auto-encoding-variational-bayes
  - items/an-image-is-worth-16x16-words-vision-transformer
  - items/gpt-4-technical-report
---

## Definition

Self-supervised learning (SSL) is a training paradigm where a model learns representations from unlabeled data by defining a pretext task — a supervisory signal generated automatically from the data itself. Instead of relying on human-annotated labels, SSL creates input-output pairs by transforming, masking, or contrasting parts of the data. The learned representations can then be transferred to downstream tasks via fine-tuning, linear probing, or zero-shot inference. SSL is the engine behind modern pretrained models: BERT, GPT-3, CLIP, and countless others.

> The core insight: *labels are expensive, but data is abundant. Design the supervision signal from the data structure itself.*

## Why It Matters

Self-supervised learning is the primary reason AI can leverage internet-scale data without human annotators. It has become the dominant pretraining paradigm across NLP, vision, and multimodal learning. Key benefits:

1. **Unlimited supervision:** The model generates its own training signal from raw data — no expensive human labeling.
2. **Scale efficiency:** Larger datasets produce better representations with no annotation bottleneck.
3. **General representations:** SSL objectives encourage learning broad, transferable features rather than narrow task-specific patterns.
4. **Emergent capabilities:** Autoregressive SSL (GPT-3) produces in-context learning — a capability that emerges at scale without being explicitly trained for it.

## Where It Appears

| Paper | Year | Objective | How It Works | Key Insight |
|-------|------|-----------|--------------|-------------|
| Auto-Encoding Variational Bayes (VAE) | 2013 | Reconstruction + KL regularization | Encode x to latent z, decode z back to x. Learn p(x|z) while keeping q(z|x) close to p(z)=N(0,I). | Reparameterization trick makes latent variable models trainable via SGD. Self-supervised through reconstruction. |
| BERT (Devlin et al.) | 2018 | Masked Language Modeling (MLM) + NSP | Mask 15% of tokens; predict them from bidirectional context. NSP: predict if sentence B follows A. | Bidirectional context is a breakthrough — left+right context produces much better NLP representations than unidirectional. |
| GPT-3 (Brown et al.) | 2020 | Autoregressive (causal) LM | Predict next token given all previous tokens. No bidirectional context. | At scale (175B), in-context learning emerges — the model adapts to tasks from examples in the prompt, with zero gradient updates. |
| CLIP (Radford et al.) | 2021 | Contrastive (InfoNCE) | Maximize cosine similarity of matched (image, text) pairs vs. non-matched pairs in a batch. Symmetric loss (image→text + text→image). | Natural language is a flexible supervision signal. Zero-shot classification by matching image embedding to text prompts. Smooth power-law scaling with compute. |
| ViT (Dosovitskiy et al.) | 2020 | Supervised classification (on JFT-300M) | Standard cross-entropy on labeled image dataset. | While ViT itself is supervised, it paved the way for self-supervised vision transformers (MAE, BEiT). Key insight: large-scale data trumps inductive bias. |

## Families of SSL Objectives

### 1. Autoregressive (Generative)
Predict the next element given previous elements. The data itself provides the target: element at position t+1.

**Examples:** GPT-3 (next token prediction), PixelCNN, WaveNet
- **Strengths:** Naturally generative — can sample from the distribution; scales smoothly; produces strong in-context learning
- **Weaknesses:** Unidirectional context only (in the causal variant); slower for understanding tasks

### 2. Masked (Denoising / Reconstruction)
Corrupt a portion of the input and train the model to reconstruct the original. The corruption is the input, the original is the target.

**Examples:** BERT (masked language model), VAE (reconstruction), MAE (masked image modeling), Denoising Autoencoders
- **Strengths:** Bidirectional context; excellent for understanding tasks; simple to implement
- **Weaknesses:** Compute-inefficient (only corrupted tokens contribute to loss); mismatch between pretraining (masked) and fine-tuning (unmasked)

### 3. Contrastive
Learn an embedding space where similar (positive) pairs are pulled together and dissimilar (negative) pairs are pushed apart. The contrast is the supervisory signal.

**Examples:** CLIP (image-text), SimCLR, MoCo (image-image), InfoNCE loss
- **Strengths:** Efficient (uses all pairs in batch as negatives); produces linearly separable representations; flexible modality pairing
- **Weaknesses:** Sensitive to batch size and negative sampling strategy; requires careful data augmentation; doesn't naturally generate samples

### 4. Multi-Task (Combined)
Use multiple SSL objectives simultaneously for richer representations.

**Examples:** T5 (span corruption + prefix LM), ALIGN (contrastive + captioning), GPT-4 (next token prediction + RLHF)
- **Strengths:** Captures different structural properties; more robust representations
- **Weaknesses:** Complex training dynamics; harder to scale; objective balancing is delicate

## Scale Dynamics

- **BERT scale (2018):** MLM trained on 3.3B words, 4 days on 16 TPUs. SSL produces representations that, when fine-tuned on 11 NLP tasks, achieve SOTA across all.
- **GPT-3 scale (2020):** Autoregressive LM on 410B tokens (570GB text). 175B parameters. In-context learning emerges — the model adapts to tasks purely through conditioning, without weight updates.
- **CLIP scale (2021):** Contrastive learning on 400M image-text pairs. Zero-shot error decreases log-log linearly with compute across 44× compute range. Larger models are more robust to distribution shift.
- **GPT-4 scale (2023):** Autoregressive + multimodal. SSL enables predictable scaling of loss from 1/1000th compute. Some capabilities (in-context learning, reasoning) emerge at thresholds not predictable from loss alone.

## Key Design Decisions

- **Bidirectional vs. autoregressive:** BERT's MLM (bidirectional) excels at understanding tasks. GPT-3's causal LM enables generation and in-context learning. The choice depends on the downstream use case.
- **Objective alignment with transfer:** MLM pretraining aligns well with fine-tuning on classification/QA. Autoregressive pretraining aligns with generation and zero-shot inference. Contrastive pretraining aligns with zero-shot retrieval and classification.
- **Data quality vs. quantity:** Filtered web data (Common Crawl) + oversampling of high-quality sources (Wikipedia) is the standard recipe. GPT-3 found that data quality matters — Wikipedia gets 3.4 epochs vs. Common Crawl's 0.44.
- **Evaluation gap:** SSL objectives (loss, accuracy on pretext task) correlate with downstream performance but don't perfectly predict it. GPT-4 shows some tasks where loss improvement does not translate to capability improvement.

## Cross-References

- [[maps/lineage/representation-learning]] — the evolution of SSL objectives across NLP, vision, and multimodal domains
- [[maps/concepts/pretraining-and-transfer]] — the broader paradigm that SSL enables
- [[maps/concepts/scaling-behavior]] — how SSL at scale produces emergent capabilities
- [[maps/lineage/transformer-evolution]] — the Transformer architecture that makes modern SSL computationally feasible
- [[maps/problems/model-evaluation]] — how to compare SSL methods when evaluation is fragmented across tasks and modalities
