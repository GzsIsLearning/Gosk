---
source_url: https://arxiv.org/abs/1706.03762
ingested: 2026-05-12
---

# Attention Is All You Need

**Paper:** arXiv:1706.03762 (v7, 2 Aug 2023)
**Authors:** Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Lukasz Kaiser, Illia Polosukhin
**Subjects:** Computation and Language (cs.CL); Machine Learning (cs.LG)

---

## Abstract

The dominant sequence transduction models are based on complex recurrent or convolutional neural networks in an encoder-decoder configuration. The best performing models also connect the encoder and decoder through an attention mechanism. We propose a new simple network architecture, the Transformer, based solely on attention mechanisms, dispensing with recurrence and convolutions entirely.

Our model achieves 28.4 BLEU on the WMT 2014 English-to-German translation task, improving over the existing best results, including ensembles by over 2 BLEU. On the WMT 2014 English-to-French translation task, our model establishes a new single-model state-of-the-art BLEU score of 41.8 after training for 3.5 days on eight GPUs, a small fraction of the training costs of the best models from the literature.

---

## Core Contributions

- **Transformer architecture** – purely attention-based, no recurrence or convolutions.
- **Superior parallelizability** – faster training than RNN/CNN baselines.
- **State-of-the-art results** on WMT translation tasks with significantly less compute.

---

## Key Results

| Task | BLEU | Training Time | Hardware |
|------|------|---------------|----------|
| WMT 2014 En→De | **28.4** (single model, beats ensembles by >2 BLEU) | Not specified in abstract | 8 GPUs |
| WMT 2014 En→Fr | **41.8** (single model, SOTA) | 3.5 days | 8 GPUs |

- **Generalization** – successfully applied to English constituency parsing (both large and limited training data).

---

## Architecture Highlights

- **Encoder-Decoder** with stacked self-attention and point-wise feed-forward layers.
- **Multi-Head Attention** – allows the model to attend to different representation subspaces.
- **Positional Encoding** – injects sequence order information (no recurrence).
- **Residual connections & layer normalization** for training stability.

---

## Significance

This paper introduced the Transformer, which became the foundation for virtually all modern large language models (GPT, BERT, T5, etc.) and revolutionized NLP and beyond. The title "Attention Is All You Need" encapsulates the core insight that attention mechanisms alone can replace recurrence and convolution in sequence transduction.
