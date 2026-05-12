---
source_url: https://arxiv.org/abs/1312.5602
ingested: 2026-05-12
---

# Playing Atari with Deep Reinforcement Learning

**Authors:** Volodymyr Mnih, Koray Kavukcuoglu, David Silver, Alex Graves, Ioannis Antonoglou, Daan Wierstra, Martin Riedmiller (DeepMind Technologies)

**Source:** arXiv:1312.5602v1 [cs.LG] (19 Dec 2013), NIPS Deep Learning Workshop 2013

## Abstract

> "We present the first deep learning model to successfully learn control policies directly from high-dimensional sensory input using reinforcement learning. The model is a convolutional neural network, trained with a variant of Q-learning, whose input is raw pixels and whose output is a value function estimating future rewards."

The method (DQN) outperforms all previous approaches on six out of seven Atari 2600 games and surpasses a human expert on three games.

## Key Challenges for Deep RL
- Sparse, noisy, and delayed rewards (unlike supervised learning with fixed targets)
- Strong correlation between consecutive states (violates i.i.d. assumption of most deep learning algorithms)
- Non-stationary data distribution as the agent learns new behaviours

## Approach
Use a **convolutional neural network** trained with **Q-learning** and an **experience replay mechanism** to break correlations and smooth the training distribution.

**Goal:** One single network, no game-specific information or hand-crafted features – only raw pixels, reward, terminal signals, and legal actions.

## Background

### Q-Learning
The optimal action-value function Q*(s,a) is the maximum expected return achievable by following any policy after seeing sequence s and taking action a. Bellman equation:

Q*(s,a) = E_{s'~E}[ r + γ max_{a'} Q*(s',a') | s,a ]

A Q-network with parameters θ approximates Q(s,a;θ) ≈ Q*(s,a). Trained by minimizing squared TD error. This is **model-free** and **off-policy** (learns about greedy policy while following ε-greedy behaviour policy).

## Deep Reinforcement Learning

### Experience Replay
Store transitions e_t = (s_t, a_t, r_t, s_{t+1}) in replay memory D (capacity N). During learning, sample random minibatches from D and apply Q-learning updates.

**Advantages:**
- Greater data efficiency (each transition used multiple times)
- Breaks correlations between consecutive samples (reduces variance)
- Smooths behaviour distribution over past states (avoids oscillations/divergence)

### Preprocessing
- Raw Atari frames (210×160 RGB) → grayscale → downsampled to 110×84 → cropped to 84×84
- Stack last 4 frames as input (84×84×4)
- Frame skipping: action repeated for k=4 frames
- Reward clipping: all positive rewards = 1, negative = -1, zero = 0

### Architecture
- Input: 84×84×4
- Conv1: 32 filters 8×8 stride 4, ReLU
- Conv2: 64 filters 4×4 stride 2, ReLU
- Conv3: 64 filters 3×3 stride 1, ReLU
- FC: 512 units, ReLU
- Output: Q-value for each action (4-18 depending on game)

### Training Details
- Replay memory size: 1M transitions
- ε-greedy: ε annealed linearly from 1.0 to 0.1 over first 1M frames, fixed at 0.1 after
- Minibatch size: 32
- Discount γ = 0.99
- RMSProp optimizer, learning rate 0.00025
- Trained for 10M frames per game

## Results
Outperforms all previous RL approaches on 6/7 Atari 2600 games (Breakout, Enduro, Pong, Q*bert, Seaquest, Space Invaders). Surpasses human expert on 3 games (Breakout, Enduro, Pong). No positive transfer on River Raid (helicopter control game with sparse rewards).

## Significance
DQN was the breakthrough that launched modern deep reinforcement learning. It showed that a single architecture could learn to play diverse games directly from pixels using only reward signals, without game-specific engineering. Experience replay solved the catastrophic instability that had plagued neural network function approximation in RL.
