---
title: Compute Scaling
created: 2026-05-12
updated: 2026-05-12
type: problem
tags: [compute, scaling, cost, training, efficiency, gpu, economics, power-law]
sources:
  - items/scaling-laws-for-neural-language-models
  - items/language-models-are-few-shot-learners
  - items/gpt-4-technical-report
  - items/llama-open-and-efficient-foundation-language-models
  - items/the-bitter-lesson
---

## Problem Definition

The cost of training and deploying AI models grows super-linearly with capability. Each generation of models requires exponentially more compute: GPT-3 (175B params) cost an estimated $4.6M in compute; GPT-4 is rumored to cost $100M+ to train; future models may cost $1B+. This creates a fundamental tension: scaling improves capabilities but concentrates AI development in the hands of the few organizations that can afford the compute.

The problem has three dimensions:
1. **Training cost:** Hardware, energy, and time to train a model to completion.
2. **Inference cost:** Per-token compute cost to serve the model to users.
3. **Access cost:** The barrier to entry for researchers, startups, and developing nations.

> Rich Sutton's "The Bitter Lesson" argues that methods leveraging computation win in the long run — but the bitter corollary is that *only those with massive computation can participate.*

## Why This Is Hard

- **Power-law returns, exponential costs.** Loss scales as L(C) ∝ C^(-0.050) — each 10× increase in compute reduces loss by only ~11%. To halve the loss gap, you need ~1,000,000× more compute. The curve is brutally diminishing.

- **Hardware is a bottleneck.** The A100/H100 GPU supply is constrained; demand exceeds supply. Training GPT-3 175B took thousands of GPUs for weeks. Doubling throughput requires not just more GPUs but fundamentally new interconnect architectures.

- **The training/inference tradeoff.** LLaMA showed that training a smaller model (13B) on more tokens (1T) yields better inference efficiency than training a larger model (175B) on fewer tokens. But this only solves *inference* cost, not training cost. The optimal training regime depends on whether you optimize for training budget (Kaplan's scaling laws) or serving budget (LLaMA's approach).

- **MoE and architectural complexity.** Mixture-of-Experts (MoE) architectures — rumored for GPT-4 — increase parameter count without proportional FLOPs, making the simple N/D/C scaling framework insufficient. Sparse models require new analytical tools.

- **Data quality as hidden cost.** Filtering, deduplicating, and curating training data at scale (Common Crawl → 410B tokens for GPT-3) requires significant compute and engineering. Low-quality data wastes training compute.

## Evidence from GOSK Items

| Paper/Work | Year | Compute Used | Cost Implications |
|------------|------|--------------|-------------------|
| Attention Is All You Need (Transformer) | 2017 | 8 GPUs × 3.5 days (En→Fr) | The era of accessible compute. A single researcher could train a SOTA model on modest hardware. |
| Scaling Laws (Kaplan et al.) | 2020 | 7+ orders of magnitude of compute | Established that larger models are more sample-efficient but require exponentially more compute for linear improvement. Compute-optimal training uses D ~ C^0.27. |
| GPT-3 (Brown et al.) | 2020 | 3.64 petaflop/s-days for 175B (~$4.6M at cloud prices) | Training compute had increased ~1000× from the Transformer. Only well-funded organizations could participate. 175B is expensive to serve — each inference call requires ~350 GFLOPS. |
| GPT-4 (OpenAI) | 2023 | Estimated $100M+ (undisclosed), models using ≤1/1000th of GPT-4's compute were used for scaling predictions | Closed-source, no architecture details. If true MoE, parameter count may be 1.5T+ but with 200B+ active per inference. This would mean the compute-to-capability ratio improved dramatically. |
| LLaMA (Touvron et al.) | 2023 | 2048 A100-80GB × 21 days for 65B (1.4T tokens). Throughput: ~380 tokens/sec/GPU. | Training compute similar to GPT-3 scale but for 65B (1/3 the params). 13B model runs on a single GPU. Demonstrates that open models can achieve competitive performance at a fraction of the serving cost. |
| The Bitter Lesson (Sutton) | 2019 | 70 years of AI history | Philosophical argument: general methods that leverage computation always win. But the bitter lesson for *access*: if compute is what matters, only those with compute can compete. |

## Approaches Tried

### 1. Compute-Optimal Training (Kaplan regime, 2020)
Train very large models on relatively little data; stop before convergence. Minimizes loss for a given training budget.
- **Worked:** Guided GPT-3's resource allocation; predicted that 175B on 300B tokens was near-optimal for training budget.
- **Problem:** Assumes training cost is the only budget. Ignored inference cost, data quality, and the Chinchilla revision.

### 2. Data-Rich Training (Chinchilla/LLaMA regime, 2022-2023)
Train smaller models on proportionally more tokens. LLaMA-13B (1T tokens) outperforms GPT-3 175B (300B tokens).
- **Worked:** Dramatically improves inference efficiency. 13B model fits on a single GPU; 65B fits on a single server.
- **Problem:** Training cost may be *higher* (LLaMA-65B trained on 1.4T tokens vs. GPT-3's 300B). The tradeoff shifts training cost to the model developer and inference cost savings to the model user.

### 3. Efficient Architectures
Pre-normalization (RMSNorm instead of LayerNorm), SwiGLU activation (2⅔d instead of 4d), rotary position embeddings (RoPE), FlashAttention, model parallelism, gradient checkpointing.
- **Worked:** LLaMA's architectural improvements deliver GPT-3-level performance at 1/10th the parameters (13B vs 175B). Efficient attention (FlashAttention, xformers) reduces memory footprint 2-5×.
- **Problem:** These are one-time efficiency gains, not a solution to the scaling curve itself. Diminishing returns on architectural optimization.

### 4. Sparse Models (MoE)
Mixture-of-Experts activates only a subset of parameters per token. Parameter count and FLOPs per token are decoupled.
- **Worked:** Enables very large models with manageable per-inference cost. GPT-4 and Mixtral 8×7B demonstrate ~OLMo costs for much higher effective capability.
- **Problem:** Training MoE models is challenging (load balancing, expert collapse). The simple scaling framework (L ∝ N^(-0.076)) no longer applies cleanly. Harder to study and reproduce.

## Current Frontier

- **Inference-time compute scaling.** Chain-of-thought, tree-of-thought, and tool-use spend compute at inference rather than training. This creates a new scaling axis beyond N/D/C.
- **Small model + distillation.** Can a small model trained on a large model's outputs (distillation) match the large model's capabilities at a fraction of the cost? LLaMA-13B → Alpaca → Vicuna showed promising results.
- **Open-source compute gap.** Despite LLaMA's progress, the gap between open models and GPT-4/Claude 3 remains large. The compute required to close this gap may be prohibitive for open-source efforts.
- **Carbon and energy.** Training a single large model can emit as much CO₂ as 5 cars over their lifetimes. As models grow, sustainability becomes a binding constraint.
- **What remains unsolved:** Can we get GPT-4-level capability at a fraction of the compute cost? Is there a fundamentally more efficient architecture beyond the Transformer? Can we predict the optimal compute-to-capability frontier before spending millions of dollars?

## Cross-References

- [[maps/concepts/scaling-behavior]] — the mathematical structure of scaling phenomena
- [[maps/lineage/deep-learning-foundations]] — how scaling laws guide resource allocation
- [[maps/lineage/transformer-evolution]] — the compute trajectory from 8-GPU Transformer to the $100M+ GPT-4
- [[maps/lineage/learning-paradigms]] — The Bitter Lesson's argument that compute beats cleverness
- [[maps/concepts/self-supervised-learning]] — the pretraining objectives that consume the compute budget
- [[maps/problems/model-evaluation]] — how to measure whether the compute investment was worthwhile
