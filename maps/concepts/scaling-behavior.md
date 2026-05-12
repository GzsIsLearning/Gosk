---
title: Scaling Behavior
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [scaling, power-law, compute, model-size, data, emergent-abilities, sample-efficiency]
sources:
  - items/scaling-laws-for-neural-language-models
  - items/language-models-are-few-shot-learners
  - items/gpt-4-technical-report
  - items/llama-open-and-efficient-foundation-language-models
  - items/the-bitter-lesson
---

## Definition

Scaling behavior describes how model performance (typically cross-entropy loss) changes as a function of three key resources: model parameters (N), dataset size (D), and compute (C). The Scaling Laws paper (Kaplan et al., 2020) established that language model loss follows a smooth power-law across all three dimensions when not bottlenecked by the others:

- L(N) ∝ N^(-0.076) — limited by model parameters
- L(D) ∝ D^(-0.095) — limited by dataset size
- L(C) ∝ C^(-0.050) — limited by compute budget

These power-laws hold across more than seven orders of magnitude, with architectural details (depth, width, shape) causing less than 3% variation.

> "Performance depends strongly on scale, weakly on shape." — Kaplan et al., 2020

## Why It Matters

Scaling behavior is the scientific foundation that justifies the "bigger is better" approach to AI. Understanding it answers critical questions:

1. **Resource allocation:** How to budget compute between model size and data to minimize loss for a fixed budget.
2. **Predictability:** Can we predict the performance of a 1000× larger model from small-scale experiments?
3. **Diminishing returns:** How much more compute is needed for each unit of improvement?
4. **Emergence:** At what scale do new capabilities (in-context learning, reasoning) appear?

## Where It Appears

| Paper/Work | Year | Key Scaling Finding | Practical Implication |
|------------|------|---------------------|-----------------------|
| Scaling Laws (Kaplan et al.) | 2020 | Power-law exponents: α_N ≈ 0.076, α_D ≈ 0.095, α_C ≈ 0.050. Larger models are more sample-efficient (8× model size needs only 5× more data). | For a fixed compute budget, train very large models on relatively little data and stop far short of convergence. D ~ C^0.27 is compute-optimal. |
| GPT-3 (Brown et al.) | 2020 | In-context learning ability improves smoothly with model size across 125M → 175B parameters. Zero/few-shot performance follows power-law trends. | Scaling unlocks emergent abilities — few-shot capability at 175B is far stronger than at 125M, even though the training objective (next token prediction) is the same. |
| GPT-4 (OpenAI) | 2023 | Loss prediction from models using ≤1/1000th of GPT-4's compute — power-law fits accurately predict final loss. HumanEval pass rate follows power law. Some tasks show inverse scaling (get worse with scale). | Scaling laws enable predictable capability growth, but capability emergence is more complex than loss alone. Calibration degrades after RLHF post-training. |
| LLaMA (Touvron et al.) | 2023 | 13B model surpasses GPT-3 175B on most benchmarks. 65B competitive with Chinchilla-70B and PaLM-540B. Training on more tokens (1.4T) with smaller models gives better inference efficiency. | Challenges the compute-optimal paradigm from Kaplan. If inference cost matters more than training cost, the optimal is smaller models + more data. |
| The Bitter Lesson (Sutton) | 2019 | "General methods that leverage computation are ultimately the most effective, and by a large margin." Historical evidence from chess, Go, speech, vision. | Philosophical foundation: scaling general methods (search, learning) beats encoding human knowledge. Empirical scaling laws provide the mechanism. |

## Power-Law Mathematics

The core relationships (from Kaplan et al., 2020):

| Relationship | Equation | Exponent | Interpretation |
|-------------|----------|----------|----------------|
| Loss vs. Parameters (converged) | L(N) = (N_c / N)^α_N | α_N ≈ 0.076 | To halve the loss gap, multiply N by ~8800× |
| Loss vs. Data (converged) | L(D) = (D_c / D)^α_D | α_D ≈ 0.095 | Slightly steeper than N; data matters more than size at the margin |
| Loss vs. Compute | L(C_min) = (C_c / C_min)^α_C | α_C ≈ 0.050 | Flattest slope — compute is the hardest bottleneck |
| Overfitting threshold | N^0.74 / D | — | Every 8× model increase needs only 5× more data to avoid overfitting |
| Optimal batch size | B_crit(L) = B_* / L^(1/α_B) | α_B ≈ 0.21 | ~1-2M tokens at convergence for largest models |
| Compute per training step | C ≈ 6 N B S FLOPs | — | Non-embedding parameters dominate; embedding parameters obscure scaling |

## Key Phenomena

### Predictable Scaling vs. Capability Emergence
Loss scales smoothly with N, D, and C — but capabilities do not always follow. GPT-3 showed that in-context learning emerges sharply beyond a threshold size. GPT-4 showed some tasks follow smooth power-laws (HumanEval) while others show discontinuous jumps. This is the "scaling cliff" phenomenon: loss improvement predicts *potential* but not *which* capabilities materialize.

### Compute-Optimal Training (and Its Revision)
Kaplan (2020) recommended: for a fixed compute budget C, train large models on D ~ C^0.27 tokens. Chinchilla (2022) revised this: the optimal ratio is equal scaling of N and D — meaning larger models need proportionally more data. The Kaplan regime trained models with too few tokens. LLaMA further challenged this by optimizing for *inference* efficiency (smaller model + more tokens) rather than training budget.

### The Efficiency-Frontier Tradeoff
Three different scaling philosophies:
1. **Compute-optimal (Kaplan):** Minimize loss for a given training compute budget. Trains large models on minimal data.
2. **Data-optimal (Chinchilla):** Equal scaling of model and data for training budget. More balanced.
3. **Inference-optimal (LLaMA):** Minimize inference cost while maintaining capability. Smaller models trained on more data are cheaper to serve.

## Cross-References

- [[maps/lineage/deep-learning-foundations]] — the interplay of scaling laws with architectural innovations like ResNet
- [[maps/lineage/transformer-evolution]] — how scaling laws guided the evolution from BERT through GPT-3/4 and LLaMA
- [[maps/concepts/self-supervised-learning]] — the pretraining objectives that define the loss being scaled
- [[maps/problems/compute-scaling]] — the economic and engineering challenges of scaling up
- [[maps/problems/model-evaluation]] — how to evaluate models fairly when they differ in scale by orders of magnitude
- [[maps/lineage/learning-paradigms]] — The Bitter Lesson's philosophical frame for scaling behavior
