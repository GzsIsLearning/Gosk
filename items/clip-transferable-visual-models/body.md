---
source_url: https://arxiv.org/abs/2103.00020
ingested: 2026-05-12
---

# CLIP: Learning Transferable Visual Models From Natural Language Supervision

**Authors:** Alec Radford*, Jong Wook Kim*, Chris Hallacy, Aditya Ramesh, Gabriel Goh, Sandhini Agarwal, Girish Sastry, Amanda Askell, Pamela Mishkin, Jack Clark, Gretchen Krueger, Ilya Sutskever (*equal contribution)

**Source:** arXiv:2103.00020, Feb 2021
**Code/Models:** https://github.com/OpenAI/CLIP

## Key Facts (Abstract)

> "We demonstrate that the simple pre-training task of predicting which caption goes with which image is an efficient and scalable way to learn SOTA image representations from scratch on a dataset of 400 million (image, text) pairs collected from the internet… For instance, we match the accuracy of the original ResNet-50 on ImageNet zero-shot without needing to use any of the 1.28 million training examples it was trained on."

- **Zero-shot ImageNet:** 76.2% top-1 (matches ResNet-50), 95% top-5 (matches Inception-V4)
- **Training data:** 400M (image, text) pairs – WebImageText (WIT)
- **Robustness:** Shrinks the "robustness gap" on 7 natural distribution shifts by up to 75%
- **Linear probe:** Best model (ViT-L/14@336px) outperforms Noisy Student EfficientNet-L2 by 2.6% on 12-dataset suite, by 5% on 27-dataset suite

## Approach Overview

### 1. Natural Language Supervision
Learns perception from raw text paired with images – scalable, connects representations to language for flexible zero-shot transfer.

### 2. Dataset: WIT
500,000 queries (Wikipedia words, bigrams with high PMI, all WordNet synsets), up to 20,000 pairs per query. Total word count similar to WebText.

### 3. Contrastive Pre-training (CLIP)
Predict which of N×N possible pairings in a batch actually occurred. Uses InfoNCE / multi-class N-pair loss with a learned temperature parameter.

Symmetric loss: average of image-to-text and text-to-image cross-entropy losses. Temperature τ learned (initialized to 0.07, clipped to ≤100).

### 4. Model Architectures
**Image Encoder:** Two families – modified ResNet (with attention pooling, antialiased blur, ResNet-D improvements) and Vision Transformer (ViT). Scaled using EfficientNet-style (width, depth, resolution equally).
**Text Encoder:** Transformer (63M params, 12 layers, 512 width, 8 heads), BPE with 49,152 vocab, max sequence length 76. Activations at [EOS] token → layer norm → linear projection.

### 5. Training Details
- 32,768 batch size, 32 epochs
- Adam optimizer (decoupled weight decay), cosine LR schedule
- Mixed precision, gradient checkpointing, half-precision Adam
- Largest ResNet (RN50x64): 18 days on 592 V100 GPUs
- Largest ViT (ViT-L/14): 12 days on 256 V100 GPUs

## Key Experimental Results

### Zero-Shot Transfer
| Method | ImageNet | aYahoo | SUN |
|--------|----------|--------|-----|
| Visual N-Grams (2017) | 11.5 | 72.4 | 23.0 |
| CLIP | 76.2 | 98.4 | 58.5 |

**Prompt Engineering & Ensembling:** Prompt engineering and ensembling boost zero-shot classification performance by almost 5 points on average across 36 datasets. This improvement is similar to the gain from using 4 times more compute.

**Zero-shot vs. Supervised Baseline:** Zero-shot CLIP outperforms a fully supervised linear classifier on ResNet-50 features on 16 of 27 datasets.

**Data Efficiency of Zero-Shot:** Zero-shot CLIP matches the average performance of a 4-shot linear classifier on the same feature space. Median effective labeled examples per class required: 5.4.

**Scaling Behavior:** Zero-shot error decreases log-log linearly with compute across 5 CLIP ResNet models (44x compute range).

## Significance
CLIP demonstrated that natural language supervision at scale produces visual representations competitive with supervised ImageNet training, while enabling zero-shot transfer to diverse tasks. It fundamentally shifted the paradigm from fixed-label classification to flexible text-driven visual understanding.
