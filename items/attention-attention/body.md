---
source_url: https://lilianweng.github.io/posts/2018-06-24-attention/
ingested: 2026-05-12
---

# Attention? Attention!

**Author:** Lilian Weng | **Date:** June 24, 2018 (Updated through 2020) | **Source:** [lilianweng.github.io](https://lilianweng.github.io/posts/2018-06-24-attention/)

## Motivation & Intuition

Attention in deep learning is motivated by human visual attention: focusing on a region with high resolution while perceiving surroundings in low resolution. Similarly, words in a sentence correlate with nearby context.

> "Attention in deep learning can be broadly interpreted as a vector of importance weights: in order to predict or infer one element, we estimate using the attention vector how strongly it is correlated with other elements and take the sum of their values weighted by the attention vector as the approximation of the target."

## What's Wrong with Seq2Seq?

- **Classic seq2seq** uses an encoder-decoder with RNNs (LSTM/GRU). The encoder compresses the whole input into a **fixed-length context vector**.
- **Key problem:** The fixed-length vector forgets long sequences, especially the first part. Attention was born to fix this by creating shortcuts between the context vector and the entire source input, with learnable weights for each output element.

## Born for Translation (Bahdanau et al., 2015)

### Definition

Given source sequence x = [x_1,...,x_n] and target y = [y_1,...,y_m]:

- **Encoder:** bidirectional RNN → hidden states
- **Decoder:** hidden state s_t = f(s_{t-1}, y_{t-1}, c_t)
- **Context vector:** c_t = sum of alpha_{t,i} * h_i over all i
- **Alignment weights:** softmax over score(s_{t-1}, h_i)
- **Additive attention score:** score(s_t, h_i) = v_a^T tanh(W_a[s_t; h_i])

> The alignment matrix explicitly shows correlation between source and target words.

## A Family of Attention Mechanisms

### Alignment Score Functions

| Name | Score Function | Citation |
|------|----------------|----------|
| Content-base | cos[s_t, h_i] | Graves 2014 |
| Additive (concat) | v_a^T tanh(W_a[s_{t-1}; h_i]) | Bahdanau 2015 |
| Location-Base | softmax(W_a s_t) | Luong 2015 |
| General | s_t^T W_a h_i | Luong 2015 |
| Dot-Product | s_t^T h_i | Luong 2015 |
| Scaled Dot-Product | s_t^T h_i / sqrt(n) | Vaswani 2017 |

### Broader Categories

| Type | Definition |
|------|------------|
| **Self-Attention** (intra-attention) | Relates different positions of the same input sequence |
| **Global / Soft** | Attends to the entire input state space. Smooth and differentiable. |
| **Local / Hard** | Attends to a subset of input. Hard attention is non-differentiable (requires RL). Local attention uses a window around a predicted position. |

## Neural Turing Machines (NTM)

**Components:**
- **Controller** (feed-forward or RNN) – executes operations on memory.
- **Memory bank** – matrix of size N × M (N rows, M dimensions).

**Read (at time t):**
- Attention vector w_t of size N.
- Read vector: r_t = sum of w_t(i) * M_t(i) over i

**Write:**
- Erase then add, both gated by attention weights.

**Attention Generation (content + location-based):**
1. Content-based addressing via cosine similarity
2. Interpolation with previous attention
3. Convolutional shift for location-based focus
4. Sharpening via exponentiation

## Transformer (Vaswani et al., 2017)

- **No recurrence, no convolution** — pure attention.
- **Multi-head scaled dot-product attention**: multiple attention heads in parallel.
- **Self-attention layers** in both encoder and decoder.
- **Positional encoding** to inject sequence order information.

## Key Takeaways

1. Attention solves the seq2seq bottleneck of fixed-length context vectors
2. Multiple scoring functions exist (additive, dot-product, scaled dot-product)
3. Self-attention enables intra-sequence relationship modeling
4. Hard vs soft attention is a tradeoff between efficiency and differentiability
5. The Transformer architecture proves attention alone can replace recurrence entirely
