---
title: Generative Modeling
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [generative, vae, gan, diffusion, latent-variables, adversarial-training, score-matching]
sources: [items/auto-encoding-variational-bayes, items/generative-adversarial-nets, items/denoising-diffusion-probabilistic-models]
---

## Definition

Generative modeling is the task of learning the underlying probability distribution p_data(x) of observed data, enabling the synthesis of new samples x ~ p_model(x) that resemble real data. Unlike discriminative models (which learn p(y|x)), generative models capture the full joint distribution or data density, making them capable of generation, density estimation, representation learning, and probabilistic inference. Three major paradigm-defining approaches emerged in the deep learning era: Variational Autoencoders (VAEs), which optimize a variational lower bound on the data likelihood in a latent variable framework; Generative Adversarial Networks (GANs), which pose generation as a minimax game between a generator and a discriminator; and Denoising Diffusion Probabilistic Models (DDPMs), which learn to reverse a gradual noising process via iterative denoising.

## Why It Matters

Generative modeling is one of the oldest and hardest problems in machine learning — "what I cannot create, I do not understand." Success in generation demonstrates deep understanding of data structure. Beyond sample synthesis, generative models enable semi-supervised learning, representation learning (through latent variables), data augmentation, anomaly detection, and form the backbone of modern text-to-image, text-to-video, and text-to-audio systems. The three paradigms — VAE, GAN, Diffusion — each illuminated different tradeoffs: likelihood-based rigor vs. sample quality vs. sampling speed, driving architectural innovation across all of deep learning.

## Where It Appears

| Paper | Year | How It's Used | Key Insight |
|-------|------|---------------|-------------|
| Auto-Encoding Variational Bayes | 2013 | Latent variable model with variational lower bound (ELBO). Encoder q_φ(z\|x) approximates posterior; decoder p_θ(x\|z) reconstructs. Reparameterization trick enables gradient-based training. | Reparameterization makes intractable probabilistic inference trainable via SGD: z = μ + σε, ε ~ N(0,I) |
| Generative Adversarial Nets | 2014 | Adversarial training: Generator G maps noise z to data space; Discriminator D distinguishes real vs. fake. Minimax objective: min_G max_D E[log D(x)] + E[log(1-D(G(z)))] | Learning without explicit likelihood — the minimax game drives p_g → p_data, achieving JSD minimization |
| Denoising Diffusion Probabilistic Models | 2020 | Forward process adds Gaussian noise over T steps; learned reverse process iteratively denoises. Simplified objective: predict noise ε from noisy x_t at timestep t. | L_simple objective (predict noise, not mean) yields better sample quality than optimizing true ELBO. Connection to score matching and Langevin dynamics. |

## Variants and Evolution

**VAE Family (likelihood-based, latent variables):**
- **Standard VAE (2013):** Gaussian prior p(z) = N(0,I), Gaussian posterior q(z|x). ELBO = -KL(q||p) + reconstruction.
- **Reparameterization trick:** The key enabler — express z deterministically as function of noise: z = g_φ(ε, x), ε ~ p(ε). Allows gradient flow through stochastic nodes.
- **KL term:** Analytically computable for Gaussian-Gaussian case: 0.5 Σ(1 + log σ² - μ² - σ²).
- **Limitations:** Tends to produce blurry samples (due to Gaussian likelihood + amortized inference gap).
- **Extensions:** β-VAE (disentangled representations), VQ-VAE (discrete latents), NVAE (hierarchical).

**GAN Family (implicit, adversarial):**
- **Standard GAN (2014):** MLP generator + MLP discriminator. Minimax game with value function V(D,G). At Nash equilibrium: p_g = p_data, D = 1/2 everywhere.
- **Practical trick:** Maximize log D(G(z)) instead of minimizing log(1-D(G(z))) for stronger gradients early in training.
- **Theoretical guarantee:** C(G) = -log 4 + 2 · JSD(p_data || p_g). Global minimum at JSD=0.
- **Limitations:** Training instability (mode collapse, non-convergence). No explicit likelihood.
- **Extensions:** DCGAN (convolutional), WGAN (Wasserstein distance), StyleGAN (style-based), BigGAN (large-scale), CycleGAN (unpaired).

**Diffusion Family (iterative denoising):**
- **DDPM (2020):** T=1000 steps, linear β schedule (1e-4 → 0.02), U-Net with self-attention. Reparameterize to predict noise ε: L_simple = E[||ε - ε_θ(x_t, t)||^2].
- **Forward process:** q(x_t|x_{t-1}) = N(x_t; √(1-β_t) x_{t-1}, β_t I). Closed form: q(x_t|x_0) = N(x_t; √(ᾱ_t) x_0, (1-ᾱ_t) I).
- **Sampling:** Start from x_T ~ N(0,I), iteratively denoise: x_{t-1} = 1/√α_t (x_t - (1-α_t)/√(1-ᾱ_t) ε_θ(x_t, t)) + σ_t z.
- **Connection to score matching:** ε_θ approximates the score function of data distribution perturbed with Gaussian noise.
- **State evolution:** DDPM (2020) → Improved DDPM (2021) → Classifier-Free Guidance (2022) → Stable Diffusion (latent space) → SOTA image/video generation.

## Cross-References

- [[maps/lineage/generative-modeling-evolution]] — progression from VAEs through GANs to diffusion models
- [[maps/problems/generative-model-evaluation]] — open question of how to fairly compare generative models (FID, IS, likelihood)
- [[maps/problems/training-stability-gans]] — mode collapse, convergence issues in adversarial training
- [[maps/concepts/attention-mechanisms]] — diffusion models use self-attention in U-Net bottleneck layers
- [[maps/concepts/pretraining-and-transfer]] — CLIP latents as conditioning for modern text-to-image diffusion
