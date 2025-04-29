# ITinerant Blog

이 블로그는 Jonghwan Kim(김종환)의 개인 기술 블로그로, AI, 딥러닝, 의료 영상, 유방 초음파 등 다양한 IT 주제의 학습과 경험을 공유합니다.

## 소개
- **저자:** Jonghwan Kim (itinerant developer)
- **주요 주제:** AI, Deep Learning, Medical Imaging, Breast Ultrasound, 개발 노트 등
- **블로그 목적:** 최신 기술 트렌드와 연구, 실습 경험, 프로젝트 기록, 개발 팁 공유

## 설치 및 실행 방법
1. 저장소를 클론하거나 [다운로드](https://github.com/Jonghwan-dev/Jonghwan-dev.github.io/archive/refs/heads/main.zip) 후 압축을 풉니다.
2. 터미널에서 프로젝트 루트 디렉터리(`_config.yml`이 위치한 곳)로 이동합니다.
3. Ruby와 Bundler가 설치되어 있어야 합니다. (Bundler 설치: `gem install bundler`)
4. 의존성 설치: `bundle install`
5. 로컬 서버 실행: `bundle exec jekyll serve`
6. 브라우저에서 [http://localhost:4000/](http://localhost:4000/) 접속

## 주요 폴더 및 파일 설명
- `_config.yml`: 블로그 전체 설정 파일
- `_posts/`: 마크다운 형식의 블로그 글 저장 폴더
- `_data/`, `_includes/`, `_layouts/`: Jekyll 및 Hydejack 테마 커스터마이징용 폴더
- `assets/`: 이미지, CSS, JS 등 정적 파일
- `Gemfile`: 루비 젬(의존성) 관리 파일
- `README.md`: 현재 문서, 블로그 소개 및 사용법

## 커스터마이징 방법
- `_config.yml`에서 블로그 제목, 설명, 태그라인 등 기본 정보를 변경할 수 있습니다.
- Hydejack 테마의 다양한 옵션은 [Hydejack 공식 문서](https://hydejack.com/docs/)를 참고하세요.
- 필요에 따라 `_includes/`, `_layouts/` 폴더의 파일을 수정해 레이아웃을 변경할 수 있습니다.

## 라이선스
- 본 블로그는 개인 학습 및 공유 목적입니다.
- Hydejack 테마는 [Hydejack 라이선스](https://hydejack.com/license/)를 따릅니다.
- 본문 및 코드의 2차 사용 시 출처를 명시해 주세요.

---
문의 및 피드백: [이메일](mailto:army@ncc.re.kr) 또는 GitHub 이슈를 이용해 주세요.