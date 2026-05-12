---
source_url: https://arxiv.org/abs/2010.11929
ingested: 2026-05-12
---

# An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale

**Authors:** Alexey Dosovitskiy, Lucas Beyer, Alexander Kolesnikov, Dirk Weissenborn, Xiaohua Zhai, Thomas Unterthiner, Mostafa Dehghani, Matthias Minderer, Georg Heigold, Sylvain Gelly, Jakob Uszkoreit, Neil Houlsby (Google Research, Brain Team)
**Published at:** ICLR 2021

---

## Abstract

When pre-trained on large amounts of data and transferred to multiple mid-sized or small image recognition benchmarks (ImageNet, CIFAR-100, VTAB, etc.), Vision Transformer (ViT) attains excellent results compared to state-of-the-art convolutional networks while requiring substantially fewer computational resources to train.

---

## 1. Introduction

- **Problem:** Self-attention architectures (Transformers) dominate NLP but computer vision still relies on CNNs.
- **Approach:** Apply a standard Transformer directly to images with minimal modifications: split image into patches, treat them as token sequences.
- **Key Insight:** "We find that large scale training trumps inductive bias." With sufficient data (14M-300M images), Transformers outperform CNNs.

---

## 2. Method - Vision Transformer (ViT)

### Architecture Overview

- **Input:** Image → reshape into flattened 2D patches.
- **Patch Embedding:** Trainable linear projection to constant latent dimension D.
- **Position Embeddings:** Standard learnable 1D position embeddings.
- **Classification Token:** Learnable [class] token prepended; its output state serves as image representation.
- **Transformer Encoder:** Alternating layers of Multi-Head Self-Attention (MSA) and MLP blocks, with LayerNorm before every block and residual connections after.

### Model Variants

| Model | Layers | Hidden size D | MLP size | Heads | Params |
|-------|--------|---------------|----------|-------|--------|
| ViT-Base | 12 | 768 | 3072 | 12 | 86M |
| ViT-Large | 24 | 1024 | 4096 | 16 | 307M |
| ViT-Huge | 32 | 1280 | 5120 | 16 | 632M |

---

## 3. Experiments

### Training Setup
- Optimizer: Adam (β₁=0.9, β₂=0.999), batch size 4096, weight decay 0.1.
- Learning rate schedule: Linear warmup + linear decay.
- Fine-tuning: SGD with momentum, batch size 512, cosine LR decay.

### Comparison to State of the Art

| Model | ImageNet | CIFAR-100 | VTAB | TPUv3-core-days |
|-------|----------|-----------|------|-----------------|
| ViT-H/14 (JFT-300M) | 88.55 | 94.55 | 77.63 | 2.5k |
| BiT-L (ResNet152x4) | 87.54 | 93.51 | 76.29 | 9.9k |
| Noisy Student (EfficientNet-L2) | 88.4 | - | - | 12.3k |

- ViT achieves comparable or better accuracy while using **2.5-4× less compute** than BiT, and **5× less** than Noisy Student.

### Pre-training Data Requirements
- With small datasets (ImageNet only), ViT-L underperforms ViT-B and CNNs.
- With ImageNet-21k or JFT-300M, ViT matches or surpasses state-of-the-art CNNs.

---

## Significance

ViT demonstrated that a pure Transformer architecture, without any convolutional inductive biases, could match or exceed CNNs on image recognition tasks when trained at sufficient scale. It sparked the "Transformer for vision" revolution, leading to models like Swin Transformer, DeiT, and MAE.
