---
source_url: https://arxiv.org/abs/2005.14165
ingested: 2026-05-12
---

# Language Models are Few-Shot Learners

**Authors:** Tom B. Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, Sandhini Agarwal, Ariel Herbert-Voss, Gretchen Krueger, Tom Henighan, Rewon Child, Aditya Ramesh, Daniel M. Ziegler, Jeffrey Wu, Clemens Winter, Christopher Hesse, Mark Chen, Eric Sigler, Mateusz Litwin, Scott Gray, Benjamin Chess, Jack Clark, Christopher Berner, Sam McCandlish, Alec Radford, Ilya Sutskever, Dario Amodei

**Affiliation:** OpenAI

## Abstract

Scaling up language models greatly improves task-agnostic, few-shot performance, sometimes reaching competitiveness with prior state-of-the-art fine-tuning approaches. GPT-3 is an autoregressive language model with 175 billion parameters — 10× larger than any previous non-sparse language model. Evaluation is done with no gradient updates or fine-tuning; tasks are specified purely via text interaction (few-shot, one-shot, zero-shot). Strong performance on translation, QA, cloze tasks, unscrambling words, using novel words, 3-digit arithmetic. Generates news articles hard to distinguish from human-written.

**Limitations:** Struggles on some NLI tasks (e.g., ANLI) and reading comprehension (e.g., RACE, QuAC). Issues with training on large web corpora (data contamination).

## Key Concepts

- **In-context learning:** The model develops broad skills during pre-training and uses them at inference time to adapt — the "inner loop" of meta-learning.
- **Three settings:** Few-shot (≤100 demonstrations in context, no weight updates), One-shot (one demonstration + NL description), Zero-shot (only NL instruction, no examples).
- **Scale hypothesis:** In-context learning abilities should improve with model size.

## Architecture

- Same as GPT-2 (Transformer decoder) with alternating dense and locally banded sparse attention patterns (Sparse Transformer style).
- Context window: 2048 tokens.
- Eight model sizes (125M → 175B parameters).
- GPT-3 175B: 96 layers, d_model=12288, 96 heads, d_head=128, batch 3.2M tokens, lr=0.6×10⁻⁴.

## Training

- Primary source: filtered Common Crawl (410B tokens, 60% training mix) plus WebText2, Books1, Books2, Wikipedia.
- Higher-quality datasets oversampled (Wikipedia 3.4 epochs, Common Crawl only 0.44 epochs).
- Compute: 3.64 petaflop/s-days for GPT-3 175B.
- Adam with β₁=0.9, β₂=0.95, gradient clipping 1.0, cosine LR decay to 10%.

## Key Results

- LAMBADA zero-shot: 76.2% (previous SOTA: 68.0%)
- LAMBADA few-shot: 86.4% — +18% over SOTA
- TriviaQA few-shot: 71.2% (previous closed-book SOTA: 60.5%, T5-11B)
- PTB perplexity zero-shot: 20.5 (previous SOTA: 35.8)
- NaturalQuestions few-shot: 29.9%
- HellaSwag few-shot: 79.3% (below fine-tuned ALUM at 85.6%)
