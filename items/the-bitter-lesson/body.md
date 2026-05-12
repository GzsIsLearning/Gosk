---
source_url: http://www.incompleteideas.net/IncIdeas/BitterLesson.html
ingested: 2026-05-12
---

# The Bitter Lesson

**Author:** Rich Sutton | **Date:** March 13, 2019 | **Source:** [incompleteideas.net](http://www.incompleteideas.net/IncIdeas/BitterLesson.html)

## Core Thesis

> *"The biggest lesson that can be read from 70 years of AI research is that general methods that leverage computation are ultimately the most effective, and by a large margin."*

- **Why it works:** Moore's law → continued exponential decrease in computation cost.
- **Short-term vs. long-term:** Researchers focus on leveraging human knowledge (short-term gains), but **only computation scaling matters in the long run**.
- **The conflict:** Time spent on human-knowledge approaches complicates methods and makes them less suited to leverage computation.
- **The bitter lesson:** *"Building in how we think we think does not work in the long run."*

## Historical Examples (Pattern Repeated Every ~20 Years)

### 1. Computer Chess (1997)
- **Human-knowledge approach:** Researchers tried to encode chess-specific structure.
- **Winner:** Massive deep search + special hardware/software (brute force).
- **Reaction:** Human-knowledge researchers dismissed it ("not how people play"), but the simpler, search-based approach won.

### 2. Computer Go (delayed ~20 years)
- **Initial efforts:** Avoid search by leveraging human knowledge and game-specific features.
- **Breakthrough:** Effective search at scale + self-play learning (value function).
- **Key insight:** *"Search and learning are the two most important classes of techniques for utilizing massive amounts of computation in AI research."*

### 3. Speech Recognition (1970s DARPA competition onward)
- **Human-knowledge entrants:** Knowledge of words, phonemes, vocal tract, etc.
- **Winner:** Statistical methods (HMMs) with more computation.
- **Evolution:** Statistics/computation dominated NLP, culminating in deep learning (even less human knowledge, more computation, large training sets).
- **Result:** *"A colossal waste of researcher's time"* when massive computation became available and was put to good use.

### 4. Computer Vision
- **Early methods:** Edges, generalized cylinders, SIFT features.
- **Today:** Deep learning neural networks (only convolution + invariances) – **all earlier hand-crafted features discarded.**

## The Bitter Lesson: 4 Historical Observations

1. **Researchers often try to build knowledge into agents** (intuitive, personally satisfying).
2. **This always helps in the short term.**
3. **In the long run it plateaus and inhibits further progress.**
4. **Breakthrough progress eventually comes from an opposing approach:** scaling computation by search and learning.

> *"The eventual success is tinged with bitterness, and often incompletely digested, because it is success over a favored, human-centric approach."*

## Two General Principles

### 1. Power of General Purpose Methods
- Methods that **continue to scale with increased computation** (even when computation becomes enormous).
- The two methods that scale arbitrarily: **search** and **learning**.

### 2. Stop Building in the Complexity of Minds
> *"The actual contents of minds are tremendously, irredeemably complex; we should stop trying to find simple ways to think about the contents of minds, such as simple ways to think about space, objects, multiple agents, or symmetries."*

- **Why:** The outside world is arbitrary and intrinsically complex – its complexity is endless.
- **What to build instead:** Only the **meta-methods** that can find and capture that arbitrary complexity.
- **Key goal:** *"We want AI agents that can discover like we can, not which contain what we have discovered."*
- **Warning:** *"Building in our discoveries only makes it harder to see how the discovering process can be done."*

## Takeaway

- Avoid the temptation to encode human knowledge directly.
- Invest in general methods (search, learning) that scale with computation.
- Let AI discover structure itself – don't handcraft it.
