---
title: "Diffusion Model 이해하기: VAE, VDM, Latent Diffusion까지 한 번에 연결하기"
date: 2026-05-11
draft: false
description: "Diffusion Model을 처음 공부할 때 헷갈리는 VAE, VDM, DDPM, score, latent diffusion 개념을 수학 비전공자도 따라갈 수 있도록 하나의 흐름으로 정리합니다."
image: ""
tags: ["diffusion-model", "vae", "vdm", "latent-diffusion", "generative-ai"]
categories: ["Deep Learning"]
---

Diffusion Model을 처음 공부하면 이상한 느낌이 듭니다. 이미지를 만들고 싶다면서 왜 먼저 이미지에 노이즈를 넣는지, VAE와 VDM은 이름이 비슷한데 무엇이 다른지, Stable Diffusion에서 말하는 latent는 왜 갑자기 등장하는지 한 번에 연결되지 않습니다. 이 글은 그 혼란을 줄이기 위한 입문 정리입니다. 특히 한국어로 diffusion의 수식 흐름을 정리한 참고 글들을 읽으며 얻은 큰 흐름을 바탕으로 하되, 여기서는 수식 유도보다 직관과 용어 연결에 초점을 둡니다.[^tistory14][^tistory16][^tistory23]

목표는 수식을 완벽하게 유도하는 것이 아닙니다. 대신 **이미지를 점점 망가뜨린 뒤, 그 망가지는 과정을 거꾸로 배우면 새로운 이미지를 만들 수 있다**는 핵심 아이디어를 중심으로 VAE, DDPM, VDM, score-based model, latent diffusion을 한 번에 이어 보겠습니다.

## 1. Diffusion Model을 한 문장으로 이해하기

Diffusion Model은 데이터를 아주 조금씩 노이즈로 망가뜨리는 과정과, 그 노이즈를 조금씩 제거해 원래 데이터처럼 복원하는 과정을 함께 생각하는 생성모델입니다. DDPM 논문은 이 과정을 **denoising diffusion probabilistic model**로 정식화했고, 이미지 생성 품질이 좋은 생성모델 계열로 확산되는 계기가 되었습니다.[^ddpm]

> Diffusion Model은 “깨끗한 이미지에서 노이즈 이미지로 가는 쉬운 과정”을 만든 뒤, “노이즈 이미지에서 깨끗한 이미지로 돌아오는 어려운 과정”을 신경망이 배우게 하는 방식으로 이해할 수 있습니다.

가장 직관적인 비유는 유리컵에 잉크를 떨어뜨리는 장면입니다. 잉크가 물에 퍼지는 과정은 자연스럽고 쉽습니다. 하지만 이미 퍼진 잉크를 원래 한 방울로 되돌리는 일은 어렵습니다. Diffusion Model은 이 어려운 되돌리기 과정을 여러 단계로 쪼개서 신경망에게 학습시킵니다.

| 관점 | 하는 일 | 이해 포인트 |
|---|---|---|
| Forward process | 원본 데이터에 노이즈를 조금씩 추가 | 학습자가 직접 설계하는 비교적 쉬운 과정 |
| Reverse process | 노이즈에서 원본처럼 보이는 데이터를 복원 | 신경망이 학습해야 하는 핵심 과정 |
| Sampling | 학습된 reverse process를 반복 실행 | 완전한 노이즈에서 새로운 이미지를 생성 |

## 2. 생성모델은 무엇을 하려는 걸까?

생성모델의 목표는 단순히 이미지를 복사하는 것이 아니라, 학습 데이터가 가진 분포를 배워서 그럴듯한 새 샘플을 만드는 것입니다. 예를 들어 고양이 이미지가 많이 있다면, 모델은 특정 고양이 사진 한 장을 외우는 것이 아니라 “고양이처럼 보이는 이미지가 주로 어떤 형태를 가지는지”를 배워야 합니다.

여기서 중요한 단어가 **분포(distribution)**입니다. 수학적으로 깊게 들어가지 않아도, 분포는 “데이터가 자주 나타나는 위치와 드물게 나타나는 위치의 지도”라고 생각하면 됩니다. 생성모델은 무작위 숫자에서 출발하더라도 이 지도 위에서 그럴듯한 위치로 이동해야 합니다.

Diffusion Model은 이 이동을 한 번에 해결하지 않습니다. 대신 “현재 이미지에 섞인 노이즈가 무엇인지” 또는 “노이즈를 어느 방향으로 줄여야 하는지”를 단계별로 예측합니다. 그래서 diffusion을 이해할 때는 **한 번에 생성한다**보다 **조금씩 복원한다**는 관점이 더 자연스럽습니다.

## 3. VAE: 데이터를 압축했다가 다시 복원하는 모델

Diffusion을 보기 전에 VAE를 먼저 잡아두면 latent diffusion과 VDM을 이해하기가 훨씬 쉬워집니다. VAE는 **Variational Autoencoder**의 약자입니다. Autoencoder는 입력을 작은 표현으로 압축하는 encoder와, 그 표현에서 다시 입력을 복원하는 decoder로 구성됩니다.

VAE는 여기에 확률적 관점을 더합니다. 일반 autoencoder가 하나의 고정된 벡터로 데이터를 압축한다면, VAE는 데이터를 latent variable의 확률분포로 표현합니다. VAE 원 논문은 continuous latent variable을 가진 확률모델을 효율적으로 학습하기 위해 variational lower bound와 reparameterization trick을 사용합니다.[^vae]

| 구성요소 | 역할 | 쉬운 설명 |
|---|---|---|
| Encoder | 입력을 latent 표현으로 변환 | 이미지를 압축 파일처럼 요약 |
| Latent variable | 압축된 내부 표현 | 모델이 다루기 쉬운 숨은 좌표 |
| Decoder | latent 표현을 다시 데이터로 복원 | 압축을 풀어 이미지처럼 되돌림 |
| Prior | latent 공간의 기준 분포 | 보통 정규분포처럼 다루기 쉬운 형태를 사용 |

VAE를 너무 어렵게 생각할 필요는 없습니다. 이 글에서 필요한 핵심은 하나입니다. **VAE는 원본 데이터를 더 작은 latent space로 보내고, 그 latent에서 다시 복원하는 구조**입니다. Stable Diffusion 같은 latent diffusion 계열을 이해할 때 이 개념이 다시 등장합니다.

## 4. Diffusion: 이미지를 망가뜨리고 다시 복원하기

Diffusion의 forward process는 원본 이미지에 노이즈를 조금씩 추가합니다. 처음에는 원본이 거의 보이지만, 단계를 많이 지나면 결국 거의 순수한 노이즈처럼 보입니다. 이 과정은 사람이 정해줄 수 있습니다. 예를 들어 “각 단계에서 아주 작은 가우시안 노이즈를 더한다”는 식입니다.

반대로 reverse process는 어렵습니다. 완전한 노이즈처럼 보이는 이미지에서 출발해 한 단계씩 노이즈를 제거해야 하기 때문입니다. DDPM에서는 신경망이 각 단계의 노이즈를 예측하도록 학습합니다. 실제 구현에서는 원본 이미지를 직접 예측하는 방식, 노이즈를 예측하는 방식, score를 예측하는 방식이 서로 연결되어 설명됩니다.[^unified]

| 단계 | 이미지 상태 | 모델이 해야 하는 일 |
|---|---|---|
| `x_0` | 깨끗한 원본 이미지 | 학습 데이터 |
| `x_1, x_2, ...` | 노이즈가 조금씩 섞인 이미지 | forward process로 생성 가능 |
| `x_T` | 거의 순수한 노이즈 | sampling의 출발점 |
| `x_T → x_0` | 노이즈를 점점 제거 | 신경망이 학습하는 reverse process |

이 구조가 좋은 이유는 어려운 생성 문제를 아주 작은 denoising 문제의 반복으로 바꾼다는 점입니다. 한 번에 완벽한 이미지를 만들라고 하면 어렵지만, “지금 단계에서 섞인 노이즈를 조금 줄여보라”고 하면 신경망이 학습할 수 있는 문제가 됩니다.

## 5. DDPM: 노이즈 제거를 학습하는 대표 구조

DDPM은 diffusion을 이해할 때 가장 자주 만나는 기준점입니다. 논문의 핵심 아이디어는 간단하게 말하면, forward process로 만든 noisy image에서 어떤 노이즈가 들어갔는지 신경망이 예측하도록 학습하는 것입니다.[^ddpm]

보통 diffusion 설명에서 다음과 같은 식을 만납니다.

```text
x_t = 깨끗한 이미지 x_0에 t단계만큼 노이즈가 섞인 상태
```

여기서 `t`는 시간이라기보다 **노이즈 레벨**에 가깝습니다. `t`가 작으면 원본이 많이 남아 있고, `t`가 크면 노이즈가 많이 섞여 있습니다. 모델은 `x_t`와 `t`를 입력으로 받아 “이 이미지에 섞인 노이즈가 무엇인지”를 예측합니다.

| 자주 나오는 표현 | 처음 볼 때의 의미 |
|---|---|
| `x_0` | 원본 데이터, 깨끗한 이미지 |
| `x_t` | t단계만큼 노이즈가 섞인 이미지 |
| `epsilon` | 이미지에 추가된 노이즈 |
| noise schedule | 단계별로 노이즈를 얼마나 넣을지 정한 규칙 |
| denoising network | 노이즈를 예측하거나 제거 방향을 예측하는 신경망 |

수학 비전공자 입장에서는 `x_t`를 복잡한 확률변수로 보기 전에, “원본과 노이즈가 특정 비율로 섞인 중간 상태”라고 이해해도 충분합니다. Diffusion 학습은 이 중간 상태를 많이 보여주고, 모델이 어느 방향으로 복원해야 하는지 반복해서 배우게 하는 과정입니다.

## 6. VDM: Diffusion을 VAE 관점에서 바라보기

VDM은 **Variational Diffusion Model**을 의미합니다. VDM 원 논문은 diffusion-based generative model을 likelihood-based model 관점에서 다루며, variational lower bound와 noise schedule을 중요한 주제로 다룹니다.[^vdm] 이름에 variational이 들어가기 때문에 VAE와 완전히 별개의 개념처럼 보이지 않습니다. 실제로 diffusion을 VAE의 확장된 형태, 더 정확히는 여러 단계의 latent variable을 가진 계층적 VAE 관점에서 바라볼 수 있습니다. Calvin Luo의 Unified Perspective 글은 VDM을 Markovian Hierarchical VAE의 특수한 경우로 설명하면서, variational 관점과 score-based 관점을 연결합니다.[^unified]

처음에는 이 설명이 어렵게 느껴질 수 있습니다. 핵심만 줄이면 다음과 같습니다. VAE는 보통 하나의 latent 표현으로 압축했다가 복원합니다. 반면 diffusion은 `x_1, x_2, ..., x_T`처럼 노이즈가 점점 커지는 여러 중간 상태를 둡니다. 이 중간 상태들을 latent variable의 연쇄로 보면 diffusion을 VAE 계열의 관점에서도 이해할 수 있습니다.

| 모델 | latent를 보는 방식 | 직관 |
|---|---|---|
| VAE | 하나의 압축된 latent 표현을 사용 | 이미지를 숨은 좌표로 압축 후 복원 |
| Hierarchical VAE | 여러 층의 latent 표현을 사용 | 더 많은 중간 표현을 거쳐 생성 |
| VDM | 노이즈 단계 전체를 latent chain처럼 해석 | 노이즈가 섞인 상태들을 거꾸로 따라가며 복원 |

따라서 VDM을 처음 볼 때는 “새로운 완전 별개 모델”이라기보다, **diffusion을 변분추론과 VAE 언어로 해석한 관점**이라고 받아들이면 좋습니다.

## 7. Score-based 관점: 더 그럴듯한 데이터 방향을 알려주는 화살표

Diffusion 자료를 읽다 보면 score function이라는 표현도 자주 나옵니다. 여기서 score는 시험 점수가 아닙니다. 대략적으로 말하면, 현재 위치에서 데이터가 더 그럴듯해지는 방향을 알려주는 벡터장에 가깝습니다. Unified Perspective는 VDM의 objective가 원본 입력 예측, 원본 노이즈 예측, score function 예측과 연결될 수 있다고 설명합니다.[^unified]

2차원 지도를 떠올려 보겠습니다. 어떤 점은 실제 데이터가 많이 모여 있는 지역이고, 어떤 점은 거의 데이터가 없는 지역입니다. score는 “현재 점에서 데이터가 더 많은 쪽으로 가려면 어느 방향으로 움직여야 하는가”를 알려주는 화살표라고 생각할 수 있습니다.

| 관점 | 질문 | 모델의 역할 |
|---|---|---|
| Noise prediction | 이 이미지에 섞인 노이즈는 무엇인가? | 노이즈를 예측 |
| Denoising | 이 이미지를 조금 더 깨끗하게 만들려면? | 복원 방향을 예측 |
| Score-based | 더 데이터다운 방향은 어디인가? | 분포의 방향성을 예측 |

이 세 관점은 처음에는 서로 다른 설명처럼 보이지만, diffusion 문헌에서는 서로 깊게 연결되어 있습니다. 입문 단계에서는 “노이즈를 예측한다”, “노이즈를 제거한다”, “더 그럴듯한 방향으로 이동한다”가 같은 현상을 다른 언어로 설명한다고 이해하면 됩니다.

## 8. Latent Diffusion: 픽셀 대신 압축된 공간에서 diffusion하기

일반 diffusion을 픽셀 이미지 위에서 직접 수행하면 계산 비용이 큽니다. 고해상도 이미지는 픽셀 수가 많기 때문에 매 단계마다 큰 이미지를 다뤄야 합니다. Latent Diffusion Model은 이 문제를 줄이기 위해 pretrained autoencoder가 만든 latent space에서 diffusion을 수행합니다.[^ldm]

쉽게 말해 원본 이미지를 바로 다루지 않고, 먼저 VAE나 autoencoder로 이미지를 압축합니다. 그런 다음 압축된 latent 표현 위에서 diffusion을 실행하고, 마지막에 decoder로 다시 이미지로 복원합니다. Stable Diffusion 계열을 이해할 때 이 구조가 중요합니다.

| 방식 | diffusion이 일어나는 공간 | 장점 | 단점 또는 주의점 |
|---|---|---|---|
| Pixel diffusion | 원본 픽셀 공간 | 개념적으로 직접적 | 고해상도에서 계산 비용이 큼 |
| Latent diffusion | 압축된 latent 공간 | 더 효율적이고 빠름 | autoencoder 품질이 결과에 영향을 줌 |

Latent diffusion을 처음 배울 때 가장 중요한 문장은 이것입니다. **VAE가 이미지를 작은 latent로 압축하고, diffusion은 그 latent에서 노이즈 제거 과정을 학습한다**는 것입니다. 그래서 VAE와 diffusion은 경쟁 관계가 아니라, latent diffusion 안에서는 서로 역할을 나누는 관계로 볼 수 있습니다.

## 9. 처음 볼 때 헷갈리는 용어 정리

Diffusion Model을 공부하다 보면 개념보다 용어가 먼저 막힐 때가 많습니다. 아래 표는 논문이나 블로그에서 자주 만나는 표현을 빠르게 복기하기 위한 정리입니다.

| 용어 | 쉬운 의미 | 함께 보면 좋은 개념 |
|---|---|---|
| Forward process | 원본에 노이즈를 넣는 과정 | noise schedule |
| Reverse process | 노이즈를 제거해 데이터를 복원하는 과정 | sampling, denoising |
| Denoising | 노이즈가 섞인 입력을 더 깨끗하게 만드는 작업 | DDPM |
| Noise schedule | 단계별 노이즈 양을 정하는 규칙 | beta schedule |
| Latent space | 모델이 다루기 쉽게 압축한 내부 표현 공간 | VAE, autoencoder |
| VAE | 데이터를 확률적 latent로 압축·복원하는 모델 | encoder, decoder |
| VDM | diffusion을 variational 관점에서 본 모델 | hierarchical VAE |
| Score | 데이터가 더 그럴듯해지는 방향 정보 | score-based model |
| Guidance | 조건에 맞는 생성으로 유도하는 방법 | text-to-image |

## 10. 전체 흐름 다시 보기

지금까지의 내용을 하나의 흐름으로 연결하면 다음과 같습니다. 생성모델은 데이터 분포를 배워 새로운 샘플을 만들고 싶어 합니다. VAE는 데이터를 latent space로 압축했다가 복원하는 방법을 제공합니다. Diffusion은 원본을 노이즈로 망가뜨린 뒤, 그 과정을 거꾸로 복원하는 방법을 학습합니다. DDPM은 이 과정을 대표적으로 정식화한 모델입니다. VDM은 diffusion을 VAE와 변분추론 관점에서 이해하게 해줍니다. Latent Diffusion은 diffusion을 픽셀 공간이 아니라 VAE가 만든 latent 공간에서 수행해 계산 효율을 높입니다.

| 질문 | 한 줄 답변 |
|---|---|
| 왜 노이즈를 넣는가? | 복잡한 생성을 작은 denoising 문제들의 반복으로 바꾸기 위해서입니다. |
| 모델은 무엇을 배우는가? | 각 노이즈 단계에서 제거해야 할 노이즈 또는 복원 방향을 배웁니다. |
| VAE는 왜 등장하는가? | 데이터를 latent space로 압축하고 복원하는 구조를 제공하기 때문입니다. |
| VDM은 무엇인가? | diffusion을 variational/HVAE 관점에서 해석하는 방식입니다. |
| Latent Diffusion은 왜 빠른가? | 큰 픽셀 이미지 대신 작은 latent 표현에서 diffusion을 수행하기 때문입니다. |

## 마무리

Diffusion Model은 처음에는 수식과 용어가 한꺼번에 등장해서 어렵게 느껴집니다. 하지만 큰 흐름은 비교적 단순합니다. **노이즈를 넣는 과정은 사람이 설계하고, 노이즈를 제거하는 과정은 모델이 배운다**는 것입니다. 여기에 VAE의 latent space 개념이 결합되면, 고해상도 이미지를 더 효율적으로 생성하는 latent diffusion으로 이어집니다.

앞으로 DDPM, score-based model, classifier-free guidance, U-Net, Stable Diffusion 구조를 따로 공부하더라도 이 글의 큰 줄기를 먼저 잡아두면 훨씬 덜 헷갈립니다. 새로운 수식이 나오면 “이 수식은 노이즈를 넣는 과정인가, 제거하는 과정인가, 아니면 latent 공간에서 같은 일을 하는 것인가”를 먼저 확인하면 됩니다.

## 참고 자료

[^ddpm]: Jonathan Ho, Ajay Jain, Pieter Abbeel, [Denoising Diffusion Probabilistic Models](https://arxiv.org/abs/2006.11239), arXiv, 2020.

[^vdm]: Diederik P. Kingma, Tim Salimans, Ben Poole, Jonathan Ho, [Variational Diffusion Models](https://arxiv.org/abs/2107.00630), arXiv, 2021.

[^unified]: Calvin Luo, [Understanding Diffusion Models: A Unified Perspective](https://arxiv.org/abs/2208.11970), arXiv, 2022.

[^vae]: Diederik P. Kingma, Max Welling, [Auto-Encoding Variational Bayes](https://arxiv.org/abs/1312.6114), arXiv, 2013.

[^ldm]: Robin Rombach et al., [High-Resolution Image Synthesis with Latent Diffusion Models](https://arxiv.org/abs/2112.10752), arXiv, 2021.

[^tistory14]: Donghyun Blog, [Diffusion Model 관련 한국어 설명 글](https://donghyun99.tistory.com/14), Tistory.

[^tistory16]: Donghyun Blog, [VAE·VDM 관련 한국어 설명 글](https://donghyun99.tistory.com/16), Tistory.

[^tistory23]: Donghyun Blog, [Diffusion 후속 설명 글](https://donghyun99.tistory.com/23?category=1337068), Tistory.
