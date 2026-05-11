---
title: "LaTeX와 IEEE 논문 작성: 처음부터 실전 제출까지 정리한 가이드"
date: 2026-05-08
draft: false
description: "LaTeX 기본 문법, IEEEtran 템플릿, 수식·그림·표·참고문헌 작성법을 논문 제출 흐름에 맞춰 정리한 실전 기술 가이드입니다."
image: ""
tags: ["latex", "ieee", "논문작성", "research", "overleaf", "bibtex"]
categories: ["Tools"]
---

LaTeX는 처음 접하면 문법이 낯설지만, 논문처럼 구조가 명확하고 반복 수정이 많은 문서를 작성할 때 강력한 도구가 됩니다. 특히 IEEE 형식의 논문은 제목, 초록, Index Terms, 수식 번호, 그림·표 캡션, 참고문헌 형식까지 규칙이 엄격하므로 Word처럼 눈으로 맞추는 방식보다 LaTeX 템플릿을 기준으로 관리하는 편이 안정적입니다.

이 글은 LaTeX를 막 시작한 연구자나 개발자가 **IEEE 논문 초안**을 작성할 때 필요한 내용을 하나의 흐름으로 정리한 가이드입니다. 단순 명령어 목록보다 실제 작성 순서에 맞춰 설명하며, 복사해서 바로 실험할 수 있는 최소 예제를 함께 제공합니다. Google이 검색 결과 스니펫을 만들 때 페이지별 `meta description`을 활용할 수 있다고 설명하듯이, 기술 글도 제목과 요약만으로 글의 범위가 분명해야 독자가 빠르게 판단할 수 있습니다.[^google-snippet]

## 이 글에서 다루는 범위

LaTeX에는 문서 조판, 수식, 그림, 참고문헌, 패키지 생태계가 모두 포함되어 있습니다. 따라서 처음부터 모든 명령어를 외우려 하기보다, 논문 한 편을 완성하는 데 필요한 핵심 개념을 순서대로 익히는 것이 좋습니다.

| 단계 | 핵심 질문 | 이 글에서 제공하는 내용 |
|---|---|---|
| 문서 뼈대 만들기 | LaTeX 문서는 어디서 시작하고 끝나는가 | `\documentclass`, `\usepackage`, `document` 환경 |
| 본문 구조화 | 섹션과 문단은 어떻게 나누는가 | `\section`, `\subsection`, 제목 계층 |
| 수식 작성 | 번호가 있는 수식과 여러 줄 수식은 어떻게 쓰는가 | `equation`, `align`, `IEEEeqnarray` |
| 그림·표 삽입 | 캡션과 라벨은 어디에 두어야 하는가 | `figure`, `table`, `\caption`, `\label` |
| 참고문헌 관리 | IEEE 스타일 인용은 어떻게 정리하는가 | `\cite`, `thebibliography`, BibTeX 흐름 |
| IEEE 제출 준비 | 일반 LaTeX와 IEEEtran의 차이는 무엇인가 | `IEEEtran`, `ieeecolor`, Index Terms, 체크리스트 |

> 이 글의 원칙은 명확합니다. **본문에서는 구조를 먼저 잡고, 세부 서식은 템플릿과 패키지에 맡깁니다.** 논문 작성의 품질은 예쁜 화면보다 재현 가능한 구조와 일관된 참조에서 결정됩니다.

## 1. LaTeX 문서의 최소 구조

LaTeX 문서는 크게 두 영역으로 나뉩니다. 첫 번째는 문서 클래스와 패키지를 선언하는 **preamble**이고, 두 번째는 실제 내용이 들어가는 **document 환경**입니다. 가장 작은 문서는 다음처럼 구성됩니다.

```latex
\documentclass{article}

\begin{document}
Hello, LaTeX.
\end{document}
```

논문을 작성할 때는 문서 클래스가 중요합니다. 일반 보고서라면 `article`로 충분하지만, IEEE 저널 또는 컨퍼런스 양식을 맞춰야 한다면 `IEEEtran` 계열 클래스를 사용해야 합니다. IEEEtran은 IEEE 논문 레이아웃을 위한 대표적인 LaTeX 클래스이며, CTAN에서 배포되는 버전은 v1.8b입니다.[^ctan-ieeetran]

| 문서 클래스 | 주 사용처 | 비고 |
|---|---|---|
| `article` | 짧은 논문, 보고서 | LaTeX 기본 클래스 |
| `report` | 장문의 보고서, 학위논문 | 장과 절 구조에 적합 |
| `book` | 단행본 | 책 구성에 적합 |
| `beamer` | 발표 슬라이드 | 프레젠테이션 전용 |
| `IEEEtran` | IEEE 논문 | IEEE 저널·컨퍼런스 양식에 적합 |
| `ieeecolor` | 일부 IEEE 컬러 저널 템플릿 | 저널별 템플릿 지침 확인 필요 |

## 2. 논문용 기본 패키지 구성

LaTeX 패키지는 필요한 기능만 추가하는 방식으로 관리하는 것이 좋습니다. 처음부터 많은 패키지를 넣으면 충돌 원인을 찾기 어렵습니다. 아래 구성은 수식, 그림, 표, 링크, IEEE 인용에 자주 쓰이는 기본 조합입니다.

```latex
% 수식과 수학 기호
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}

% 그림과 표
\usepackage{graphicx}
\usepackage{booktabs}

% IEEE 다중 그림
\usepackage{subfig}

% 알고리즘
\usepackage{algorithm}
\usepackage{algorithmic}

% 링크와 인용
\usepackage{hyperref}
\hypersetup{hidelinks=true}
\usepackage{cite}
```

IEEEtran을 사용할 때는 특히 캡션 관련 패키지에 주의해야 합니다. `subcaption`은 내부적으로 `caption` 패키지에 의존하므로 IEEEtran과 충돌할 수 있습니다. IEEE 형식에서 다중 그림을 다룰 때는 보통 `subfig`를 사용하는 편이 안전합니다.

## 3. 제목, 섹션, 문단 구조 잡기

LaTeX 문서에서 제목 계층은 HTML의 heading과 비슷합니다. 가장 큰 단위는 `\section`, 그 아래는 `\subsection`, 그 아래는 `\subsubsection`입니다. 논문에서는 제목 계층이 너무 깊어지면 독자가 흐름을 놓치기 쉬우므로, 보통 `subsection` 수준까지를 중심으로 설계하는 것이 좋습니다.

```latex
\section{Introduction}
\subsection{Motivation}
\subsection{Contribution}
\section{Method}
\subsection{Model Architecture}
\section{Experiments}
\section{Conclusion}
```

기술 블로그 글도 마찬가지입니다. 제목은 글의 약속이고, 각 섹션은 그 약속을 단계적으로 증명해야 합니다. LaTeX 논문에서는 대체로 **Introduction → Related Work → Method → Experiments → Results → Conclusion** 흐름이 많이 사용됩니다.

## 4. 수식 작성: `equation`, `align`, `IEEEeqnarray`

LaTeX를 쓰는 가장 큰 이유 중 하나는 수식 조판입니다. 짧은 인라인 수식은 `$...$`로 작성하고, 독립된 수식은 `equation` 또는 `align` 환경을 사용합니다.

```latex
텍스트 안에서는 $E = mc^2$처럼 인라인 수식을 작성합니다.

\begin{equation}
  E = mc^2.
  \label{eq:energy}
\end{equation}
```

여러 줄로 정렬해야 하는 수식에는 `align`이 편리합니다.

```latex
\begin{align}
  f(x) &= ax^2 + bx + c \\
       &= a(x + 1)^2 + c - a.
  \label{eq:quadratic}
\end{align}
```

IEEEtran 문서에서는 `IEEEeqnarray`도 자주 사용됩니다. 등호 정렬과 번호 제어가 필요한 경우 IEEE 스타일에 더 적합한 선택이 될 수 있습니다.

```latex
\begin{IEEEeqnarray}{rCl}
  a &=& b + c \nonumber \\
  x &=& y + z.
  \label{eq:system}
\end{IEEEeqnarray}
```

반대로 `eqnarray`는 사용하지 않는 것이 좋습니다. 등호 주변 간격이 부정확하고, 현대 LaTeX 문서에서는 `align` 또는 `IEEEeqnarray`로 대체하는 것이 일반적입니다.

## 5. 그림 삽입: 캡션과 라벨 순서가 중요하다

논문에서 그림은 단순한 장식이 아니라 결과를 설명하는 핵심 근거입니다. LaTeX에서는 그림을 `figure` 환경 안에 넣고, `\caption` 뒤에 `\label`을 배치해야 참조 번호가 올바르게 연결됩니다.

```latex
\begin{figure}[!t]
  \centering
  \includegraphics[width=\columnwidth]{fig1.png}
  \caption{Proposed model architecture.}
  \label{fig:model}
\end{figure}
```

| 위치 옵션 | 의미 | 실무 메모 |
|---|---|---|
| `h` | 현재 위치 | LaTeX가 반드시 지키지는 않음 |
| `t` | 페이지 상단 | IEEE 문서에서 자주 사용 |
| `b` | 페이지 하단 | 그림 흐름에 따라 사용 |
| `p` | 별도 float 페이지 | 큰 그림이 많을 때 사용 |
| `!` | 배치 제한 완화 | `!t`처럼 함께 사용 가능 |

다중 그림을 넣을 때는 `subfig`의 `\subfloat`를 사용할 수 있습니다.

```latex
\begin{figure}[!t]
  \centering
  \subfloat[Case A]{%
    \includegraphics[width=1.6in]{fig_a}%
    \label{fig:case-a}}
  \hfil
  \subfloat[Case B]{%
    \includegraphics[width=1.6in]{fig_b}%
    \label{fig:case-b}}
  \caption{Comparison of two experimental settings.}
  \label{fig:comparison}
\end{figure}
```

## 6. 표 작성: `booktabs`로 가독성 확보하기

표는 결과를 정리하는 데 매우 유용하지만, 선을 많이 넣을수록 오히려 읽기 어려워집니다. `booktabs` 패키지의 `\toprule`, `\midrule`, `\bottomrule`을 사용하면 논문에 적합한 깔끔한 표를 만들 수 있습니다.

```latex
\begin{table}[!t]
  \centering
  \caption{Performance comparison.}
  \label{tab:performance}
  \begin{tabular}{lcc}
    \toprule
    Method & Accuracy & Latency \\
    \midrule
    Baseline & 91.7\% & 18 ms \\
    Proposed & 94.2\% & 23 ms \\
    \bottomrule
  \end{tabular}
\end{table}
```

그림 캡션은 보통 그림 아래에 오고, 표 캡션은 표 위에 옵니다. 또한 본문에서 표를 언급할 때는 `Table \ref{tab:performance}`처럼 자동 참조를 사용해야 합니다.

## 7. 상호 참조: 직접 숫자를 쓰지 않는다

LaTeX 문서에서 수식, 그림, 표, 섹션 번호를 직접 입력하면 수정 과정에서 번호가 틀어지기 쉽습니다. 따라서 항상 `\label`과 `\ref`를 사용해야 합니다.

```latex
\section{Method}
\label{sec:method}

\begin{equation}
  y = Wx + b.
  \label{eq:linear}
\end{equation}

As shown in Section~\ref{sec:method}, the model is defined by Eq.~\eqref{eq:linear}.
```

가장 흔한 오류는 `\label`을 `\caption` 앞에 두는 것입니다. 그림과 표에서는 반드시 `\caption`이 번호를 생성한 다음 `\label`을 붙여야 합니다.

## 8. 참고문헌과 인용 관리

IEEE 논문에서 인용은 대괄호 번호 형식으로 표시됩니다. 수동으로 `thebibliography`를 사용할 수도 있고, 규모가 커지면 BibTeX 또는 BibLaTeX 기반으로 관리할 수 있습니다.

```latex
Prior work reported similar behavior \cite{smith2024}.

\begin{thebibliography}{99}
\bibitem{smith2024}
J. Smith and A. Kim, ``A sample paper title,''
{\it IEEE Transactions on Example}, vol. 1, no. 2, pp. 10--20, 2024.
\end{thebibliography}
```

IEEE 스타일에서는 저자명, 논문 제목, 저널명, 권·호·페이지, 연도, DOI 표기까지 일정한 형식이 요구됩니다. 제출 전에는 IEEE Author Center 또는 목표 저널의 공식 템플릿을 확인하는 것이 안전합니다.[^ieee-author-center]

## 9. IEEE 템플릿의 기본 골격

IEEE 논문 초안을 시작할 때는 빈 파일에서 모든 것을 만들기보다 공식 템플릿을 기준으로 줄여 나가는 방식이 좋습니다. 아래는 IEEE 스타일 문서의 기본 골격입니다.

```latex
\documentclass[journal]{IEEEtran}

\usepackage{cite}
\usepackage{amsmath,amssymb,amsfonts}
\usepackage{algorithmic}
\usepackage{graphicx}
\usepackage{textcomp}

\begin{document}

\title{Paper Title in Title Case}

\author{First A. Author, Second B. Author, and Third C. Author}

\maketitle

\begin{abstract}
This paper presents ...
\end{abstract}

\begin{IEEEkeywords}
Deep learning, medical imaging, segmentation.
\end{IEEEkeywords}

\section{Introduction}
\IEEEPARstart{T}{his} paper ...

\section{Conclusion}

\end{document}
```

초록은 논문의 문제, 방법, 결과, 의의를 압축해서 보여주는 부분입니다. IEEE 문서에서는 초록 안에 각주, 참조 번호, 복잡한 수식, 표를 넣지 않는 것이 일반적입니다. `IEEEkeywords`에는 검색과 분류에 도움이 되는 Index Terms를 넣습니다.

## 10. IEEE 논문 작성 체크리스트

논문을 제출하기 전에는 문법보다 **일관성**을 먼저 점검해야 합니다. 아래 항목은 초안 단계에서 자주 발견되는 문제를 줄이는 데 도움이 됩니다.

| 구분 | 확인할 항목 | 권장 방식 |
|---|---|---|
| 수식 | 번호 참조 | `\eqref{}` 사용 |
| 그림 | 라벨 위치 | `\caption` 뒤에 `\label` 배치 |
| 표 | 캡션 위치 | 표 위에 캡션 배치 |
| 인용 | 번호 직접 입력 | `\cite{}` 사용 |
| 단위 | 시간 단위 | `sec`보다 `s` 사용 |
| 범위 | 페이지·수치 범위 | `1--10`처럼 엔 대시 사용 |
| 문체 | 수동태 남용 | 가능한 경우 명확한 능동태 사용 |
| 패키지 | 캡션 충돌 | IEEEtran에서는 `caption`, `subcaption` 사용 주의 |

## 11. 자주 발생하는 오류와 해결 방법

LaTeX 오류 메시지는 처음에는 어렵게 보이지만, 대부분 원인은 반복됩니다. 특히 괄호가 닫히지 않았거나, 패키지 충돌이 있거나, 라벨과 참조가 맞지 않는 경우가 많습니다.

| 증상 | 원인 | 해결 |
|---|---|---|
| 수식 번호가 건너뜀 | 빈 `subequations` 환경이 남아 있음 | 사용하지 않는 환경 삭제 |
| 그림 참조 번호가 이상함 | `\label`이 `\caption` 앞에 있음 | `\caption{...}\label{...}` 순서로 수정 |
| Table IV-B3 같은 참조가 나옴 | 섹션과 표에 같은 라벨 사용 | `sec:`, `fig:`, `tab:`, `eq:` 접두사로 구분 |
| 그림이 원하는 위치에 안 나옴 | float 배치 알고리즘 때문 | `[!t]`, `[htbp]` 등을 조정하고 본문 흐름 재검토 |
| 다중 그림 캡션이 깨짐 | `subcaption`과 IEEEtran 충돌 | `subfig` 사용 검토 |

## 12. 자주 쓰는 LaTeX 명령어 모음

아래 명령어는 논문 작성 중 자주 사용됩니다. 처음부터 모두 외울 필요는 없고, 필요한 순간에 검색해서 반복적으로 사용하면 자연스럽게 익숙해집니다.

```latex
% 텍스트
\textbf{bold}
\textit{italic}
\texttt{monospace}
\emph{emphasis}

% 특수문자
\%  \$  \&  \#  \_  \{  \}

% 줄과 페이지
\\
\newpage
\clearpage
\noindent

% 공백
\,
\quad
\qquad
\hfill

% 대시와 따옴표
--       % en dash
---      % em dash
``큰따옴표''
`작은따옴표'
```

수학 기호는 다음처럼 작성합니다.

```latex
% 첨자와 분수
x_i^2
\frac{a}{b}
\sqrt{x}

% 합, 적분, 극한
\sum_{i=1}^{n} x_i
\int_a^b f(x)\,dx
\lim_{n \to \infty}

% 집합과 화살표
\mathbb{R}
\in
\subseteq
\Rightarrow
\Leftrightarrow

% 행렬
\begin{bmatrix}
  a & b \\
  c & d
\end{bmatrix}
```

## 13. Overleaf로 시작할 때의 권장 흐름

로컬 LaTeX 환경을 직접 구성하는 것도 가능하지만, 처음에는 Overleaf 같은 웹 기반 편집기를 사용하면 패키지 설치 문제를 줄일 수 있습니다. Overleaf는 LaTeX 프로젝트를 온라인에서 작성·컴파일할 수 있는 환경을 제공하며, 공식 문서에서 수식과 참고문헌 작성 예제를 제공하고 있습니다.[^overleaf-amsmath]

실전에서는 다음 순서가 효율적입니다.

| 순서 | 작업 | 이유 |
|---|---|---|
| 1 | 목표 저널 또는 학회 템플릿 다운로드 | 제출 형식을 처음부터 맞추기 위해 |
| 2 | 예제 본문을 지우기 전에 구조 확인 | 어떤 명령이 필요한지 파악하기 위해 |
| 3 | 제목·초록·섹션 제목만 먼저 작성 | 논문의 논리 구조를 먼저 고정하기 위해 |
| 4 | 그림·표·수식을 라벨과 함께 추가 | 나중에 참조 오류를 줄이기 위해 |
| 5 | 참고문헌을 마지막에 정리하지 말고 작성 중 관리 | 누락 인용을 줄이기 위해 |

## 마치며

LaTeX와 IEEE 템플릿은 처음에는 복잡해 보이지만, 실제로는 몇 가지 원칙을 반복해서 적용하는 작업입니다. 문서 클래스와 패키지는 최소한으로 시작하고, 모든 번호는 `\label`과 `\ref`로 관리하며, 그림과 표는 캡션과 라벨 순서를 지키고, IEEE 제출 전에는 공식 템플릿과 저널별 지침을 확인하면 됩니다.

가장 중요한 것은 글을 쓰기 전에 구조를 먼저 정하는 것입니다. 논문도 기술 블로그도 독자에게 전달해야 할 문제, 방법, 결과가 명확할수록 읽기 쉬워집니다. LaTeX는 그 구조를 흔들리지 않게 유지해 주는 도구로 생각하면 됩니다.

## 참고 자료

[^google-snippet]: [Google Search Central, "메타 설명 작성 방법"](https://developers.google.com/search/docs/appearance/snippet)
[^ctan-ieeetran]: [CTAN, "IEEEtran – Document class for IEEE Transactions journals and conferences"](https://ctan.org/pkg/ieeetran)
[^ieee-author-center]: [IEEE Author Center, "Authoring Tools and Templates"](https://journals.ieeeauthorcenter.ieee.org/create-your-ieee-journal-article/create-the-text-of-your-article/ieee-article-templates/)
[^overleaf-amsmath]: [Overleaf Documentation, "Aligning equations with amsmath"](https://www.overleaf.com/learn/latex/Aligning_equations_with_amsmath)
