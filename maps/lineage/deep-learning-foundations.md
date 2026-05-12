---
title: Deep Learning Foundations
created: 2026-05-12
updated: 2026-05-12
type: lineage
tags: [deep-learning, resnet, scaling-laws, residual-connections, skip-connections, training-stability]
sources:
  - items/deep-residual-learning-for-image-recognition
  - items/scaling-laws-for-neural-language-models
---

## Overview

Deep learning's practical viability rests on two foundational pillars: architectural innovations that enable training deep networks (ResNet's residual connections), and empirical laws that guide resource allocation (Scaling Laws). Together, they explain why and how larger models trained on more data continue to improve — and what architectural constraints must be overcome to make that scaling possible.

## Evolution Timeline

```
2012 ──► AlexNet ── 8-layer CNN wins ImageNet (deep learning revival)
 │
2014 ──► VGG (19 layers), GoogLeNet (22 layers) ── going deeper
 │         But training deeper than ~20 layers becomes unstable
 │
2015 ──► ResNet (He et al.) ── "Deep Residual Learning"
 │           Skip connections solve the degradation problem
 │           Enables 152-layer networks (8× deeper than VGG)
 │           Won ILSVRC 2015 with 3.57% top-5 error
 │
2016 ──► ResNet becomes universal backbone for vision tasks
 │         Residual connections adopted by Transformer architecture
 │
2017 ──► Transformer (Vaswani et al.) ── uses residual connections + layer norm
 │
2018 ──► BERT, GPT ── deep Transformer stacks rely on residual paths
 │
2020 ──► Scaling Laws (Kaplan et al.) ── power-law relationship for N, D, C
 │           Larger models are more sample-efficient
 │           Architectural details matter <3% over wide range (depth varies 40×)
 │           Compute-optimal: train large models, stop before convergence
 │         GPT-3 (Brown et al.) ── validates scaling hypothesis at 175B params
 │
2021 ──► ViT (Dosovitskiy et al.) ── uses residual connections in Transformer
 │
2022 ──► Chinchilla (DeepMind) ── revises scaling: equal scaling of N and D
 │
2023 ──► LLaMA (Touvron et al.) ── smaller models + more tokens = efficient inference
 │         GPT-4 ── predictable scaling from 1/1000th compute runs
```

## Key Works

| Paper | Year | Authors | Core Innovation | Impact |
|-------|------|---------|-----------------|--------|
| Deep Residual Learning for Image Recognition (ResNet) | 2015 | He et al. | Residual blocks with identity shortcut connections: F(x) + x. Solves the degradation problem where deeper plain networks have higher training error. | Enabled 100+ layer networks; became universal backbone for vision; residual connections adopted by virtually every major architecture since (Transformer, GPT, BERT, ViT) |
| Scaling Laws for Neural Language Models | 2020 | Kaplan et al. | Power-law scaling of cross-entropy loss with model size (N^(-0.076)), dataset size (D^(-0.095)), and compute (C^(-0.050)). Larger models are more sample-efficient. | Guided resource allocation across all subsequent LLM training runs; established the scientific foundation for the scaling era |

## Cross-References

- [[maps/lineage/transformer-evolution]] — Transformers rely on residual connections from ResNet
- [[maps/lineage/learning-paradigms]] — The Bitter Lesson: why scaling methods (ResNet, scaling laws) beat hand-crafted features
- [[maps/concepts/residual-connections]] — detailed treatment of the residual/skip connection mechanism
- [[maps/concepts/scaling-behavior]] — the mathematical structure of scaling phenomena
- [[maps/problems/compute-scaling]] — the economic and engineering problem of scaling model size
