---
source_url: https://karpathy.github.io/2015/05/21/rnn-effectiveness/
ingested: 2026-05-12
---

# The Unreasonable Effectiveness of Recurrent Neural Networks

**Author:** Andrej Karpathy | **Date:** May 21, 2015 | **Source:** [karpathy.github.io](https://karpathy.github.io/2015/05/21/rnn-effectiveness/)

## Overview

RNNs demonstrate remarkable capability to model sequential data, generating surprisingly coherent text character-by-character. This post explores their "magical" effectiveness through practical examples and visualizations.

## Key Concepts

### RNN vs Vanilla Neural Networks
- **Fixed networks:** Fixed-size input → fixed-size output with fixed computational steps
- **RNNs:** Operate over sequences of vectors (input, output, or both)
- **Core advantage:** No pre-specified constraints on sequence lengths

### RNN API & Implementation

```python
class RNN:
    def step(self, x):
        # update the hidden state
        self.h = np.tanh(np.dot(self.W_hh, self.h) + np.dot(self.W_xh, x))
        # compute the output vector
        y = np.dot(self.W_hy, self.h)
        return y
```

**Key insight:** *"If training vanilla neural nets is optimization over functions, training recurrent nets is optimization over programs."*

## Character-Level Language Models

### Training Process
1. Encode characters using 1-of-k encoding
2. Feed characters sequentially via `step` function
3. Observe output confidence distributions
4. Use backpropagation to adjust weights
5. Repeat until predictions align with training data

### Test-Time Generation
- Feed character → get distribution → sample next character → repeat
- **Temperature parameter:** Controls randomness (0.5 = conservative, 1.0 = balanced, >1.0 = diverse)

## Experimental Results

### 1. Paul Graham Essays (1MB)
- **Model:** 2-layer LSTM, 512 hidden nodes, 3.5M parameters
- **Training:** 0.46s/batch on TITAN Z GPU
- **Result:** Coherent startup advice with proper punctuation

> *"The surprised in investors weren't going to raise money... The model learns to support its own arguments ([2])"*

### 2. Shakespeare (4.4MB)
- **Model:** 3-layer RNN, 512 hidden nodes/layer
- **Result:** Plausible Shakespearean dialogue with proper speaker names

```
PANDARUS: Alas, I think he shall be come approached and the day
When little srain would be attain'd into being never fed...
```

### 3. Wikipedia (96MB)
- **Result:** Valid markdown, fake URLs, proper XML structure
- **Notable:** Correctly opens/closes brackets, creates headings/lists

### 4. Algebraic Geometry LaTeX (16MB)
- **Result:** Almost-compilable LaTeX with plausible math
- **Issues:** Mismatched `\begin{proof}` with `\end{lemma}`, missing closures

### 5. Linux Source Code (474MB)
- **Model:** 3-layer LSTM, ~10M parameters
- **Result:** Realistic C code with comments, proper syntax
- **Common errors:** Undefined variables, unmatched returns, vacuous comparisons

### 6. Baby Names (8,000 names)
**Generated examples:** Rudi Levette, Berice Lussa, Hany Mareanne, Chrestina Carissy

## Training Evolution Visualization

**War and Peace training progression:**
- **100 iterations:** Random jumbles with emerging word spacing
- **300 iterations:** Quotes and periods appear
- **500 iterations:** Short words learned ("we", "He", "and")
- **700 iterations:** Longer words, English-like structure
- **1200 iterations:** Proper punctuation, longer words
- **2000 iterations:** Correct spelling, quotations, names

## Neuron Visualization Insights

**Specialized neurons discovered:**
1. **URL detector:** Activates inside URLs, deactivates outside
2. **Markdown bracket counter:** Activates after second `[` in `[[`
3. **Position tracker:** Linear activation across `[[ ]]` scope
4. **www counter:** Deactivates after first "w" in "www"

> *"We didn't have to hardcode... that it might be useful to keep track of whether you're inside quotes. The LSTM decided this is useful."*

## Technical Implementation

**Code availability:** [char-rnn on GitHub](https://github.com/karpathy/char-rnn) (Torch/Lua)

**Framework requirements (Karpathy's criteria):**
1. CPU/GPU transparent Tensor library
2. Separate scripting language codebase
3. Easy pretrained model sharing
4. No compilation step

**Recommended alternatives:** Keras/Passage (Theano), raw numpy gist

## Research Directions & Applications

### Natural Language Processing
- Speech-to-text transcription
- Machine translation
- Handwritten text generation
- Language modeling (character & word level)

### Computer Vision
- Video classification
- Image captioning
- Video captioning
- Visual question answering
- **Key paper:** Recurrent Models of Visual Attention

### Advanced Architectures
- **Neural Turing Machines:** External memory + attention
- **Soft attention:** Fully-differentiable but inefficient
- **Hard attention:** Sample-based, efficient, non-differentiable (requires RL)

> *"The concept of attention is the most interesting recent architectural innovation in neural networks."*

## Key Takeaways

1. **RNNs excel at sequence modeling** without fixed length constraints
2. **Character-level language models** capture structure across diverse domains
3. **LSTM neurons** self-organize into interpretable features (quotes, URLs, brackets)
4. **Attention mechanisms** represent the next frontier beyond pure recurrence
5. **Scaling compute** enables increasingly impressive generative capabilities
