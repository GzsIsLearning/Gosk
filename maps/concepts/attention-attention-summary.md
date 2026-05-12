---
title: Attention? Attention! — Lilian Weng's Survey Synthesis
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [attention, survey, self-attention, bahdanau, luong, transformer, neural-turing-machines, score-functions]
sources:
  - items/attention-attention
  - items/attention-is-all-you-need
  - items/bert-pretraining-of-deep-bidirectional-transformers
  - items/the-illustrated-transformer
  - items/an-image-is-worth-16x16-words-vision-transformer
---

## Overview

This page synthesizes the key insights from Lilian Weng's comprehensive survey "Attention? Attention!" (Weng, 2018), cross-referenced against the primary attention papers and pedagogical resources in GOSK. Weng's post provides the most complete taxonomy of attention mechanisms, their mathematical formulations, and their evolutionary path from early seq2seq models through Neural Turing Machines to the Transformer.

## The Core Taxonomy

Weng organizes attention mechanisms along three axes:

### 1. By Alignment Score Function

| Name | Score Function | Origin | Characteristics |
|------|---------------|--------|-----------------|
| Content-based | cos[s_t, h_i] | Graves 2014 | Simple cosine similarity; no learned parameters |
| Additive (concat) | v_a^T tanh(W_a [s_{t-1}; h_i]) | Bahdanau 2015 | Most expressive; learns a compatibility function; slower to compute |
| Location-based | softmax(W_a s_t) | Luong 2015 | Only uses decoder state; ignores encoder content |
| General | s_t^T W_a h_i | Luong 2015 | Learned bilinear form; balanced expressivity and speed |
| Dot-product | s_t^T h_i | Luong 2015 | Simplest learned version; fast but saturates for large d_k |
| Scaled Dot-product | s_t^T h_i / sqrt(d_k) | Vaswani 2017 | Fixes softmax saturation at large dimensions; used in Transformer |

### 2. By Scope

| Type | Definition | Pros | Cons |
|------|------------|------|------|
| **Global / Soft** | Attends to entire input state space | Smooth, differentiable, captures full context | O(n²) compute; expensive for long sequences |
| **Local** (predictive) | Window around predicted position | Linear in window size; differentiable | Assumes locality; misses long-range dependencies outside window |
| **Local** (monotonic) | Sliding window aligned to source/target | Good for alignment tasks (speech, translation) | Restricted to monotonic alignment |
| **Hard** | Attends to a single position; stochastically sampled | O(n) compute | Non-differentiable (requires REINFORCE); high variance gradients |

### 3. By Structure

| Structure | Description | Key Application |
|-----------|-------------|-----------------|
| **Self-attention (intra-attention)** | Relates different positions of the same sequence | Transformer encoder, BERT |
| **Encoder-decoder attention** | Cross-attention between two sequences | Transformer decoder, NMT |
| **Multi-head attention** | Multiple parallel attention heads; each learns different subspaces | Transformer, ViT |
| **Masked self-attention** | Prevents attending to future positions | Autoregressive decoders (GPT) |

## Key Insights from Weng's Survey

### The Seq2Seq Bottleneck
The classic encoder-decoder compresses the entire input into a **fixed-length context vector**. This is the fundamental problem attention was born to solve: the fixed vector forgets long sequences, especially the first part. Attention creates a **shortcut** between the decoder and every encoder hidden state, with learnable alignment weights.

### Attention as a Memory Mechanism
Beyond seq2seq, attention is fundamentally a content-addressable memory system. Weng traces this through Neural Turing Machines (Graves et al., 2014; 2016), where read/write operations on an external memory matrix are controlled by attention weights:

1. **Content-based addressing** via cosine similarity
2. **Location-based addressing** via interpolation + convolution shift + sharpening

This framing anticipates the Transformer's Key-Value-Query abstraction: the memory (values) is addressed by content (keys) through a query.

### The Evolution to Pure Attention
Weng traces the trajectory:
- **2014 (Bahdanau/Neural Machine Translation):** Attention as additive alignment for seq2seq. Still used RNN encoder + decoder.
- **2015 (Luong/Effective Approaches):** Categorizes global vs. local attention; introduces dot-product and general score functions.
- **2015 (Neural Turing Machines):** Attention as external memory read/write mechanism.
- **2017 (Vaswani/Transformer):** Scaled dot-product attention + multi-head + self-attention. Completely eliminates recurrence.

The key insight: each step removed recurrence gradually, until the Transformer proved attention alone is sufficient.

## How Related GOSK Items Expand on Weng's Survey

- **[[items/attention-is-all-you-need]]** — provides the concrete architecture (multi-head self-attention, positional encoding, encoder-decoder stack) that Weng summarizes.
- **[[items/the-illustrated-transformer]]** — visual, step-by-step walkthrough of the Q/K/V computation that Weng describes mathematically. The "Thinking" example in Alammar's post (Zab et al.) makes Weng's abstract taxonomy concrete.
- **[[items/bert-pretraining-of-deep-bidirectional-transformers]]** — demonstrates Weng's "self-attention" category in practice, with bidirectional masking as a novel variant not covered in the 2018 survey.
- **[[items/an-image-is-worth-16x16-words-vision-transformer]]** — extends self-attention from NLP to vision by treating image patches as tokens, something Weng's NLP-centric 2018 survey did not anticipate.

## Cross-References

- [[maps/concepts/attention-mechanisms]] — broader treatment of attention mechanisms across all GOSK items
- [[maps/concepts/residual-connections]] — the architectural enabler of deep attention networks
- [[maps/lineage/transformer-evolution]] — the evolution of attention architectures from NMT to general-purpose AI
- [[maps/concepts/self-supervised-learning]] — how attention enables the pretraining objectives (MLM, autoregressive, contrastive) used by modern SSL models
