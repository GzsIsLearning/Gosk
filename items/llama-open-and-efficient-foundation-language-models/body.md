---
source_url: https://arxiv.org/abs/2302.13971
ingested: 2026-05-12
---

# LLaMA: Open and Efficient Foundation Language Models

**Authors:** Hugo Touvron, Thibaut Lavril, Gautier Izacard, Xavier Martinet, Marie-Anne Lachaux, Timothee Lacroix, Baptiste Roziere, Naman Goyal, Eric Hambro, Faisal Azhar, Aurelien Rodriguez, Armand Joulin, Edouard Grave, Guillaume Lample

**Affiliation:** Meta AI

## Abstract

LLaMA models (7B, 13B, 33B, 65B parameters) trained exclusively on publicly available data. LLaMA-13B outperforms GPT-3 (175B) on most benchmarks despite being 10× smaller. LLaMA-65B is competitive with Chinchilla-70B and PaLM-540B. Training on more tokens (up to 1.4T) with smaller models yields better inference efficiency — contrary to Chinchilla scaling laws for training budget.

## Architecture

- **Pre-normalization:** RMSNorm applied to input of each sub-layer (not output).
- **Activation:** SwiGLU with dimension 2⅔d instead of 4d.
- **Positional Encoding:** Rotary embeddings (RoPE) at each layer (no absolute positional embeddings).

## Model Sizes

| Params | dim | n_heads | n_layers | lr    | batch | tokens |
|--------|-----|---------|----------|-------|-------|--------|
| 6.7B   | 4096 | 32   | 32       | 3.0e-4 | 4M  | 1.0T   |
| 13.0B  | 5120 | 40   | 40       | 3.0e-4 | 4M  | 1.0T   |
| 32.5B  | 6656 | 52   | 60       | 1.5e-4 | 4M  | 1.4T   |
| 65.2B  | 8192 | 64   | 80       | 1.5e-4 | 4M  | 1.4T   |

## Training Data

Tokenizer: BPE (SentencePiece), numbers split into digits, byte fallback for unknown UTF-8. Data mix: CommonCrawl (67%), C4 (15%), GitHub (4.5%), Wikipedia (4.5%), Gutenberg+Books3 (4.5%), arXiv (2.5%), Stack Exchange (2%).

## Training Efficiency

- AdamW (β1=0.9, β2=0.95), cosine LR, weight decay 0.1, gradient clipping 1.0, warmup 2000 steps.
- xformers causal attention (FlashAttention-style, no storing attention weights).
- Activation checkpointing, model/sequence parallelism, overlapped computation/communication.
- Throughput: ~380 tokens/sec/GPU on 2048 A100-80GB for 65B → ~21 days for 1.4T tokens.

## Key Results

- LLaMA-13B surpasses GPT-3 175B on most common-sense reasoning benchmarks (BoolQ: 78.1 vs 60.5, PIQA: 80.1 vs 81.0, HellaSwag: 79.2 vs 78.9).
- LLaMA-65B beats Chinchilla-70B on all but BoolQ and PaLM-540B on all but BoolQ and WinoGrande.
- NaturalQuestions (64-shot): LLaMA-65B 39.9% vs GPT-3 29.9% vs Chinchilla 35.5%.
- TriviaQA (64-shot): LLaMA-65B 73.0% vs Chinchilla 64.6%.
- MATH: LLaMA-65B 10.6% (no fine-tuning) — with maj1@k: 20.5%.
- GSM8k (maj1@k): LLaMA-65B 69.7% vs Minerva-62B 68.5%.
- HumanEval pass@1: LLaMA-65B 23.7% vs PaLM-540B 26.2%.
- Runs on a single V100 GPU (13B model).
