---
title: Model Evaluation
created: 2026-05-12
updated: 2026-05-12
type: problem
tags: [evaluation, benchmarking, comparison, metrics, fair-comparison, scaling, emergence]
sources:
  - items/language-models-are-few-shot-learners
  - items/gpt-4-technical-report
  - items/scaling-laws-for-neural-language-models
  - items/llama-open-and-efficient-foundation-language-models
  - items/bert-pretraining-of-deep-bidirectional-transformers
  - items/clip-transferable-visual-models
---

## Problem Definition

How do we fairly compare the capabilities of large language models and other foundation models when they differ in scale, architecture, training data, compute budget, and reporting methodology? The evaluation problem has become one of the central challenges of modern AI research: without reliable comparisons, we cannot determine which approaches are truly advancing the field.

Key dimensions of the problem:
1. **Heterogeneous benchmarks:** Each model reports on a different set of evaluations. GPT-3 reports LAMBADA, TriviaQA, HellaSwag. GPT-4 reports MMLU, bar exam, HumanEval. LLaMA reports BoolQ, PIQA, GSM8k. Direct cross-comparison requires finding overlapping benchmarks — and many are available only in specific formats (e.g., GPT-4's bar exam score).
2. **Methodological inconsistency:** GPT-3 uses few-shot (k demonstrations in context). GPT-4 uses few-shot and zero-shot. BERT uses fine-tuning. CLIP uses zero-shot. LLaMA uses few-shot. Each approach gives different results on the same task, making apples-to-apples comparison nearly impossible.
3. **Score saturation and contamination.** Many datasets (e.g., SQuAD, GLUE) have been saturated by successive models. Data contamination — the presence of benchmark data in training corpora — makes scores unreliable. GPT-3 explicitly warned about this.
4. **What to measure?** Loss (perplexity) is the fundamental scaling metric but doesn't directly measure capability. Benchmarks measure capabilities but are task-specific and saturable. Emergent abilities (in-context learning, reasoning, tool use) are hard to benchmark before they've been observed.

## Why This Is Hard

- **Benchmark contamination is rampant.** Web-crawled training data inevitably includes test sets from popular benchmarks. GPT-3's authors identified this issue: "Our training data includes a copy of the test sets for some of the tasks we evaluate on." Deduplication helps but is not perfect. This inflates reported scores and makes historical comparisons unreliable.

- **Evaluation setup dramatically changes results.** GPT-3 showed performance varies by 5-10% depending on prompt phrasing, number of examples, and example ordering. CLIP showed prompt ensembling (multiple text templates) improves zero-shot classification by 5%. These implementation details are often underreported.

- **Scale makes comparison harder.** How do you compare a 7B model trained for 1T tokens (LLaMA-7B) against a 175B model trained for 300B tokens (GPT-3)? Is it fair to compare loss (favoring GPT-3) or capability-per-parameter (favoring LLaMA)? The answer depends on whether you care about training cost, inference cost, or absolute capability.

- **Closed-source evaluation cannot be independently verified.** GPT-4's technical report provides scores on academic and professional exams but with undisclosed architecture, training data, and compute. Independent researchers cannot reproduce these numbers. This creates an asymmetry between open and closed models — open models can be scrutinized, closed models are taken on faith.

- **Capability is multi-dimensional.** A model that excels at math (GPT-4, scoring 86.4% on MMLU) may struggle at truthfulness (LLaMA-65B outperforms GPT-3 on some QA benchmarks while trailing on others). What does it mean to "compare" two models across disparate capability dimensions without a unified aggregation method?

## Evidence from GOSK Items

| Paper/Work | Year | What They Report | What They Don't / Evaluation Issues |
|------------|------|------------------|-------------------------------------|
| BERT (Devlin et al.) | 2018 | 11 NLP tasks (GLUE, SQuAD, SWAG, etc.) via fine-tuning. GLUE: 80.5% (7.7% absolute improvement). | Fixed fine-tuning protocol; later work (RoBERTa) showed BERT was undertrained. NSP task later shown unnecessary. Static masking limits comparability. |
| GPT-3 (Brown et al.) | 2020 | 42+ tasks in zero/few/one-shot settings. LAMBADA: 86.4% few-shot. TriviaQA: 71.2% few-shot. | Data contamination acknowledged but not quantified. Prompt sensitivity not explored systematically. No fine-tuning results; only in-context learning. 175B model compared against fine-tuned SOTA baselines — apples to oranges. |
| Scaling Laws (Kaplan et al.) | 2020 | Cross-entropy loss across 7+ orders of compute. Smooth power-law fits. | Loss is a proxy for capability, not capability itself. Does not predict which tasks improve with scale. Architecture variation <3% on loss but may matter more for specific capabilities. |
| CLIP (Radford et al.) | 2021 | Zero-shot on 27 datasets via prompt-based classification. ImageNet 76.2% zero-shot. Robustness across 7 distribution shifts. | Prompt engineering and ensembling needed for best results (5% improvement with ensembling over single prompt). Comparison against fully supervised baselines (ResNet-50 trained on ImageNet) is asymmetric: CLIP uses 400M pairs, ResNet uses 1.28M labeled images. |
| GPT-4 (OpenAI) | 2023 | Human-level on many exams: bar exam (90th percentile), MMLU 86.4%, LSAT 163 (88th percentile). | Closed-source — cannot be independently verified. Training data composition unknown. Benchmark contamination possible (test sets may be in training data). RLHF post-training changes scores — model reported is not the raw pretrained checkpoint. Some tasks show inverse scaling. |
| LLaMA (Touvron et al.) | 2023 | 20+ benchmarks in few-shot and zero-shot. LLaMA-13B surpasses GPT-3 175B on most commonsense reasoning benchmarks. | Open weights enable reproducibility — but evaluation protocol details (prompt formatting, number of shots) can significantly affect results. Using public data only, avoids GPT-3's data quality advantage. Some benchmarks (HumanEval, GSM8k) still show GPT-3/PaLM lead. |

## Approaches Tried

### 1. Comprehensive Benchmark Suites
GLUE/SuperGLUE (NLP), MMLU (knowledge), HELM (holistic), BIG-bench (emergent abilities), HumanEval (code).
- **Worked:** Standardized evaluation; enables cross-model comparison on shared tasks. HELM provides multi-metric evaluation (accuracy, calibration, robustness, fairness, efficiency).
- **Problem:** Suites are non-static — models can be tuned to them; contamination risk increases over time. Each suite covers a limited slice of capability.

### 2. In-Context Learning as Evaluation
GPT-3/LLaMA use few-shot prompts without fine-tuning. This provides a consistent evaluation protocol across model scales (same prompts, same tasks).
- **Worked:** Enables fair comparison across models of different sizes without task-specific tuning. Reveals scaling trends cleanly.
- **Problem:** In-context learning capability itself is emergent — small models cannot do it reliably. Prompt sensitivity makes results brittle across labs.

### 3. Loss-Based Evaluation
Scaling Laws use cross-entropy loss as a universal metric, agnostic to downstream tasks.
- **Worked:** Smooth, predictable, highly reproducible. Enables compute-optimal training decisions. Correlates with downstream performance in aggregate.
- **Problem:** Loss doesn't measure specific capabilities. Two models with identical loss can have wildly different downstream performance (LLaMA-13B vs GPT-3 175B show this). Does not capture safety, factuality, or alignment.

### 4. Human Evaluation
GPT-3 evaluates 346 comparisons of GPT-3 articles vs. human-written articles using human judges. GPT-4 uses domain experts for safety testing.
- **Worked:** Captures holistic quality that automated metrics miss (fluency, coherence, persuasiveness).
- **Problem:** Expensive, subjective, hard to reproduce across labs. Human preferences change over time and across communities. Not scalable for routine model comparisons.

## Current Frontier

- **Decontamination is becoming standard.** Future benchmarks (e.g., HELM) use contamination checks and canary strings. But the arms race between data collection and decontamination continues.
- **Emergent abilities demand new benchmarks.** BIG-bench (2022) catalogued 200+ tasks at multiple scales. But the concept of "emergence" itself is debated — may be an artifact of metric choice.
- **Multi-dimensional evaluation.** A single score is insufficient. HELM's approach (accuracy, calibration, robustness, fairness, efficiency, etc.) is more realistic but harder to aggregate. What tradeoffs are acceptable?
- **The open/closed evaluation divide.** Open models can be independently tested, audited, and reproduced. Closed models (GPT-4) report what they choose. As proprietary models lead in capability, the community's ability to evaluate them fairly degrades.
- **What remains unsolved:** Can we design evaluation methods that are (1) contamination-proof, (2) comparable across training methodologies, (3) predictive of real-world deployment performance, and (4) accessible to independent researchers? Can we move beyond benchmark chasing to capability-based evaluation? How do we evaluate models that are too large for most labs to run?

## Cross-References

- [[maps/concepts/scaling-behavior]] — loss-based evaluation vs. capability evaluation
- [[maps/lineage/transformer-evolution]] — the trajectory of model development and how each generation changed the evaluation bar
- [[maps/problems/compute-scaling]] — the relationship between compute cost and evaluation methodology
- [[maps/concepts/self-supervised-learning]] — how SSL objectives define what "good performance" means in different evaluation contexts
- [[maps/concepts/pretraining-and-transfer]] — the shift from fine-tuning (BERT) to in-context learning (GPT-3) changes what constitutes a fair eval
