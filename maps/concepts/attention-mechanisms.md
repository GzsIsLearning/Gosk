---
title: Attention Mechanisms
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [attention, transformer, self-attention, multi-head, survey, nlp, cv]
sources: [items/attention-is-all-you-need, items/bert-pretraining-of-deep-bidirectional-transformers, items/an-image-is-worth-16x16-words-vision-transformer, items/the-illustrated-transformer, items/attention-attention]
---

## Definition

Attention mechanisms are neural network components that dynamically weight the importance of different elements in an input sequence when computing outputs. Instead of compressing the entire input into a fixed-length vector (as classic seq2seq encoder-decoders do), attention creates a shortcut between the output and the entire source input, learning alignment weights that determine how strongly each output element correlates with each input element. In its modern form — scaled dot-product attention — the mechanism computes Query (Q), Key (K), and Value (V) matrices, then produces output as: Attention(Q,K,V) = softmax(QK^T / sqrt(d_k)) V. Multi-head attention runs this in parallel across multiple representation subspaces, concatenating results.

## Why It Matters

Attention is the architectural innovation that replaced recurrence and convolution in sequence modeling, enabling massive parallelization during training. The Transformer — built entirely on attention — became the foundation for virtually all modern large language models (GPT, BERT, T5, LLaMA), revolutionized NLP, and has since been adapted to computer vision, speech, multimodal learning, and reinforcement learning. Attention's ability to model long-range dependencies without the vanishing-gradient bottleneck of RNNs makes it a fundamental primitive of modern deep learning.

## Where It Appears

| Paper | Year | How It's Used | Key Insight |
|-------|------|---------------|-------------|
| Attention Is All You Need | 2017 | Scaled dot-product self-attention, multi-head (8 heads), encoder-decoder attention | Pure attention can replace recurrence and convolution entirely — superior parallelizability |
| BERT: Pre-training of Deep Bidirectional Transformers | 2018 | Bidirectional self-attention (encoder-only) across left and right context simultaneously | Masked LM enables deep bidirectional pretraining by preventing each token from "seeing itself" |
| An Image is Worth 16x16 Words (ViT) | 2020 | Self-attention on image patches: image split into 16x16 patches, each treated as a token | "Large scale training trumps inductive bias" — pure attention outperforms CNNs given sufficient data |
| The Illustrated Transformer | 2018 | Visual, step-by-step explanation of self-attention and multi-head attention mechanics | Intuitive exposition: Q/K/V matrices, score computation, softmax weighting, residual connections |
| Attention? Attention! | 2018 | Comprehensive survey of attention variants: additive, dot-product, scaled dot-product, self-attention, global, local, hard | Attention is a family — taxonomy of score functions, and the progression from Bahdanau (2015) to Vaswani (2017) |

## Variants and Evolution

**Alignment Score Functions (chronological evolution):**
- **Additive (concat):** Bahdanau et al. 2015 — v_a^T tanh(W_a [s_t; h_i]), learns a compatibility function. More expressive but slower.
- **Dot-product:** Luong et al. 2015 — s_t^T h_i, simpler and faster for large dimensions.
- **Scaled dot-product:** Vaswani et al. 2017 — s_t^T h_i / sqrt(d_k), prevents softmax saturation at large dimensions.
- **General:** Luong et al. 2015 — s_t^T W_a h_i, parameterized compatibility between different spaces.

**Structural Variants:**
- **Self-attention (intra-attention):** Relates different positions within a single sequence. Foundation of the Transformer encoder.
- **Masked self-attention:** Prevents attending to future positions (decoder in autoregressive models).
- **Bidirectional attention:** Attends to both left and right context (BERT's encoder-only architecture).
- **Cross-attention (encoder-decoder):** Queries from decoder, keys/values from encoder output — connects two sequences.
- **Local/hard attention:** Attends to a subset or single input position. Hard attention requires REINFORCE; local attention uses a learnable window.
- **Sparse attention:** Longformer, BigBird — reduces O(n^2) complexity via patterns (sliding window, global tokens, random).
- **Patch-based attention:** ViT's innovation — treat image patches as tokens, applying standard Transformer self-attention without convolutional inductive biases.

## Cross-References

- [[maps/lineage/from-rnn-to-transformer]] — attention as the replacement for recurrence in sequence modeling
- [[maps/lineage/transformer-evolution]] — how attention-based architectures evolved from BERT to ViT to GPT-3
- [[maps/problems/long-range-attention-efficiency]] — open problem of O(n^2) memory/compute scaling
- [[maps/concepts/pretraining-and-transfer]] — self-supervised pretraining objectives that leverage attention architectures
- [[maps/concepts/generative-modeling]] — diffusion models also use attention (U-Net with self-attention at bottleneck layers)
