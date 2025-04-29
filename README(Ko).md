# ITinerant Blog

이 공간은 'Jonghwand Kim's Tech blog' 입니다.   
AI, 딥러닝, 의료 영상 처리 등 다양한 IT 주제의 학습과 경험을 공유하고자 합니다.

## 소개
- **저자:** Jonghwan Kim (itinerant developer)
- **주요 주제:** AI, Deep Learning, Medical Imaging, 개발 노트, 영어 학습
- **목적:**  
  최신 기술 트렌드, 연구 리뷰, 프로젝트 실습, 개발 경험, 그리고 실용적인 팁을 기록하고 공유하여 지속적인 학습과 성장을 지원하는 것

## 설치 및 실행 방법
1. 저장소를 클론하거나 [ZIP 파일 다운로드](https://github.com/Jonghwan-dev/Jonghwan-dev.github.io/archive/refs/heads/main.zip) 후 압축을 풉니다.
2. 터미널을 열고 프로젝트 루트 디렉터리(`_config.yml`이 위치한 곳)로 이동합니다.
3. Ruby와 Bundler가 설치되어 있어야 합니다.  
   Bundler 설치가 필요한 경우:
   ```bash
   gem install bundler
   ```
4. 의존성 설치:
   ```bash
   bundle install
   ```
5. 로컬 서버 실행:
   ```bash
   bundle exec jekyll serve
   ```
6. 브라우저에서 [http://localhost:4000/](http://localhost:4000/) 접속합니다.

## 주요 폴더 및 파일 구조
- `_config.yml` — 블로그 전체 설정 파일
- `_posts/` — 마크다운 형식의 블로그 글 저장 폴더
- `_data/`, `_includes/`, `_layouts/` — Jekyll 및 Hydejack 테마 커스터마이징용 폴더
- `_featured_categories/` — 카테고리 설명 및 구조 정의
- `assets/` — 이미지, CSS, JavaScript 등 정적 파일 저장
- `Gemfile` — 루비 젬(의존성) 관리 파일
- `README.md`, `README(ko).md` — 블로그 개요 및 사용법 문서

## 커스터마이징 방법
- `_config.yml` 파일에서 블로그 제목, 설명, 태그라인 등 기본 정보를 수정할 수 있습니다.
- 테마 관련 다양한 설정은 [Hydejack 공식 문서](https://hydejack.com/docs/)를 참고하세요.
- `_includes/` 및 `_layouts/` 폴더의 파일을 수정하여 레이아웃을 커스터마이징할 수 있습니다.

## 라이선스
- 본 블로그는 개인 학습, 문서화, 지식 공유를 목적으로 운영됩니다.
- 사이트는 [Hydejack 테마](https://hydejack.com/license/)를 사용하며, 해당 라이선스를 따릅니다.
- 블로그 본문이나 코드 일부를 활용할 경우, 반드시 출처를 명시해 주세요.

---

## 문의
문의, 협업 제안 또는 피드백은 아래를 통해 가능합니다.  
📧 [이메일](mailto:army@ncc.re.kr)  
🐙 [GitHub Issues](https://github.com/Jonghwan-dev/Jonghwan-dev.github.io/issues)
