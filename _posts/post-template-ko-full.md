---
layout: post
title: "예시 포스트 제목"
description: "포스트에 대한 짧고 SEO에 최적화된 설명."
categories: [딥러닝, 컴퓨터 비전]
tags: [AI, 연구, CNN]
related_posts:
  - /deep-learning/introduction-to-cnn/
  - /computer-vision/semantic-segmentation/
image:
  path: /assets/img/example.jpg
  srcset:
    800w: /assets/img/example.jpg
    400w: /assets/img/example-small.jpg
excerpt_separator: <!--more-->
sitemap: true
last_modified_at: 2025-04-29T12:00:00+09:00
comments: true
---

# {{ page.title }}

<!--more-->

## 소개
이 글에서는 AI, 딥러닝, 의료 영상 기술에 대해 알아봅니다.

## 목차
* toc
{:toc .large-only}

## 1. 텍스트 포맷팅

**굵은 텍스트**, _기울임 텍스트_, ~~취소선~~, 그리고 `인라인 코드`.

> 이 인용문은 `lead` 스타일을 사용합니다.
{:.lead}

## 2. 코드 블록

### JavaScript
~~~js
function greet(name) {
  return `Hello, ${name}!`;
}
console.log(greet('Hydejack'));
~~~

### Python
~~~python
def greet(name):
    return f"Hello, {name}!"

print(greet("Hydejack"))
~~~

## 3. 수식 (KaTeX)

인라인 수식: \( E = mc^2 \)

블록 수식:
$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$

## 4. 이미지 및 캡션

### 일반 이미지
![예시 이미지](https://via.placeholder.com/800x400 "예시")

### 전체 폭 이미지
![전체 폭 이미지](https://via.placeholder.com/1200x400){:.lead}

### 캡션이 있는 이미지
![캡션 이미지](https://via.placeholder.com/600x200)
이미지에 대한 설명입니다.
{:.figure}

## 5. 표

| 방법  | 설명                   |
|:------|:------------------------|
| CNN   | 합성곱 신경망            |
| RNN   | 순환 신경망              |

스크롤 가능한 표:
| A | B | C | D |
|:-:|:-:|:-:|:-:|
| 1 | 2 | 3 | 4 |
| 5 | 6 | 7 | 8 |
| 9 |10 |11 |12 |
{:.scroll-table}

## 6. 특수 스타일링

**중요 알림:** 이 박스는 메시지 박스입니다.
{:.message}

흐릿하게 보이는 텍스트입니다.
{:.faded}

## 관련 글
- [CNN 소개](/deep-learning/introduction-to-cnn/)
- [컴퓨터 비전에서의 세그멘테이션](/computer-vision/semantic-segmentation/)

---
