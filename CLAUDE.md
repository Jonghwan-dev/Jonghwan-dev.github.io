# Claude Code Rules — Jonghwan-dev.github.io

## 수정 주석 규칙 (필수)

파일을 수정할 때는 변경 위치에 반드시 아래 형식의 주석을 추가한다.

```
# YYYY-MM-DD_JHKim : 수정내용
```

언어별 주석 형식:
- TOML / YAML / Shell : `# YYYY-MM-DD_JHKim : 수정내용`
- HTML / Hugo template : `{{- /* YYYY-MM-DD_JHKim : 수정내용 */ -}}`
- SCSS / CSS : `// YYYY-MM-DD_JHKim : 수정내용`
- Markdown front matter : `# YYYY-MM-DD_JHKim : 수정내용` (front matter 블록 상단)

날짜는 수정 당일 날짜(YYYY-MM-DD)를 사용한다.

---

## 프로젝트 개요

Hugo + Stack 테마 기반 기술 블로그.

- **URL**: https://jonghwan-dev.github.io/
- **테마**: hugo-theme-stack (submodule: `themes/stack`)
- **배포**: GitHub Actions → `gh-pages` 브랜치 → GitHub Pages

## 카테고리 구조 (5개)

| 카테고리 | URL | 서브태그 |
|----------|-----|---------|
| Deep Learning | `/categories/deep-learning/` | `fundamental`, `computer-vision`, `vlm` |
| Medical AI | `/categories/medical-ai/` | `medical-ai`, `dicom` |
| Tools | `/categories/tools/` | `latex`, `docker`, `git` |
| Paper Review | `/categories/paper-review/` | `paper-review` |
| Engineering | `/categories/engineering/` | `mlops`, `fastapi` |

## 포스트 front matter 템플릿

```yaml
---
title: ""
date: YYYY-MM-DD
draft: true
description: ""
image: ""
tags: []
categories: []
---
```

새 포스트: `make new SLUG=포스트-슬러그`

## GitHub Actions 주의사항

- `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: "true"` env를 워크플로에 유지한다.
- `peaceiris/actions-hugo@v3` + `peaceiris/actions-gh-pages@v4` 조합을 유지한다.
- Pages 소스: GitHub 저장소 Settings → Pages → Source = **Deploy from gh-pages branch**.
- 이 조합을 다른 것으로 교체하지 말 것 (교체 시 Pages 설정도 함께 변경 필요).

## 로컬 개발

```bash
make submodule   # 최초 clone 후 테마 초기화
make serve       # 개발 서버 (http://localhost:1313, 드래프트 포함)
make build       # 배포용 빌드
make clean       # 빌드 결과물 삭제
```

## .gitignore 규칙

`public/`, `resources/_gen/`, `.hugo_build.lock` 은 절대 커밋하지 않는다.
