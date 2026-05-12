---
title: Learning Paradigms
created: 2026-05-12
updated: 2026-05-12
type: lineage
tags: [learning-paradigms, deep-learning, reinforcement-learning, scaling, resnet, bitter-lesson]
sources:
  - items/deep-residual-learning-for-image-recognition
  - items/dqn-atari-deep-reinforcement-learning
  - items/the-unreasonable-effectiveness-of-recurrent-neural-networks
  - items/the-bitter-lesson
---

## Overview

This lineage tracks the conceptual breakthroughs that shaped how neural networks learn: from the architectural innovation that enabled truly deep networks (ResNet), to the synthesis of deep learning with reinforcement learning (DQN), to the empirical and philosophical realizations that scale and general methods beat hand-crafted cleverness.

## Evolution Timeline

```
2012 ──► AlexNet ── deep learning revival on ImageNet (context)
 │
2013 ──► DQN (Mnih et al.) ── "Playing Atari with Deep RL"
 │           CNN + Q-learning = human-level Atari play from pixels
 │           Experience replay breaks sample correlation
 │
2014 ──► VGG, GoogLeNet ── going deeper (but hitting optimization walls)
 │
2015 ──► Char-RNN (Karpathy) ── "The Unreasonable Effectiveness of RNNs"
 │           Minimal code, LSTMs generate Shakespeare, LaTeX, Linux source
 │           Demonstrated that simple recurrent nets are surprisingly powerful
 │
2016 ──► ResNet (He et al.) ── "Deep Residual Learning for Image Recognition"
 │           Skip connections enable 152-layer networks (vs 19-layer VGG)
 │           Residual learning: F(x) = H(x) - x; solves vanishing gradients
 │           Won ILSVRC 2015 by large margin; became universal backbone
 │
2017 ──► Transformer ── attention replaces recurrence (see transformer-evolution)
 │         AlphaGo Zero ── self-play RL without human data
 │
2018 ──► BERT, GPT-2 ── pretraining + fine-tuning becomes dominant paradigm
 │
2019 ──► The Bitter Lesson (Sutton) ── "Compute > Cleverness"
 │           General methods that scale with compute always win over
 │           hand-crafted, domain-specific approaches in the long run
 │
2020+──► The Bitter Lesson validated: GPT-3, scaling laws, diffusion,
 │         AlphaFold ── all leverage compute + general algorithms
```

## Key Works

| Paper/Post | Year | Authors | Core Innovation | Impact |
|------------|------|---------|-----------------|--------|
| Playing Atari with Deep Reinforcement Learning (DQN) | 2013 | Mnih et al. | Convolutional neural network + Q-learning with experience replay. Learned policies directly from raw pixels across 7 Atari games. | Launched deep reinforcement learning; proved neural nets can learn control policies from high-dimensional sensory input |
| The Unreasonable Effectiveness of Recurrent Neural Networks | 2015 | Andrej Karpathy | Blog post demonstrating char-level LSTM generating coherent text (Shakespeare, wiki articles, C code) with minimal architecture. | Inspired a generation of practitioners; showed that simple RNNs capture surprisingly rich structure with enough data+compute |
| Deep Residual Learning for Image Recognition (ResNet) | 2016 | He et al. | Residual blocks with skip connections: output = F(x) + x. Enabled training networks with 100+ layers. Batch normalization throughout. | Universal backbone for vision (classification, detection, segmentation); residual connections adopted by Transformers |
| The Bitter Lesson | 2019 | Rich Sutton | Essay arguing that the biggest AI advances come from general methods that leverage computation (search, learning), not human-designed knowledge. Cites chess, speech, vision, Go. | Philosophical cornerstone; predicted and justified the scaling era. Reframes "clever" architecture design as a local minimum |

## Cross-References

- [[maps/concepts/residual]] — skip connections, the key architectural enabler of deep learning
- [[maps/concepts/reinforcement-learning]] — DQN's Q-learning foundation and beyond
- [[maps/concepts/scaling]] — The Bitter Lesson's core thesis: compute beats cleverness
- [[maps/concepts/recurrence]] — RNNs, LSTMs, and why they were eventually displaced by attention
- [[maps/lineage/transformer-evolution]] — how the Transformer embodies The Bitter Lesson: general attention + massive compute
- [[maps/lineage/generative-models-evolution]] — ResNet backbones in GANs, diffusion; DQN's RL lineage in RLHF
- [[maps/problems/vanishing-gradients]] — the problem ResNet solved
- [[maps/problems/sample-efficiency]] — DQN's experience replay and the RL sample complexity problem
