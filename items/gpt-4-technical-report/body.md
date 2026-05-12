---
source_url: https://arxiv.org/abs/2303.08774
ingested: 2026-05-12
---

# GPT-4 Technical Report

**Authors:** OpenAI | **Year:** 2023 | **Source:** [arXiv:2303.08774](https://arxiv.org/abs/2303.08774)

## Overview
GPT-4 is a **large multimodal model** (accepts image and text inputs, outputs text) developed by OpenAI. It exhibits **human-level performance** on many professional and academic benchmarks, e.g., scoring in the **top 10%** on a simulated bar exam (vs. bottom 10% for GPT-3.5).

> "GPT-4 is a Transformer-based model pre-trained to predict the next token in a document. The post-training alignment process results in improved performance on measures of factuality and adherence to desired behavior."

## Predictable Scaling
- **Loss prediction** accurately extrapolated from models using ≤1/1000th of GPT-4's compute.
- **HumanEval pass rate** predicted via power law – accurate except for easiest bucket.
- Some capabilities (e.g., inverse scaling tasks) reverse trends with scale.

> "A power law fit to the smaller models … accurately predicts GPT-4's final loss."

## Capabilities

### Academic & Professional Exams
| Exam | GPT-4 Score | Percentile | vs. GPT-3.5 |
|------|-------------|------------|-------------|
| Uniform Bar Exam | 298/400 | ~90th | ~10th |
| LSAT | 163 | ~88th | ~40th |
| SAT Reading & Writing | 710/800 | ~93rd | ~87th |
| GRE Verbal | 169/170 | ~99th | ~63rd |
| AP Biology | 5 | 85-100th | 4 (62-85th) |
| MMLU | 86.4% (5-shot) | – | 70.0% |

- Outperforms SOTA on most NLP benchmarks (without benchmark-specific tuning).
- Strong **multilingual** performance: on translated MMLU, outperforms English SOTA in 24/26 languages.

### Visual Inputs
- Accepts interlaced text and images.
- Exhibits similar capabilities as text-only (e.g., chart reasoning, meme interpretation, physics diagrams).

### Steering & Alignment
- **RLHF** significantly improves factuality and reduces harmful content.
- **Rule-Based Reward Models (RBRMs)** provide fine-grained safety feedback during training.
- On internal factuality eval: **19 percentage points improvement** over GPT-3.5.

## Limitations
- **Hallucinations**: still present but reduced.
- **Context window** limited; does not learn from experience.
- **Calibration**: pre-trained model well-calibrated; post-training reduces calibration.
- **Biases**: e.g., gender, race stereotypes persist; unequal refusal across demographics.
- **Overreliance**: users may trust outputs too much, especially in domains where they lack expertise.

> "GPT-4 significantly reduces hallucinations relative to previous GPT-3.5 models … scores 19 percentage points higher on internal adversarially-designed factuality evaluations."

## Risks & Mitigations

### Adversarial Testing
- **50+ domain experts** (cybersecurity, biorisk, international security) tested GPT-4-early vs. GPT-4-launch.
- Identified risks: harmful content, disinformation, proliferation of weapons, privacy, cybersecurity, emergent power-seeking behavior.

### Safety Pipeline
- **Model-assisted safety**: GPT-4 used as zero-shot classifier for moderation.
- **Improved refusals**: 82% decrease in responding to disallowed content requests vs. GPT-3.5.
- **Sensitive requests** (e.g., medical advice): 29% more policy-compliant.
- **RealToxicityPrompts**: GPT-4 toxic generations only 0.73% vs. GPT-3.5's 6.48%.

### Jailbreaks
- Still vulnerable to adversarial system messages ("jailbreaks"); mitigations reduce but don't eliminate.

## System Card Highlights
- **Hallucinations**: open-domain improvement of 19%, closed-domain 29%.
- **Harmful content**: GPT-4-early could generate attack planning, hate speech, self-harm advice – GPT-4-launch refuses most.
- **Bias**: examples include gendered assumptions, racial stereotypes in generated jokes/programs.
- **Disinformation**: can produce realistic propaganda; with human editor, rivals human propagandists.
- **Proliferation**: reduces research time for dual-use weapons info, but still often vague or inaccurate.
- **Privacy**: can synthesize public information to identify individuals when combined with outside data.
- **Cybersecurity**: useful for social engineering (phishing) but poor at novel vulnerability exploitation.
- **Emergent risks**: preliminary ARC evaluation found GPT-4 **not yet capable** of autonomous replication/power-seeking.
- **Economic impact**: potential for job automation, inequality, but also productivity gains.

## Conclusion
GPT-4 represents a significant step toward broadly useful and safely deployed AI, but many risks remain. The report emphasizes the need for **anticipatory governance, continued safety research, and layered mitigations** (model-level + system-level).
