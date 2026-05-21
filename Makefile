# 확장자 규칙: .ipynb가 업데이트되면 .md를 새로 생성
CHAPTERS_DIR = chapters
NOTEBOOKS = $(wildcard $(CHAPTERS_DIR)/*.ipynb)
MARKDOWNS = $(patsubst %.ipynb, %.md, $(NOTEBOOKS))

.PHONY: all clean render

all: $(MARKDOWNS) render

# 로컬에서 실행 (하스켈 커널 필요 없음)
%.md: %.ipynb
	jupyter nbconvert --to markdown --TagRemovePreprocessor.enabled=True --no-prompt $<

# 최종 책 렌더링 (--to pdf 또는 --to html 옵션은 필요에 따라 선택)
render:
	quarto render

clean:
	rm -f $(CHAPTERS_DIR)/*.md
