---
title: Representation Learning
created: 2026-05-12
updated: 2026-05-12
type: problem
tags: [representation-learning, pretraining, self-supervised, contrastive, generative, embedding]
sources: [items/bert-pretraining-of-deep-bidirectional-transformers, items/clip-transferable-visual-models, items/an-image-is-worth-16x16-words-vision-transformer, items/auto-encoding-variational-bayes]
---

## Problem Definition

How do we learn representations of data that are useful across many downstream tasks without requiring task-specific labels? The goal is to encode raw inputs (text, images, audio) into compact, structured vector spaces where semantic relationships are preserved: similar concepts are close, and the geometry supports transfer to new tasks with minimal labeled examples.

This problem sits at the intersection of unsupervised learning, transfer learning, and data efficiency. A good representation solves many problems at once — classification, retrieval, generation, reasoning — but a bad representation requires relearning everything from scratch for each task.

## Why This Is Hard

- **No single objective defines "good" representation.** BERT uses masked token prediction, CLIP uses image-text contrastive matching, VAEs maximize a variational lower bound. Each objective captures different structural properties, and no one metric dominates across all downstream uses.
- **The supervision dilemma.** Supervised representations (trained with labels) are narrow — a classifier trained on ImageNet learns features tuned to 1000 categories, not general visual understanding. Unsupervised representations risk learning trivial or irrelevant structure (e.g., pixel-level statistics that don't capture semantics).
- **Modality gap.** Learning representations that bridge modalities (text + image in CLIP, or text + structured knowledge) requires aligning fundamentally different data distributions into a shared space. The geometry of the joint embedding space determines zero-shot transfer quality but is hard to control directly.
- **Pretraining data requirements.** ViT exposed a stark truth: pure transformers without convolutional inductive bias *fail* on medium-sized datasets (ImageNet-only training). They need massive pretraining (JFT-300M, 300M images) to learn spatial structure that CNNs get "for free" from architecture. The representation quality ceiling is set by pretraining scale.
- **Latent variable intractability.** VAEs confront the fundamental challenge: the true posterior over latent variables p(z|x) is intractable, so we must approximate it. The quality of the approximation determines what structure the latent space captures. Too tight a bound (simple Gaussian prior) blurs generations; too loose an approximation learns nothing useful.
- **Evaluation is fragmented.** No single benchmark captures representation quality. BERT is evaluated on GLUE (11 NLP tasks), CLIP on zero-shot transfer to 27 datasets, ViT on ImageNet + VTAB. Good performance on one suite doesn't guarantee transfer to others — and real-world deployment often reveals gaps these suites miss.

## Approaches Tried

| Paper | Year | Approach | What Worked | What Didn't |
|-------|------|----------|-------------|-------------|
| VAE (Kingma & Welling) | 2013 | Variational auto-encoder with reparameterization trick; learn latent z via encoder-decoder with Gaussian prior | Reparameterization trick makes stochastic gradient training of latent variable models tractable; continuous, structured latent space; generative capability alongside representation | Gaussian prior produces blurry generations; latent space can suffer from posterior collapse (decoder ignores z); representations less competitive with later contrastive/self-supervised methods on discriminative tasks |
| BERT (Devlin et al.) | 2018 | Bidirectional Transformer encoder pretrained with masked language modeling (MLM) + next sentence prediction (NSP) | Bidirectional context is a breakthrough — MLM lets the model condition on both left and right; established "pretrain then fine-tune" paradigm; SOTA on 11 NLP tasks with minimal task-specific architecture | NSP later shown by RoBERTa to be unnecessary or even harmful; 15% masking is inefficient (only 15% of tokens contribute to loss per batch); static masking misses opportunity for harder negatives |
| CLIP (Radford et al.) | 2021 | Contrastive pretraining on 400M (image, text) pairs; dual-encoder (ViT/ResNet + Transformer) | Zero-shot ImageNet matching supervised ResNet-50; text-driven classification enables flexible, open-vocabulary transfer; scaling behavior follows smooth power law across 44× compute range | Struggles on fine-grained classification (species, models); brittle to text prompting (ensembling needed for 5% gain); doesn't capture spatial/relational reasoning well; inherited biases from internet training data |
| ViT (Dosovitskiy et al.) | 2020 | Pure Transformer applied to image patches; pretrain on large datasets, fine-tune on downstream | At sufficient scale, matches or beats CNNs with 2.5-5× less compute; demonstrates that large-scale pretraining trumps architectural inductive bias; unified architecture across vision and language | Without massive pretraining data, ViT underperforms CNNs — needs JFT-300M or ImageNet-21k to shine; patch-level tokenization loses fine-grained spatial structure; position embeddings don't naturally generalize to resolution changes |

## Current Frontier

- **Masked image modeling (MAE, BEiT, SimMIM).** Following BERT's lead, masking random image patches and reconstructing them has emerged as a powerful self-supervised vision pretraining strategy — simpler than contrastive methods and scales well. This brings the vision and NLP pretraining paradigms closer.
- **Joint embedding architectures.** CLIP's dual-encoder approach spawned an entire family (SigLIP, BLIP, LiT, CoCa) exploring how to best fuse vision and language — through contrastive losses, captioning losses, or both. The geometry of the joint space remains poorly understood.
- **Discrete representations (VQ-VAE, DALL-E).** VAEs with discrete latent codes (vector quantization) produce sharper generations and enable autoregressive modeling in latent space. This bridges representation learning and generation in a way continuous VAEs never achieved.
- **What remains unsolved:** (1) A unified representation objective that works equally well across modalities without modality-specific tuning. (2) Representations that capture causal and compositional structure, not just statistical co-occurrence. (3) Efficient methods for learning from raw, uncurated data at internet scale without inheriting biases. (4) Representations that support both discriminative tasks (classification) and generative tasks (sampling) with a single model. (5) Understanding what information is actually encoded in these representations — interpretability of learned embeddings remains primitive.

## Cross-References

- [[maps/lineage/self-supervised-learning]] — The evolution from autoregressive to masked to contrastive pretraining objectives
- [[maps/lineage/transformer-architecture]] — The Transformer architecture that made scalable representation learning possible in both NLP and vision
- [[maps/concepts/contrastive-learning]] — InfoNCE loss and the geometry of contrastive representation spaces
- [[maps/problems/scaling-and-efficiency]] — The scaling problem: how much compute do we need to learn good representations, and can we get more from less?
- [[maps/lineage/generative-models]] — From VAE to GAN to diffusion: the generative side of learning representations
