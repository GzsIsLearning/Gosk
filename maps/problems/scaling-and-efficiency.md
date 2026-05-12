---
title: Scaling and Efficiency
created: 2026-05-12
updated: 2026-05-12
type: problem
tags: [scaling, efficiency, compute, language-model, power-law, transformer]
sources: [items/scaling-laws-for-neural-language-models, items/language-models-are-few-shot-learners, items/gpt-4-technical-report, items/llama-open-and-efficient-foundation-language-models, items/the-bitter-lesson]
---

## Problem Definition

How should we allocate limited compute, data, and model capacity to maximize model capability? The core tension: bigger models perform better, but training and serving them costs exponentially more. This problem spans economics (is the next scale-up worth it?), science (what are the scaling laws?), and engineering (how do we squeeze more capability from fixed resources?).

Rich Sutton's "The Bitter Lesson" frames the philosophical stakes: methods that leverage raw computation consistently beat methods that encode human knowledge — but only if we know *how* to convert compute into capability efficiently. Scaling without efficiency is brute force. Efficiency without scaling plateaus early. The problem is finding the frontier where both meet.

## Why This Is Hard

- **Power-law returns diminish.** Loss scales as a power law with compute (L ∝ C^(-0.050)), model size (L ∝ N^(-0.076)), and data (L ∝ D^(-0.095)) — meaning each additional unit of improvement costs more than the last. Going from good to great can cost orders of magnitude more than going from bad to good.
- **Three-way bottleneck tradeoff.** You can be bottlenecked by model size, dataset size, or compute simultaneously. The optimal balance (per Kaplan et al.) is not intuitive: for a fixed compute budget, train very large models on relatively little data and stop far short of convergence.
- **Architecture matters surprisingly little — except when it matters.** Kaplan found that varying depth by 40× or width/depth ratios changed loss by <3%. Yet LLaMA's architectural improvements (pre-normalization, SwiGLU, rotary embeddings) delivered GPT-3-level performance at 1/10th the parameters.
- **Predictability gaps.** Scaling laws can predict final loss from small-model runs, but *capability emergence* (in-context learning, reasoning, tool use) is harder to forecast. GPT-4's report shows some benchmarks follow power laws while others show discontinuous jumps.
- **The open/closed divide.** GPT-4 is closed-source with undisclosed architecture and training details, making it impossible to independently study where its efficiency gains come from. LLaMA opened the door but the gap remains.
- **Inference cost is the hidden tax.** Smaller models that train longer on more data (LLaMA's approach: 1.4T tokens) are cheaper to serve even if training costs are comparable. This flips the Kaplan-era wisdom about training budget optimality.

## Approaches Tried

| Paper | Year | Approach | What Worked | What Didn't |
|-------|------|----------|-------------|-------------|
| Scaling Laws (Kaplan et al.) | 2020 | Empirical power-law fits across 7+ orders of magnitude in N, D, C | Clean power laws for loss prediction; architectural details barely matter; larger models are more sample-efficient | Didn't account for data quality; "compute-optimal" regime (D ~ C^0.27) later challenged by Chinchilla; can't predict capability emergence |
| GPT-3 (Brown et al.) | 2020 | 175B-parameter autoregressive LM, in-context few-shot learning | Emergent few-shot capability at scale; strong zero/one/few-shot without fine-tuning; proved the scaling hypothesis | 175B is expensive to serve; struggles on NLI and reading comprehension; data contamination from web crawl; sparse attention didn't fully solve context scaling |
| GPT-4 (OpenAI) | 2023 | Even larger multimodal model + RLHF alignment | Loss prediction from 1/1000th compute; top-10% bar exam; strong multilingual transfer; predictable scaling for some capabilities | Closed-source prevents independent study; some capabilities show inverse scaling; calibration degrades after RLHF; still hallucinates and has biases |
| LLaMA (Touvron et al.) | 2023 | Open models (7B-65B) trained on 1-1.4T public tokens; architectural improvements | 13B beats GPT-3 (175B) on most benchmarks; 65B competitive with Chinchilla-70B and PaLM-540B; runs on single GPU; training on more tokens yields better inference efficiency | Challenged Kaplan/Chinchilla "compute-optimal" regime — optimizing for inference cost may mean smaller models + more data; still far from GPT-4 capabilities |
| The Bitter Lesson (Sutton) | 2019 | Philosophical argument: general methods + compute beat domain knowledge in the long run | Correctly predicted that scaling + general methods (search, learning) would dominate over handcrafted features in chess, Go, speech, vision | Not an engineering solution; doesn't specify *how* to allocate compute; undervalues the role of clever architecture choices in enabling efficient scaling |

## Current Frontier

- **The Chinchilla revision.** DeepMind's Chinchilla (2022, not yet in GOSK) showed Kaplan's compute-optimal recommendation was wrong — optimal training uses equal scaling of model size and data. This shifted the field toward data-rich training with smaller models. LLaMA and subsequent open models follow this philosophy.
- **Inference-time compute.** The frontier is shifting from "how much to spend on training" to "how to spend compute at inference." Chain-of-thought, tree-of-thought, and tool-use are all ways to buy capability with inference FLOPs rather than parameter count.
- **MoE (Mixture of Experts).** Sparse activation lets models grow parameter count without proportional compute cost. GPT-4 is rumored to use MoE. This breaks the simple N/D/C scaling framework.
- **What remains unsolved:** Predicting *which* capabilities will emerge at what scale. Why does in-context learning appear suddenly? How much bigger do models need to be for robust reasoning, planning, and agency? Can we get GPT-4-level capability at a fraction of the cost? The scaling frontier has moved from "does bigger mean better?" to "how do we make better *cheaper*?"

## Cross-References

- [[maps/lineage/language-model-scaling]] — The lineage from scaling laws through GPT-3, Chinchilla, GPT-4, and LLaMA
- [[maps/lineage/transformer-architecture]] — Architectural innovations (attention, normalization, positional encoding) that enable efficient scaling
- [[maps/concepts/power-laws]] — The mathematical structure underlying scaling phenomena
- [[maps/problems/representation-learning]] — Efficient representation learning is what scaling ultimately pays for
