---
source_url: https://arxiv.org/abs/1406.2661
ingested: 2026-05-12
---

# Generative Adversarial Nets

**Authors:** Ian J. Goodfellow, Jean Pouget-Abadie, Mehdi Mirza, Bing Xu, David Warde-Farley, Sherjil Ozair, Aaron Courville, Yoshua Bengio
**Paper:** arXiv:1406.2661 (2014)

---

## Abstract

We propose a new framework for estimating generative models via an adversarial process, in which we simultaneously train two models: a generative model G that captures the data distribution, and a discriminative model D that estimates the probability that a sample came from the training data rather than G. The training procedure for G is to maximize the probability of D making a mistake. This framework corresponds to a minimax two-player game.

- Unique solution exists (non-parametric limit): G recovers data distribution, D = 1/2 everywhere.
- Both models can be MLPs; trained with backpropagation and dropout.
- No Markov chains or approximate inference needed during training or generation.

---

## 1. Introduction

- Deep learning successes have been mostly discriminative.
- Deep generative models lag due to intractable probabilistic computations.
- **Adversarial nets illustration:** "The generative model can be thought of as analogous to a team of counterfeiters, trying to produce fake currency and use it without detection, while the discriminative model is analogous to the police, trying to detect the counterfeit currency."

---

## 2. Adversarial Nets

- **Generator:** G(z; θ_g) maps noise z ~ p_z(z) to data space.
- **Discriminator:** D(x; θ_d) outputs probability that x is from real data.

### Minimax Game

min_G max_D V(D,G) = E_x~p_data[log D(x)] + E_z~p_z[log(1 - D(G(z)))]

### Training Procedure (Algorithm 1)

```
for number of training iterations do
  for k steps do
    Sample minibatch of m noise samples {z^(1),...,z^(m)} from noise prior p_g(z).
    Sample minibatch of m examples {x^(1),...,x^(m)} from data distribution p_data(x).
    Update the discriminator by ascending its stochastic gradient.
  end for
  Sample minibatch of m noise samples.
  Update the generator by descending its stochastic gradient.
end for
```

**Practical improvement:** Instead of minimizing log(1-D(G(z))), maximize log D(G(z)) for stronger gradients early in learning.

---

## 3. Theoretical Results

### Global Optimality

**Proposition 1:** For fixed G, optimal discriminator is:

D*_G(x) = p_data(x) / (p_data(x) + p_g(x))

**Theorem 1:** The global minimum of C(G) = max_D V(G,D) is achieved iff p_g = p_data. At that point, C(G) = -log 4.

C(G) = -log 4 + 2 · JSD(p_data || p_g)

where JSD is Jensen-Shannon divergence (always ≥ 0, zero only when equal).

---

## 4. Experiments

Datasets: MNIST, Toronto Face Database (TFD), CIFAR-10.

Architecture: Generator uses rectifier linear activations + sigmoid. Discriminator uses maxout activations with dropout.

| Model | MNIST | TFD |
|-------|-------|-----|
| DBN | 138 ± 2 | 1909 ± 66 |
| Stacked CAE | 121 ± 1.6 | 2110 ± 50 |
| Deep GSN | 214 ± 1.1 | 1890 ± 29 |
| **Adversarial nets** | **225 ± 2** | **2057 ± 26** |

---

## Significance

GANs introduced the adversarial training framework, one of the most impactful ideas in generative modeling. This paper sparked an entire research subfield, leading to DCGAN, CycleGAN, StyleGAN, and countless applications in image synthesis, style transfer, and beyond.
