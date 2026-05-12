---
source_url: https://arxiv.org/abs/2006.11239
ingested: 2026-05-12
---

# Denoising Diffusion Probabilistic Models (DDPM)

**Authors:** Jonathan Ho, Ajay Jain, Pieter Abbeel (UC Berkeley)

**Source:** NeurIPS 2020, arXiv:2006.11239
**Code:** https://github.com/hojonathanho/diffusion

## Abstract (Key Result)

> "We present high quality image synthesis results using diffusion probabilistic models. … On unconditional CIFAR10, we obtain an Inception score of 9.46 and a state-of-the-art FID score of 3.17. On 256×256 LSUN, we obtain sample quality similar to ProgressiveGAN."

## Core Contributions

- **First demonstration** that diffusion models can generate high quality images, competitive with GANs.
- **Connection** between diffusion models and denoising score matching + annealed Langevin dynamics.
- **Simplified weighted variational bound** (L_simple) that improves sample quality.
- **Progressive lossy compression** interpretation – natural generalization of autoregressive decoding.
- **State-of-the-art FID** (3.17) on unconditional CIFAR10.

## Method & Key Formulations

### Diffusion Model Definition
- **Forward process** (fixed Markov chain adding Gaussian noise):

  q(x_t|x_{t-1}) = N(x_t; √(1-β_t) x_{t-1}, β_t I)

  Closed form: q(x_t|x_0) = N(x_t; √(ᾱ_t) x_0, (1-ᾱ_t) I)

  with α_t = 1-β_t, ᾱ_t = Π_{s=1}^t α_s.

- **Reverse process** (learned Markov chain):

  p_θ(x_{0:T}) = p(x_T) Π_{t=1}^T p_θ(x_{t-1}|x_t)
  p_θ(x_{t-1}|x_t) = N(x_{t-1}; μ_θ(x_t,t), Σ_θ(x_t,t))

  Prior: p(x_T) = N(0,I)

### Parameterization Trick (Key Insight)
Reparameterize: x_t(x_0, ε) = √(ᾱ_t) x_0 + √(1-ᾱ_t) ε, ε ~ N(0,I)

Predict the noise ε instead of the mean μ̃_t. Leads to simplified training objective:

### Simplified Training Objective (L_simple)
```
L_simple(θ) = E_{t, x_0, ε}[ || ε - ε_θ( √(ᾱ_t) x_0 + √(1-ᾱ_t) ε , t ) ||^2 ]
```
where t ~ Uniform({1,...,T}).

- **Weighted variational bound** – down-weights small t (easy denoising), focuses on larger t.
- Results in **better sample quality** than true ELBO.

## Algorithms

### Training
Repeat: sample x_0, t, ε; take gradient step on || ε - ε_θ(√(ᾱ_t) x_0 + √(1-ᾱ_t) ε, t) ||^2 until converged.

### Sampling (Reverse Process)
Start x_T ~ N(0,I). For t = T,...,1: compute x_{t-1} using learned ε_θ and noise z. Resembles Langevin dynamics with learned gradient ε_θ.

## Experimental Setup
| Parameter | Value |
|-----------|-------|
| T | 1000 |
| β schedule | Linear from β_1=1e-4 to β_T=0.02 |
| Architecture | U-Net backbone (PixelCNN++ style) with group norm, self-attention at 16×16 |
| Time embedding | Transformer sinusoidal position embedding |
| Optimizer | Adam, lr=2e-4 (CIFAR), 2e-5 (256×256) |
| EMA | 0.9999 |
| Batch size | 128 (CIFAR), 64 (256×256) |

## Results

### CIFAR10 – Sample Quality
| Model | IS | FID |
|-------|----|-----|
| BigGAN (conditional) | 9.22 | 14.73 |
| StyleGAN2 + ADA | 10.06 | 2.67 |
| **DDPM (L_simple)** | **9.46** | **3.17** |
| DDPM (L, fixed Σ) | 7.67 | 13.51 |

- FID 3.17: better than most models, including class-conditional ones at the time. Unconditional, no labels.

### Ablation on Parameterization
| Method | IS | FID |
|--------|----|-----|
| Predict μ̃ (baseline) + L | 8.06 | 13.22 |
| Predict ε + L_simple | 9.46 | 3.17 |
| Predict ε + L (fixed Σ) | 7.67 | 13.51 |

- Learning diagonal Σ led to instability. ε prediction + L_simple is best.

### LSUN 256×256 FID
- LSUN Bedroom: 6.36 (4.90 with large model)
- LSUN Church: 7.89
- Comparable to StyleGAN2 baselines.

## Connection to Denoising Score Matching
Optimizing L_simple is equivalent to denoising score matching across multiple noise scales. ε_θ(x_t,t) acts as a learned score function. Sampling = annealed Langevin dynamics.

## Significance
DDPM demonstrated that diffusion models could match or exceed GANs in image quality while offering stable training, mode coverage, and a principled probabilistic formulation. It sparked the diffusion model revolution that would eventually dominate image, video, and audio generation.
