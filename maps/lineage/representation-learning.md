---
title: Representation Learning
created: 2026-05-12
updated: 2026-05-12
type: lineage
tags: [representation-learning, pretraining, self-supervised, nlp, vision, multimodal, bert, clip, vit]
sources:
  - items/bert-pretraining-of-deep-bidirectional-transformers
  - items/clip-transferable-visual-models
  - items/an-image-is-worth-16x16-words-vision-transformer
---

## Overview

Representation learning seeks to encode raw data into structured vector spaces where semantic relationships are preserved, enabling transfer to diverse downstream tasks with minimal labeled data. This lineage tracks the evolution from NLP-focused bidirectional pretraining (BERT) through vision-language joint embedding (CLIP) to pure vision transformers (ViT), showing how the pretrain-then-transfer paradigm conquered multiple modalities.

## Evolution Timeline

```
2018 ──► BERT (Devlin et al.) ── Bidirectional NLP Pretraining
 │           Masked Language Model + Next Sentence Prediction
 │           Encoder-only Transformer; 110M-340M parameters
 │           SOTA on 11 NLP tasks; established "pretrain + fine-tune"
 │
2019 ──► RoBERTa, XLNet, ALBERT ── BERT variants improve pretraining
 │         GPT-2 ── autoregressive pretraining at scale
 │
2020 ──► GPT-3 (Brown et al.) ── 175B autoregressive LM
 │           In-context learning emerges at scale
 │           Transfer without any weight updates
 │
2021 ──► CLIP (Radford et al.) ── Vision-Language Joint Embedding
 │           Contrastive learning on 400M (image, text) pairs
 │           Zero-shot ImageNet at ResNet-50 accuracy
 │           Dual-encoder architecture (image encoder + text encoder)
 │
 │       ViT (Dosovitskiy et al.) ── Pure Transformer for Vision
 │           Image patches → Transformer encoder
 │           "Large scale training trumps inductive bias"
 │           Matches CNNs with 2.5-5× less compute (with enough data)
 │
2022 ──► MAE (masked autoencoder) ── self-supervised vision pretraining
 │         Stable Diffusion ── CLIP text encoder as conditioner
 │
2023 ──► GPT-4 ── multimodal (text + image) representation fusion
 │         LLaMA ── efficient open-source representation learning
```

## Key Works

| Paper | Year | Authors | Domain | Core Innovation | Impact |
|-------|------|---------|--------|-----------------|--------|
| BERT: Pre-training of Deep Bidirectional Transformers | 2018 | Devlin et al. | NLP | Masked Language Modeling (MLM) enables deep bidirectional pretraining. Fine-tune on 11 tasks with minimal task-specific heads. | Sparked the "BERTology" revolution; pretrain-then-fine-tune became the default NLP paradigm |
| CLIP: Learning Transferable Visual Models | 2021 | Radford et al. | Vision-Language | Contrastive pretraining on 400M image-text pairs. Zero-shot transfer via natural language prompts. Dual-encoder with symmetric InfoNCE loss. | Enabled flexible zero-shot classification; backbone for text-to-image generation (DALL-E, Stable Diffusion) |
| An Image is Worth 16x16 Words (ViT) | 2020 | Dosovitskiy et al. | Vision | Patch embedding + standard Transformer encoder for images. No convolutional inductive bias. | Unified architecture across vision and language; "large scale training trumps inductive bias" insight |

## Bridging the Modalities

- **BERT → CLIP connection:** Both use Transformer-based encoders. BERT's success in NLP representations inspired the application of Transformers to vision (ViT) and the use of text as a supervision signal for vision (CLIP).
- **CLIP → ViT connection:** CLIP uses both ResNet and ViT as image encoders, showing ViT scales better (ViT-L/14 trained 12 days vs ResNet RN50x64 at 18 days). ViT's patch embedding approach is a natural fit for CLIP's token-based matching.
- **ViT's data requirement:** Pure Transformer vision models need massive pretraining data (JFT-300M) to overcome lack of inductive bias. This mirrors the NLP pattern where BERT and GPT-3 need web-scale corpora.

## Cross-References

- [[maps/concepts/self-supervised-learning]] — the pretraining objectives (MLM, contrastive, autoregressive) that drive representation learning
- [[maps/concepts/pretraining-and-transfer]] — the broader paradigm of pretrain then transfer across modalities
- [[maps/lineage/transformer-evolution]] — the Transformer architecture underlying all three approaches
- [[maps/problems/representation-learning]] — open challenges in learning universal representations
- [[maps/problems/model-evaluation]] — how to fairly compare representation quality across approaches
