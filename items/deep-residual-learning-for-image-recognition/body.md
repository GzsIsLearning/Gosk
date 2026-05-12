---
source_url: https://arxiv.org/abs/1512.03385
ingested: 2026-05-12
---

# Deep Residual Learning for Image Recognition

**Authors:** Kaiming He, Xiangyu Zhang, Shaoqing Ren, Jian Sun (Microsoft Research)
**Paper:** arXiv:1512.03385 (2015)

---

## Abstract

We present a residual learning framework to ease the training of networks that are substantially deeper than those used previously. On the ImageNet dataset we evaluate residual nets with a depth of up to 152 layers—8× deeper than VGG nets but still having lower complexity. An ensemble of these residual nets achieves 3.57% error on the ImageNet test set. This result won the 1st place on the ILSVRC 2015 classification task.

- **Key result:** 28% relative improvement on COCO object detection solely due to deep representations.
- Also won 1st places on ImageNet detection, ImageNet localization, COCO detection, COCO segmentation.

---

## 1. Introduction: The Degradation Problem

- Deeper networks should not have higher training error (since a shallow network can be embedded in a deeper one with identity layers).
- **Observed:** 56-layer plain network has higher training error than 20-layer plain network. This is not due to vanishing gradients (BN helps) but an optimization difficulty.
- **Solution:** Reformulate layers to learn residual functions F(x) := H(x) - x instead of H(x). The original mapping becomes F(x) + x.

"If an identity mapping were optimal, it would be easier to push the residual to zero than to fit an identity mapping by a stack of nonlinear layers."

- Residual blocks implemented via identity shortcut connections that add neither extra parameters nor computational complexity.

---

## 2. Deep Residual Learning

### 2.1 Residual Learning
Instead of hoping stacked layers directly fit H(x), let them fit F(x) = H(x) - x. Easier optimization because identity mapping provides good preconditioning.

### 2.2 Identity Mapping by Shortcuts
Building block definition: y = F(x, {Wi}) + x
- F is the residual mapping (e.g., two or three convolutional layers).
- If dimensions differ, use linear projection Ws: y = F(x, {Wi}) + Ws x
- Parameter-free identity shortcuts are sufficient for addressing degradation.

### 2.3 Network Architectures
Design rules (inspired by VGG):
- 3×3 filters; same output size → same # filters; halve feature map → double filters.
- Downsampling via conv with stride 2; end with global average pooling + softmax.

50/101/152-layer use bottleneck blocks (1×1 → 3×3 → 1×1) for efficiency.

---

## 3. ImageNet Classification Results

- **Degradation reversed:** 34-layer ResNet outperforms 18-layer ResNet by 2.8%.
- 152-layer ResNet has lower complexity than VGG-16/19 (11.3 vs 15.3/19.6 GFLOPs).
- Single-model top-5 validation error of 4.49%.
- **Ensemble of 6 models → 3.57% top-5 error** on ImageNet test set (ILSVRC 2015 winner).

---

## 4. CIFAR-10 Results

| Model | Error (%) |
|-------|-----------|
| ResNet-20 | 8.75 |
| ResNet-32 | 7.51 |
| ResNet-44 | 7.17 |
| ResNet-56 | 6.97 |
| ResNet-110 | 6.43 |

Layer responses show that residual networks have smaller response amplitudes, suggesting smoother function representations.

---

## Significance

ResNet introduced skip connections and residual learning, enabling training of very deep networks (100+ layers). It won ILSVRC 2015 and became a foundational architecture for computer vision, influencing countless subsequent models.
