.PHONY: serve build new clean submodule

# 로컬 개발 서버 (드래프트 포함, http://localhost:1313)
serve:
	hugo server -D --disableFastRender

# 배포용 빌드
build:
	hugo --minify

# 새 포스트 생성: make new SLUG=my-post-title
new:
	hugo new post/$(SLUG)/index.md

# 빌드 결과물 삭제
clean:
	rm -rf public resources/_gen .hugo_build.lock

# 테마 서브모듈 초기화 (최초 clone 후)
submodule:
	git submodule update --init --recursive
