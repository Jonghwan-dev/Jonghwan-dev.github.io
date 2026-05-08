---
title: "LaTeX & IEEE 논문 작성 완벽 가이드 — 검증된 문법 요약집"
date: 2026-05-08
tags: [LaTeX, IEEE, 논문작성, 연구, 가이드]
description: "LaTeX 기초 문법부터 IEEE Transactions 논문 양식까지, 최신 공식 문서 기반으로 검증한 실전 요약집"
---

# LaTeX & IEEE 논문 작성 완벽 가이드

> **검증 기준**  
> - IEEEtran.cls **v1.8b** (CTAN 현행 최신)  
> - **IEEE Editorial Style Manual** (Updated 25 March 2025)  
> - IEEE Author Center 공식 가이드라인  
> - amsmath 공식 문서 / Overleaf 공식 가이드

---

## 목차

1. [LaTeX 문서 기본 구조](#1-latex-문서-기본-구조)
2. [필수 패키지](#2-필수-패키지)
3. [텍스트 서식](#3-텍스트-서식)
4. [섹션 구조](#4-섹션-구조)
5. [수식 작성법](#5-수식-작성법)
6. [그림 삽입](#6-그림-삽입)
7. [표 작성](#7-표-작성)
8. [상호 참조](#8-상호-참조)
9. [참고문헌](#9-참고문헌)
10. [IEEE 전용 설정](#10-ieee-전용-설정)
11. [IEEE 그림 & 표 규칙](#11-ieee-그림--표-규칙)
12. [IEEE 참고문헌 형식](#12-ieee-참고문헌-형식)
13. [IEEE 스타일 체크리스트](#13-ieee-스타일-체크리스트)
14. [알고리즘 작성](#14-알고리즘-작성)
15. [저자 약력](#15-저자-약력)
16. [버전별 변경사항 & 패키지 충돌 주의](#16-버전별-변경사항--패키지-충돌-주의)

---

## 1. LaTeX 문서 기본 구조

```latex
\documentclass[옵션]{클래스}   % 문서 유형 선언
\usepackage{패키지명}           % 필요한 패키지 불러오기

\begin{document}                % 본문 시작
  내용
\end{document}                  % 본문 끝
```

### 주요 문서 클래스

| 클래스 | 용도 |
|--------|------|
| `article` | 일반 논문, 보고서 |
| `report` | 긴 보고서, 학위논문 |
| `book` | 단행본 |
| `beamer` | 프레젠테이션 슬라이드 |
| `IEEEtran` | **IEEE 논문 표준 클래스** |
| `ieeecolor` | IEEE 컬러 저널용 (추가 패키지 필요) |

---

## 2. 필수 패키지

```latex
% ── 수학/기호 ─────────────────────────────────
\usepackage{amsmath}       % 수식 환경 확장 (align, gather 등)
\usepackage{amssymb}       % 수학 기호 (∈, ℝ 등)
\usepackage{amsfonts}      % 수학 폰트 (\mathbb, \mathcal 등)

% ── 그림/표 ──────────────────────────────────
\usepackage{graphicx}      % 이미지 삽입
\usepackage{booktabs}      % 고품질 표 (toprule/midrule/bottomrule)

% ── 다중 그림 (IEEEtran 공식 지원) ─────────────
\usepackage{subfig}        % \subfloat 명령. subcaption 아님!

% ── 알고리즘 ─────────────────────────────────
\usepackage{algorithm}
\usepackage{algorithmic}

% ── 링크/참조 ────────────────────────────────
\usepackage{hyperref}
\hypersetup{hidelinks=true}
\usepackage{cite}          % 참고문헌 자동 정렬

% ── 기타 ─────────────────────────────────────
\usepackage{textcomp}
```

> ⚠️ **IEEEtran 사용 시 주의**  
> `subcaption` 패키지는 `caption` 패키지에 의존하며 IEEEtran과 **충돌 가능**.  
> 다중 그림은 반드시 `subfig` 패키지 사용.

---

## 3. 텍스트 서식

```latex
\textbf{굵게}              % Bold
\textit{기울임꼴}           % Italic
\underline{밑줄}            % Underline
\texttt{고정폭 폰트}         % 코드/경로
\emph{강조}                 % 문맥에 따라 이탤릭/로만 자동 전환

% 크기 (작은 것 → 큰 것 순서)
{\tiny}  {\scriptsize}  {\footnotesize}  {\small}  {\normalsize}
{\large}  {\Large}  {\LARGE}  {\huge}  {\Huge}
```

---

## 4. 섹션 구조

```latex
\section{제목}
\subsection{제목}
\subsubsection{제목}
\paragraph{제목}        % 인라인
\subparagraph{제목}     % 인라인

\section*{번호 없는 섹션}   % Acknowledgment, References 등
```

---

## 5. 수식 작성법

### 인라인 / 독립 수식

```latex
% 인라인
텍스트 안에 $E = mc^2$ 수식.

% 독립 — 번호 없음
\[
  \int_{-\infty}^{\infty} e^{-x^2}\,dx = \sqrt{\pi}
\]

% 독립 — 번호 있음 (IEEE 주로 사용)
\begin{equation}
  E = mc^2.        % 문장의 일부면 구두점 포함
  \label{eq:energy}
\end{equation}
```

### 정렬 수식 (여러 줄)

```latex
% ── align (amsmath) ────────────────────────
\begin{align}
  f(x) &= ax^2 + bx + c \\
       &= a(x+1)^2 + c - a
\end{align}

% 번호 없음
\begin{align*}
  2x - 5y &= 8 \\
  3x + 9y &= -12
\end{align*}

% ── IEEEeqnarray (IEEE 권장, IEEEtran 내장) ──
\begin{IEEEeqnarray}{rCl}
  a &=& b + c \nonumber \\
  x &=& y + z \label{eq:sys}
\end{IEEEeqnarray}

% ── equation 안에서 줄 나누기 (split) ────────
\begin{equation}
  \begin{split}
    A &= \frac{\pi r^2}{2} \\
      &= \frac{1}{2}\pi r^2
  \end{split}
  \label{eq:area}
\end{equation}
```

### subequations — (a)(b) 번호

```latex
\begin{subequations}
  \label{eq:maxwell}
  \begin{align}
    \nabla \cdot  \mathbf{E} &= \rho/\epsilon_0 \label{eq:ma} \\
    \nabla \times \mathbf{B} &= \mu_0\mathbf{J} \label{eq:mb}
  \end{align}
\end{subequations}
% 결과: (1a), (1b)
```

> ⚠️ `subequations` 환경은 내부에 수식이 없어도 메인 카운터를 증가시킴.  
> 빈 블록 실수로 남기면 번호가 건너뜀.

> ❌ **`eqnarray` 절대 금지**: 등호 공백 불균일, 공식 obsolete 환경.  
> ✅ **IEEE 논문 권장 순서**: `IEEEeqnarray` → `align`

### 자주 쓰는 수학 기호

```latex
% 위·아래첨자
x^{2}   x_{i}   A_{ij}^{k}

% 분수
\frac{분자}{분모}
\dfrac{분자}{분모}   % 인라인에서도 디스플레이 크기 강제

% 루트
\sqrt{x}    \sqrt[n]{x}

% 합/곱/적분
\sum_{i=1}^{n}    \prod_{k=0}^{N}
\int_{a}^{b} f(x)\,dx     % \, : 미소 공백 (관례)
\oint    \iint    \iiint   % amsmath 필요

% 극한
\lim_{n \to \infty}

% 행렬 (amsmath)
\begin{pmatrix} a & b \\ c & d \end{pmatrix}  % ( )
\begin{bmatrix} a & b \\ c & d \end{bmatrix}  % [ ]
\begin{vmatrix} a & b \\ c & d \end{vmatrix}  % | |

% 굵은 기호
\mathbf{A}            % 굵은 로마체 (벡터/행렬)
\boldsymbol{\alpha}   % 굵은 그리스 문자 (amsmath)
\mathbb{R}            % 블랙보드 볼드
\mathcal{L}           % 캘리그래피

% 그리스 문자 (소문자)
\alpha  \beta  \gamma  \delta  \epsilon  \varepsilon
\zeta   \eta   \theta  \vartheta  \kappa  \lambda
\mu     \nu    \xi     \pi     \sigma   \varsigma
\tau    \phi   \varphi \chi    \psi     \omega

% 그리스 문자 (대문자)
\Gamma \Delta \Theta \Lambda \Xi \Pi \Sigma \Upsilon \Phi \Psi \Omega

% 연산자
\times  \div  \pm  \mp  \cdot  \leq  \geq  \neq
\approx  \equiv  \sim  \ll  \gg

% 집합
\in  \notin  \cup  \cap  \subset  \subseteq  \setminus
\emptyset  \varnothing
\mathbb{N}  \mathbb{Z}  \mathbb{Q}  \mathbb{R}  \mathbb{C}

% 화살표
\to  \leftarrow  \rightarrow  \leftrightarrow
\Rightarrow  \Leftarrow  \Leftrightarrow  \mapsto

% 기타
\infty  \partial  \nabla  \forall  \exists
\therefore  \because
\ldots  \cdots  \vdots  \ddots
\|  \langle  \rangle  \lfloor  \rfloor  \lceil  \rceil
```

---

## 6. 그림 삽입

### 기본 그림

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\columnwidth]{파일명.png}
  \caption{그림 설명}
  \label{fig:이름}    % 반드시 \caption 뒤에!
\end{figure}
```

### 위치 옵션

| 옵션 | 의미 |
|------|------|
| `h` | 현재 위치 |
| `t` | 페이지 상단 (IEEE 권장) |
| `b` | 페이지 하단 |
| `p` | 별도 float 페이지 |
| `!` | LaTeX 배치 제한 완화 |

### 크기 옵션

```latex
width=0.8\textwidth     % 텍스트 너비의 80%
width=\columnwidth       % 컬럼 너비
height=5cm              % 고정 높이
scale=0.7               % 원본의 70%
keepaspectratio         % 비율 유지
```

### 다중 그림 — IEEE 공식 방식 (`subfig`)

```latex
\usepackage{subfig}   % ← subcaption 아님! IEEEtran 공식 지원

% 1컬럼 다중 그림
\begin{figure}[!t]
  \centering
  \subfloat[케이스 A]{\includegraphics[width=1.6in]{fig_a}%
    \label{fig:a}}
  \hfil
  \subfloat[케이스 B]{\includegraphics[width=1.6in]{fig_b}%
    \label{fig:b}}
  \caption{전체 캡션}
  \label{fig:multi}
\end{figure}

% 2컬럼 전체 너비
\begin{figure*}[!t]
  \centering
  \subfloat[케이스 A]{\includegraphics[width=2.5in]{fig_a}\label{fig:wa}}
  \hfil
  \subfloat[케이스 B]{\includegraphics[width=2.5in]{fig_b}\label{fig:wb}}
  \caption{2컬럼 전체 너비 그림 캡션}
  \label{fig:wide}
\end{figure*}
```

> **실무 팁**: 많은 IEEE 저널이 서브캡션 없이 메인 캡션에서  
> "(a) ..., (b) ..." 방식 설명을 선호. 서브캡션 불필요 시 `\subfloat[]` (빈 대괄호).

---

## 7. 표 작성

```latex
\begin{table}[htbp]
  \centering
  \caption{표 제목 — 표는 캡션이 위에, 그림은 아래}
  \label{tab:이름}
  \begin{tabular}{lcc}
    \toprule
    항목 & 방법 A & 방법 B \\
    \midrule
    정확도 & 94.2\% & 91.7\% \\
    속도   & 23 ms  & 18 ms  \\
    \bottomrule
  \end{tabular}
\end{table}
```

### 컬럼 지정자

| 기호 | 의미 |
|------|------|
| `l` | 왼쪽 정렬 |
| `c` | 가운데 정렬 |
| `r` | 오른쪽 정렬 |
| `p{폭}` | 고정 너비, 자동 줄바꿈 |
| `\|` | 세로 구분선 |

```latex
% 셀 병합
\multicolumn{3}{c}{가로 3칸 병합}
\multirow{2}{*}{세로 2칸 병합}   % multirow 패키지 필요
```

---

## 8. 상호 참조

```latex
% 라벨 붙이기
\section{서론} \label{sec:intro}
\begin{equation}...\end{equation} \label{eq:main}
\caption{설명} \label{fig:result}   % \caption 뒤에!

% 참조
\ref{sec:intro}       % → "1"
\eqref{eq:main}       % → "(1)"  수식 전용, 괄호 자동
\pageref{fig:result}  % → 페이지 번호
```

> ⚠️ **흔한 실수 두 가지**  
> 1. `\label`을 `\caption` 앞에 두면 잘못된 번호 참조  
> 2. 같은 라벨을 서브섹션과 표에 동시 사용 → "Table IV-B3" 같은 오류

---

## 9. 참고문헌

```latex
% 본문 인용 — 구두점 안쪽
결과가 나타났다 [1].
\cite{bib1}
\cite{bib1, bib2}   % cite 패키지가 자동 정렬

\begin{thebibliography}{99}
  \bibitem{bib1}
    J. Smith, ``논문 제목,'' {\it IEEE Trans. Signal Process.},
    vol. 68, pp. 1--10, 2020.
\end{thebibliography}
```

---

## 10. IEEE 전용 설정

### 문서 선언부

```latex
\documentclass[journal,twoside,web]{ieeecolor}
\usepackage{generic}
\usepackage{cite}
\usepackage{amsmath,amssymb,amsfonts}
\usepackage{algorithmic}
\usepackage{graphicx}
\usepackage{subfig}        % 다중 그림용
\usepackage{algorithm,algorithmic}
\usepackage{hyperref}
\hypersetup{hidelinks=true}
\usepackage{textcomp}

\markboth{\hskip25pc IEEE TRANSACTIONS AND JOURNALS TEMPLATE}
{Author \MakeLowercase{\textit{et al.}}: Title}
```

### 제목 & 저자

```latex
\title{논문 제목 (대소문자 혼용 / 전체 대문자 금지 / 수식 기호 금지)}

\author{
  First A. Author, \IEEEmembership{Fellow, IEEE},
  Second B. Author, and Third C. Author Jr., \IEEEmembership{Member, IEEE}
  \thanks{연구비 지원 정보}
  \thanks{First A. Author is with 소속기관, 주소 (e-mail: ...)}
  \thanks{Second B. Author is with ...}
}
\maketitle
```

### Abstract & Index Terms

```latex
\begin{abstract}
  % ✅ 150~250 단어 (저널마다 다름 — 해당 저널 가이드 확인 필수)
  % ✅ 한 단락, 자기완결적
  % ❌ 약어 (보편적 IEEE, SI 등 제외), 각주, 참조 번호 금지
  % ❌ 수식 번호, 표 금지
\end{abstract}

\begin{IEEEkeywords}
  % IEEE 공식 명칭은 "Keywords"가 아닌 "Index Terms"
  % ✅ 알파벳순, 첫 항목만 대문자
  % ✅ 2025 IEEE Taxonomy 기반 표준 용어 사용 권장
  Keyword one, keyword two, keyword three
\end{IEEEkeywords}
```

### 첫 단락 드롭캡

```latex
\section{Introduction}
\label{sec:introduction}

\IEEEPARstart{T}{his} document is...
%              ↑첫글자  ↑나머지
% 최소 2줄 이상 단락이어야 드롭캡 정상 동작
```

---

## 11. IEEE 그림 & 표 규칙

### 그림 (IEEE 권장 방식)

```latex
\begin{figure}[!t]
  \centerline{\includegraphics[width=\columnwidth]{fig1.png}}
  \caption{그림 설명. 캡션에 그림의 의미를 충분히 설명.}
  \label{fig1}
\end{figure}
```

### 해상도 요구사항 (IEEE Author Center 공식)

| 유형 | 최소 해상도 |
|------|-----------|
| 컬러 / 회색조 이미지 | **300 DPI** |
| Black & white Line art | **600 DPI** |
| 저자 사진 | **300 DPI** |

> ⚠️ 저널에 따라 다름 (일부는 컬러도 600 DPI). 제출 전 해당 저널 개별 확인 필수.

### 허용 포맷 & 크기

```
포맷:  .EPS / .PDF / .PS / .TIFF / .PNG / .MPS
       벡터 포맷은 모든 폰트 임베드 필수

크기:
  1컬럼          →  3.5인치 / 88mm
  2컬럼 전체 폭  →  7.16인치 / 181mm
  최대 높이      →  8.5인치 / 216mm
  저자 사진      →  1인치 × 1.25인치
```

### 파일 명명 규칙

```
그림:     성 앞 5글자 + 번호.확장자     ander1.tif
표:       성 앞 5글자.t번호.확장자      ander.t1.tif
저자 사진: 성 앞 5글자.확장자           oppen.tif
동명이인: 겹치는 자리에 이니셜 대체     oppmi.tif / oppmo.tif
```

---

## 12. IEEE 참고문헌 형식

### 단행본

```latex
G. O. Young, ``제목,'' in {\it 책 제목,} 2nd ed.,
J. Peters, Ed. New York, NY, USA: McGraw-Hill, 1964, pp. 15--64.
```

### 저널 논문

```latex
J. U. Duncombe, ``논문 제목,'' {\it IEEE Trans. Electron Devices},
vol. ED-11, no. 1, pp. 34--39, Jan. 1959, doi: 10.1109/TED.2016.2628402.
```

### 컨퍼런스 논문

```latex
D. B. Payne and J. R. Stern, ``논문 제목,''
in {\it Proc. IOOC-ECOC,} Boston, MA, USA, 1985, pp. 585--590.
```

### 학위논문

```latex
% 박사
J. O. Williams, ``논문 제목,'' Ph.D. dissertation,
Dept. Elect. Eng., Harvard Univ., Cambridge, MA, USA, 1993.

% 석사
N. Kawasaki, ``논문 제목,'' M.S. thesis,
Dept. Electron. Eng., Osaka Univ., Osaka, Japan, 1993.
```

### 특허 / 데이터셋 / 코드

```latex
% 특허
G. Brandli and M. Dick, ``특허 제목,'' U.S. Patent 4 084 217, Nov. 4, 1978.

% 데이터셋 (현행 IEEE 형식)
U.S. Dept. of Health, Aug. 2013, ``데이터셋 제목,''
Publisher, doi: 10.3886/ICPSR30122.v2.

% 코드 (현행 IEEE 형식)
T. D'Martin and S. Soares, 2019, ``코드 제목 (Version 1.0),''
Code Ocean, doi: 10.24433/CO.7212286.v1.
```

### 핵심 규칙 요약

```
✅ 저자명: 이니셜 먼저, 성 뒤  →  G. O. Young
✅ 논문 제목: 첫 단어만 대문자 (고유명사, 원소 기호 제외)
✅ 책/저널 제목: {\it 이탤릭체}
✅ 범위: pp. 15--64  (엔 대시 --)
❌ "Ref." 사용 금지  (문장 시작 "Reference [3] shows..." 는 허용)
```

---

## 13. IEEE 스타일 체크리스트

### ✅ 반드시 해야 할 것

```
□  소수점 앞 0:        0.25  (O)    /    .25  (X)
□  범위 표기:          "7 to 9" 또는 "7--9"    /    "7~9" (X)
□  부피 단위:          cm³  (O)    /    cc  (X)
□  치수:               0.1 cm × 0.2 cm    /    0.1 × 0.2 cm²  (X)
□  시간 단위:          s  (O)    /    sec  (X)
□  수식 참조:          \eqref{}  (O)    /    "Eq. (1)"  (X)
□  그림 참조:          Fig.  — 문장 시작 포함 항상 Fig.
□  표 참조:            Table I  — 약어 금지, 로마 숫자
□  약어 정의:          Abstract와 본문 각각 별도로 최초 사용 시 정의
□  Serial comma:       "A, B, and C"    /    "A, B and C"  (X)
□  수식 구두점:        문장 일부면 구두점 수식 안에 포함  $E=mc^2.$
□  \label 위치:        항상 \caption 뒤에
□  Index Terms:        알파벳순, 첫 항목만 대문자, 2025 IEEE Taxonomy 기반
□  복합 단위:          가운데점  A$\cdot$m$^{2}$
□  능동태:             "We observed" > "It was observed"
□  축약형 금지:        "do not"  (O)    /    "don't"  (X)
```

### ❌ 하지 말아야 할 것

```
□  제목 전체 대문자 금지
□  제목에 "(Invited)" 표기 금지
□  제목에 수식 기호 포함 금지  ← 2025 IEEE Author Center 권고
□  Abstract에 약어·각주·참조 번호 금지
□  Abstract에 수식 번호·표 금지
□  \eqnarray 사용 금지  →  align 또는 IEEEeqnarray
□  \nonumber를 array 환경 내부에서 사용 금지
□  동일 라벨을 서브섹션과 표에 동시 사용 금지
□  \label을 \caption 앞에 배치 금지
□  그림 안에 캡션 포함 금지
□  그림 외부에 테두리(border) 추가 금지
□  SI + CGS 단위 혼용 금지
□  subcaption 패키지 사용 주의  →  subfig 사용
□  "remnant/remnance"  →  "remanent/remanence"
□  "micron"  →  "micrometer"
□  "while" (동시 사건 외)  →  "whereas"
□  "essentially" (≈ 의미)  →  "approximately"
□  "issue" (문제 의미)  →  "problem"
□  자동 endnote 사용 금지
□  "Ref." 사용 금지  (문장 시작 제외)
```

---

## 14. 알고리즘 작성

```latex
\begin{algorithm}[H]
  \caption{알고리즘 이름.}
  \label{alg:name}
  \begin{algorithmic}
    \STATE {\textsc{TRAIN}}$(\mathbf{X}, \mathbf{T})$
    \STATE \hspace{0.5cm}$\textbf{select randomly } W \subset \mathbf{X}$

    \IF{조건}
      \STATE 실행문
    \ELSIF{조건2}
      \STATE 실행문
    \ELSE
      \STATE 실행문
    \ENDIF

    \FOR{$i = 1$ \TO $N$}
      \STATE 반복 내용
    \ENDFOR

    \WHILE{조건}
      \STATE 반복 내용
    \ENDWHILE

    \STATE \textbf{return} $결과값$
  \end{algorithmic}
\end{algorithm}
```

---

## 15. 저자 약력

```latex
% 사진 포함
\begin{IEEEbiography}[{%
  \includegraphics[width=1in,height=1.25in,clip,keepaspectratio]{photo.png}
}]{First A. Author}
  % 1단락: 생년월일/장소(선택), 학력
  % 2단락: he/she 사용 (성 직접 언급 금지), 경력, 현 직책(위치 필수)
  % 3단락: 직함+성, 전문학회 멤버십, 수상
\end{IEEEbiography}

% 사진 없음
\begin{IEEEbiographynophoto}{Second B. Author}
  photograph and biography not available at the time of publication.
\end{IEEEbiographynophoto}
```

---

## 16. 버전별 변경사항 & 패키지 충돌 주의

### IEEEtran.cls 버전 히스토리

| 버전 | 주요 변경 |
|------|---------|
| v1.7 (2007) | `\IEEEbiography`, `\IEEEkeywords`, `\IEEEPARstart` 등 IEEE 접두사 명령 도입. 구형 명령 사용 시 경고 출력 후 동작 |
| v1.8 (2012) | `\IEEEcompsoctitleabstractindextext` → `\IEEEtitleabstractindextext` 로 이름 변경. `transmag` 옵션 추가 |
| v1.8a (2014) | Computer Society 포맷 전면 개편. `\IEEEraisesectionheading` 추가 |
| **v1.8b (2015~현재)** | `comsoc` 모드 추가. **현재 CTAN 최신 버전** |

### 패키지 호환성

| 패키지 | IEEEtran 상태 | 비고 |
|--------|-------------|------|
| `subfig` | ✅ 공식 지원 | 다중 그림 권장 |
| `subcaption` | ⚠️ 충돌 가능 | caption 패키지 의존 문제 |
| `hyperref` | ✅ 호환 | `hidelinks=true` 권장 |
| `amsthm` | ⚠️ `\proof` 충돌 가능 | v1.7+ 내부 처리 |
| `caption` | ⚠️ 충돌 가능 | IEEEtran 기본 캡션 사용 권장 |

### 자주 발생하는 오류 & 해결

```latex
% 문제: 수식 번호 건너뜀 (예: (17) → (20))
% 원인: 빈 subequations 블록이 카운터를 증가시킴
% 해결: 사용하지 않는 subequations 블록 완전 삭제

% 문제: 그림/표 참조 번호 오류
% 원인: \label이 \caption 앞에 위치
% 해결: 항상 \caption{...} \label{...} 순서 준수

% 문제: Table IV-B3 같은 이상한 참조
% 원인: 서브섹션과 표에 동일 라벨 사용
% 해결: 라벨 이름 구분  \label{sec:xxx}  \label{tab:xxx}
```

---

## 부록: 유용한 명령어 모음

```latex
% 줄바꿈 & 페이지
\\              % 줄바꿈
\newpage        % 새 페이지
\clearpage      % float 전부 출력 후 새 페이지
\noindent       % 들여쓰기 없이

% 공백
\,              % 얇은 공백 (수식 dx 앞 관례)
\quad           % 1em
\qquad          % 2em
\hspace{1cm}    % 수평 고정
\vspace{0.5cm}  % 수직 고정
\hfill          % 남은 공간 채우기

% 특수문자
\%  \$  \&  \#  \_  \{  \}  \^{}  \~{}

% 따옴표 — 반드시 아래 방식
``큰따옴표''    % " 직접 입력 금지
`작은따옴표'

% 대시
--   % 엔 대시: 범위  pp. 1--10
---  % 엠 대시: 문장 단절

% 길이 변수
\textwidth    % 전체 텍스트 너비
\columnwidth  % 현재 컬럼 너비
\linewidth    % 현재 줄 너비
\textheight   % 텍스트 영역 높이
```

---

## 마치며 — 핵심 원칙 6가지

1. 하드코딩 숫자 대신 `\ref`, `\eqref`, `\cite` 사용
2. `eqnarray` 절대 금지 → `align` 또는 `IEEEeqnarray`
3. `\label`은 항상 `\caption` **뒤에**
4. IEEEtran에서 `subcaption` 대신 `subfig`
5. Index Terms는 **2025 IEEE Taxonomy** 기반 표준 용어 사용
6. 해상도·단어 수 등은 **해당 저널 가이드 개별 확인** 필수

---

*검증 출처: IEEEtran.cls v1.8b changelog (CTAN), IEEE Editorial Style Manual (Updated 25 March 2025),  
IEEE Author Center 공식 가이드, Overleaf amsmath 공식 문서, IEEE Author Center Magazines 가이드라인*
