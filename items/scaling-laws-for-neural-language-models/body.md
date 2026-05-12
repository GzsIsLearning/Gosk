---
source_url: https://arxiv.org/abs/2001.08361
ingested: 2026-05-12
---

# Scaling Laws for Neural Language Models

**Authors:** Jared Kaplan, Sam McCandlish, Tom Henighan, Tom B. Brown, Benjamin Chess, Rewon Child, Scott Gray, Alec Radford, Jeffrey Wu, Dario Amodei

**Affiliation:** OpenAI / Johns Hopkins University

## Abstract

Empirical scaling laws for language model performance on cross-entropy loss. The loss scales as a power-law with model size, dataset size, and the amount of compute used for training, with trends spanning more than seven orders of magnitude. Architectural details such as network width or depth have minimal effects within a wide range. Larger models are significantly more sample-efficient, such that optimally compute-efficient training involves training very large models on a relatively modest amount of data and stopping significantly before convergence.

## Key Findings

- **Performance depends strongly on scale, weakly on shape.** The three scale factors are model parameters N (non-embedding), dataset size D, and compute C.
- **Smooth power laws.** Loss follows a power-law with N, D, and C when not bottlenecked by the other two — trends span >6 orders of magnitude.
- **Universality of overfitting.** Performance degrades predictably when either N or D is held fixed. The penalty depends on the ratio N^0.74 / D. Every 8× increase in model size requires only 5× more data to avoid penalty.
- **Universality of training curves.** Learning curves follow predictable power-laws; early training can be extrapolated to predict later loss.
- **Convergence is inefficient.** Under a fixed compute budget, optimal performance comes from training very large models and stopping far short of convergence. Maximally compute-efficient training uses D ~ C^0.27.
- **Optimal batch size** is a power of the loss only, roughly 1–2 million tokens at convergence for largest models.

## Specific Scaling Laws

- Loss limited by parameters N (converged): L(N) = (N_c / N)^α_N, α_N ≈ 0.076, N_c ≈ 8.8×10^13
- Loss limited by dataset D: L(D) = (D_c / D)^α_D, α_D ≈ 0.095, D_c ≈ 5.4×10^13 tokens
- Loss limited by compute C: L(C_min) = (C_c_min / C_min)^α_C, α_C ≈ 0.050, C_c_min ≈ 3.1×10^8 PF-days
- Critical batch size: B_crit(L) = B_* / L^(1/α_B), B_* ≈ 2×10^8 tokens, α_B ≈ 0.21

## Practical Implications

- For fixed N, varying depth by factor 40 or width/depth ratio changed loss by <3%.
- Including embedding parameters obscures the scaling; power-law fits better with non-embedding count only.
- Compute estimate: C ≈ 6 N B S FLOPs (non-embedding).
- Transfer improves with test performance — out-of-distribution loss correlates strongly with in-distribution validation loss, roughly constant offset.
