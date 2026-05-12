---
title: Generative Models Evolution
created: 2026-05-12
updated: 2026-05-12
type: lineage
tags: [generative-models, vae, gan, diffusion, image-generation]
sources:
  - items/auto-encoding-variational-bayes
  - items/generative-adversarial-nets
  - items/denoising-diffusion-probabilistic-models
---

## Overview

Generative modeling underwent a paradigm shift between 2013 and 2020: from variational inference (VAE) through adversarial training (GAN) to score-based diffusion. Each framework introduced a fundamentally different approach to sampling from complex data distributions, with diffusion ultimately enabling the highest-fidelity image and video generation.

## Evolution Timeline

```
2013 ──► VAE (Kingma & Welling) ── "Auto-Encoding Variational Bayes"
 │           Latent variable model with reparameterization trick
 │           Learns smooth, continuous latent space; principled ELBO objective
 │
2014 ──► GAN (Goodfellow et al.) ── "Generative Adversarial Nets"
 │           Generator vs. discriminator minimax game
 │           Produces sharp samples but suffers from mode collapse, instability
 │
2015 ──► DCGAN ── stable deep convolutional GANs
 │         Conditional GAN, InfoGAN, etc. ── controlled generation
 │
2016 ──► Improved GAN training techniques (WGAN, LSGAN, etc.)
 │
2017 ──► CycleGAN, pix2pix ── image-to-image translation
 │         Progressive GAN (Karras) ── high-res face generation
 │         VAE+GAN hybrids (VAE-GAN, VQ-VAE)
 │
2018 ──► BigGAN ── large-scale class-conditional generation
 │         StyleGAN (Karras) ── style-based generator; disentangled latent space
 │
2019 ──► StyleGAN2 ── fixing artifacts; path length regularization
 │         NCSN (Song & Ermon) ── noise-conditioned score network (diffusion precursor)
 │
2020 ──► DDPM (Ho et al.) ── "Denoising Diffusion Probabilistic Models"
 │           Iterative denoising with Markov chain; high-quality samples
 │           Simpler training than GANs; no adversarial instability
 │
2021+──► Diffusion explosion ── Latent Diffusion (Stable Diffusion), DALL-E 2, Imagen
 │
2022+──► Diffusion + Transformers (DiT, Sora) ── scalable architectures for diffusion
```

## Key Works

| Paper/Post | Year | Authors | Core Innovation | Impact |
|------------|------|---------|-----------------|--------|
| Auto-Encoding Variational Bayes (VAE) | 2013 | Kingma & Welling | Latent variable generative model with the reparameterization trick. Optimizes the Evidence Lower Bound (ELBO). | Principled probabilistic generative modeling; smooth, interpolatable latent spaces |
| Generative Adversarial Nets (GAN) | 2014 | Goodfellow et al. | Adversarial training: generator network vs discriminator network in a minimax game. | Produced the sharpest images of its era; spawned thousands of GAN variants across domains |
| Denoising Diffusion Probabilistic Models (DDPM) | 2020 | Ho et al. | Forward diffusion process (add Gaussian noise) + learned reverse denoising process. Markov chain of latent variables. | Replaced GANs as the default image generation method; foundation for DALL-E 2, Stable Diffusion, Sora |

## Cross-References

- [[maps/concepts/latent-space]] — VAE's smooth latent space vs GAN's implicit one
- [[maps/concepts/adversarial-training]] — GAN's core mechanism and its stability challenges
- [[maps/concepts/diffusion]] — forward/reverse process and score matching
- [[maps/lineage/transformer-evolution]] — Transformers eventually fused with diffusion (DiT, Sora)
- [[maps/lineage/learning-paradigms]] — deep architectures (ResNet) enabled scalable generative models
- [[maps/problems/mode-collapse]] — GAN stability issues that diffusion solved
- [[maps/problems/sample-quality]] — fidelity metrics (FID, IS) across generative paradigms
