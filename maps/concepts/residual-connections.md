---
title: Residual Connections
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [residual-connections, skip-connections, deep-learning, training-stability, vanishing-gradients, resnet, transformer]
sources:
  - items/deep-residual-learning-for-image-recognition
  - items/attention-is-all-you-need
  - items/an-image-is-worth-16x16-words-vision-transformer
  - items/the-illustrated-transformer
---

## Definition

Residual connections (also called skip connections or shortcut connections) are a neural network design where a layer's input is added directly to its output, creating an alternative gradient path around the layer. Formally, instead of learning a direct mapping H(x), the layer learns a residual function F(x) = H(x) - x, and the output is y = F(x) + x. If the identity mapping were optimal (no change needed), the layer can simply push its weights toward zero — easier than learning to approximate identity through nonlinear transformations.

Introduced in ResNet (He et al., 2015), residual connections were the key to training networks with 100+ layers. The basic building block:

```
Input x ──► Conv → BN → ReLU → Conv → BN ─┐
    │                                       │
    └─────────── identity shortcut ─────────┘ Adding + ReLU ──► Output
```

## Why It Matters

Before ResNet, deeper networks were harder to optimize — the "degradation problem" meant that a 56-layer plain network had *higher* training error than a 20-layer one. Residual connections solved this by providing:
1. **Unimpeded gradient flow:** Gradients can bypass the nonlinear layers via the identity path, preventing vanishing/exploding gradients.
2. **Easier optimization:** Learning F(x) = H(x) - x is empirically easier than learning H(x) directly. If identity is optimal, F(x) = 0 is trivial (just zero the weights).
3. **Ensemble-like behavior:** ResNets behave like ensembles of shallower networks, since each residual block contributes incrementally.

> "If an identity mapping were optimal, it would be easier to push the residual to zero than to fit an identity mapping by a stack of nonlinear layers." — He et al., 2015

## Where It Appears

| Paper | Year | How It's Used | Key Insight |
|-------|------|---------------|-------------|
| Deep Residual Learning for Image Recognition (ResNet) | 2015 | Identity shortcut connections in residual blocks (F(x) + x). Projection shortcuts when dimensions differ (Ws x). Parameter-free identity shortcuts sufficient; no added parameters or compute. | ResNets as shallow as 18 layers outperform plain 34-layer nets. 152-layer ResNet has *lower* complexity than VGG-16/19. Layer responses are smaller, suggesting smoother representations. |
| Attention Is All You Need (Transformer) | 2017 | Residual connections around every sub-layer (both self-attention and feed-forward), followed by layer normalization. "Add & Norm" pattern repeated per block. | Residual paths enable the Transformer's deep stack (6+ layers each for encoder/decoder). Combined with layer norm, supports stable training without gradient issues despite complete absence of recurrence. |
| An Image is Worth 16x16 Words (ViT) | 2020 | Standard Transformer residual connections: LayerNorm before each block, residual connections after. Same "Pre-LN" pattern as the original Transformer. | Enables training ViT-Huge (32 layers, 632M parameters). Without residual connections, gradient flow through 32-layer transformer would be severely impeded. |
| The Illustrated Transformer | 2018 | Visual explanation: "Each sub-layer in each encoder has a residual connection around it, and is followed by a layer-normalization step." Q/K/V computation → attention → residual → layer norm → FF → residual → layer norm. | Pedagogue's lens: residual connections are described as the architectural glue that makes deep Transformer stacks trainable. |

## Variants and Evolution

- **Identity shortcut (ResNet v1):** F(x) + x when dimensions match. No added parameters. Parameter-free shortcuts are sufficient — projection shortcuts (Ws x) for dimension changes only.
- **Bottleneck block:** 1×1 → 3×3 → 1×1 convolutions reduce parameters while maintaining depth (used in ResNet-50/101/152).
- **Pre-activation ResNet (v2):** Batch normalization + ReLU before the weight layers (not after). Makes training even easier and improves regularization.
- **Transformer Pre-LN:** LayerNorm applied *before* each sub-layer (instead of after), with residual connections after. This is the standard in modern Transformers (GPT, ViT, LLaMA), enabling stable training at extreme depths.
- **Dense connections (DenseNet):** Each layer connects to every subsequent layer, maximizing gradient flow. More extreme than residual connections but also more memory-intensive.

## Cross-References

- [[maps/lineage/deep-learning-foundations]] — how residual connections and scaling laws jointly enabled modern deep learning
- [[maps/lineage/transformer-evolution]] — residual connections as the unsung enabler of deep Transformer stacks
- [[maps/lineage/learning-paradigms]] — ResNet as the breakthrough that made deep networks practical
- [[maps/concepts/attention-mechanisms]] — multi-head attention uses residual connections in its "Add & Norm" pattern
- [[maps/problems/vanishing-gradients]] — the problem residual connections were designed to solve
