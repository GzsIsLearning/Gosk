---
source_url: https://jalammar.github.io/illustrated-transformer/
ingested: 2026-05-12
---

# The Illustrated Transformer

**Author:** Jay Alammar | **Source:** [jalammar.github.io](https://jalammar.github.io/illustrated-transformer/)

## Key Insight
The Transformer uses **attention** to boost parallelism (key advantage over RNNs). Proposed in ["Attention is All You Need"](https://arxiv.org/abs/1706.03762). Outperforms Google NMT in specific tasks; recommended for Cloud TPU.

## High-Level Architecture

- **Encoder stack**: 6 identical encoders – each has two sub-layers:
    1. Self-attention layer
    2. Feed-forward neural network (same FF applied independently per position)
- **Decoder stack**: 6 identical decoders – each has three sub-layers:
    1. Masked self-attention
    2. Encoder-decoder attention (queries from below, keys/values from encoder output)
    3. Feed-forward network
- All sub-layers have **residual connections** followed by **layer normalization**.

## Input Representation

- Each word is embedded into a **512-dimensional vector** (embedding only in bottom encoder).
- **Positional encoding** (sine/cosine functions) is added to the embedding to give order awareness:
  ```
  PE(pos, 2i)   = sin(pos / 10000^(2i/d_model))
  PE(pos, 2i+1) = cos(pos / 10000^(2i/d_model))
  ```

## Self-Attention (Single Head)

**Step-by-step (word level):**

1. For each input word, create **Query (Q), Key (K), Value (V)** vectors of dimension 64 by multiplying with trained weight matrices W^Q, W^K, W^V.
2. Compute **score** = dot product of query with key of every word.
3. Divide scores by sqrt(d_k) = 8 (for stable gradients).
4. Apply **softmax** to get normalized attention weights.
5. Multiply each value vector by its softmax score.
6. Sum weighted value vectors → output of self-attention for that position.

**Matrix form:** Attention(Q, K, V) = softmax(QK^T / sqrt(d_k)) V

## Multi-Head Attention

- Uses **8 attention heads** (8 sets of W^Q, W^K, W^V).
- Each head produces a different representation subspace.
- Outputs of all heads are **concatenated** and multiplied by W^O to produce final Z matrix.
- **Benefits:** Model can focus on different positions and provides multiple representation subspaces.

## Encoder Details

- Self-attention (multi-head) → Residual + layer norm → Feed-forward → Residual + layer norm
- Output is a list of vectors (size 512) passed to the next encoder.

## Decoder Details

- Same structure as encoder, with an additional **encoder-decoder attention** layer.
- **Masked self-attention**: future positions set to -inf before softmax.
- **Encoder-decoder attention**: Queries from decoder, Keys/Values from encoder output.

## Final Output Layer

- Decoder stack outputs a float vector.
- **Linear layer** projects to logits vector (size = vocabulary).
- **Softmax** converts logits to probabilities; highest probability = output word.

## Training Overview

- **One-hot encoding** of target vocabulary.
- **Loss**: cross-entropy / KL divergence between predicted and target distributions.
- **Inference**: Greedy decoding or beam search (keep top-k partial hypotheses).

## Important Quotes

> "The Transformer outperforms the Google Neural Machine Translation model in specific tasks. The biggest benefit comes from how The Transformer lends itself to parallelization."

> "Multi-headed attention expands the model's ability to focus on different positions and gives multiple representation subspaces."

> "Each sub-layer in each encoder has a residual connection around it, and is followed by a layer-normalization step."
