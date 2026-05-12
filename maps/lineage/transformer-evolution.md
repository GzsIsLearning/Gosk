---
title: Transformer Evolution
created: 2026-05-12
updated: 2026-05-12
type: lineage
tags: [transformer, attention, llm, vision-transformer, scaling, pretraining]
sources:
  - items/attention-is-all-you-need
  - items/bert-pretraining-of-deep-bidirectional-transformers
  - items/language-models-are-few-shot-learners
  - items/an-image-is-worth-16x16-words-vision-transformer
  - items/clip-transferable-visual-models
  - items/scaling-laws-for-neural-language-models
  - items/llama-open-and-efficient-foundation-language-models
  - items/gpt-4-technical-report
  - items/the-illustrated-transformer
  - items/attention-attention
---

## Overview

The Transformer architecture, introduced in 2017, replaced recurrence with pure attention and became the dominant paradigm across NLP, vision, and multimodal learning. This lineage tracks the pivotal works that scaled it from a machine translation model to the foundation of today's largest AI systems.

## Evolution Timeline

```
2017 ──► Transformer (Vaswani et al.) ── "Attention Is All You Need"
 │           Self-attention + positional encoding replace RNNs
 │
2018 ──► BERT (Devlin et al.) ── Bidirectional pretraining
 │           Masked language modeling; NLP enters fine-tuning era
 │         The Illustrated Transformer (Alammar) ─ visual pedagogy
 │         Attention? Attention! (Weng) ─ survey of mechanisms
 │
2019 ──► GPT-2 ── Scaling begins in earnest (not in this map, but context)
 │
2020 ──► GPT-3 (Brown et al.) ── 175B params; in-context few-shot learning
 │         Scaling Laws (Kaplan et al.) ─ compute-optimal training
 │
2021 ──► ViT (Dosovitskiy et al.) ─ "An Image is Worth 16x16 Words"
 │           Transformers conquer computer vision
 │         CLIP (Radford et al.) ─ vision-language joint embedding
 │
2022 ──► Chinchilla (not in map) ─ revised scaling laws
 │
2023 ──► LLaMA (Touvron et al.) ─ open, efficient foundation models
 │         GPT-4 (OpenAI) ─ multimodal, human-level exam performance
 │
2024+──► Frontier models (GPT-4o, Claude 3, Gemini) ─ beyond text
```

## Key Works

| Paper/Post | Year | Authors | Core Innovation | Impact |
|------------|------|---------|-----------------|--------|
| Attention Is All You Need | 2017 | Vaswani et al. | Self-attention, multi-head attention, positional encoding. Eliminated recurrence entirely. | Foundation of modern AI; enabled parallel training at scale |
| BERT: Pretraining of Deep Bidirectional Transformers | 2018 | Devlin et al. | Masked language modeling for bidirectional context. Next-sentence prediction pretraining. | Sparked the "BERTology" era; fine-tuning paradigm for NLP |
| The Illustrated Transformer | 2018 | Jay Alammar | Visual walkthrough of attention, Q/K/V, multi-head mechanics | Made the Transformer accessible; cited in countless tutorials |
| Attention? Attention! | 2018 | Lilian Weng | Comprehensive survey of attention variants (additive, dot-product, self-, global/local) | Key reference for understanding the attention design space |
| Language Models are Few-Shot Learners (GPT-3) | 2020 | Brown et al. | 175B parameter autoregressive LM; in-context learning without fine-tuning | Proved scaling unlocks emergent abilities; launched the prompt engineering era |
| Scaling Laws for Neural Language Models | 2020 | Kaplan et al. | Power-law relationships between compute, model size, data, and loss | Guided resource allocation for all subsequent LLM training runs |
| An Image is Worth 16x16 Words (ViT) | 2021 | Dosovitskiy et al. | Patch embedding + Transformer encoder for image classification | Proved CNNs are not required; Transformers are domain-universal |
| CLIP: Learning Transferable Visual Models | 2021 | Radford et al. | Contrastive vision-language pretraining on 400M image-text pairs | Enabled zero-shot classification; backbone for DALL-E, Stable Diffusion |
| LLaMA: Open and Efficient Foundation Language Models | 2023 | Touvron et al. | Training only on public data; smaller models with longer training outperform larger ones | Democratized LLM research; spawned Llama 2, 3, and the open-weight ecosystem |
| GPT-4 Technical Report | 2023 | OpenAI | Multimodal (text+image input); ~90th percentile on bar exam; RLHF refinement | Raised the ceiling on LLM capabilities; set benchmark for safety evaluations |

## Cross-References

- [[maps/concepts/attention]] — core mechanism powering the Transformer
- [[maps/concepts/scaling]] — why bigger models work better (and when they don't)
- [[maps/concepts/residual]] — residual connections enable deep Transformers
- [[maps/lineage/learning-paradigms]] — The Bitter Lesson: why scaling won over clever architectures
- [[maps/lineage/generative-models-evolution]] — how generative modeling evolved alongside Transformers
- [[maps/problems/long-context]] — quadratic attention complexity problem
- [[maps/problems/multimodal-fusion]] — combining vision and language modalities
