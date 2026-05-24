[![Build PDF](https://github.com/kyagrd/hsbook-template/actions/workflows/build-pdf.yml/badge.svg)](https://github.com/kyagrd/hsbook-template/actions/workflows/build-pdf.yml)

# hsbook-template

IHaskell Jupyter Notebook 여러 개를 Jupytext로 동기화하고 Quarto로 묶어
**scrbook(KOMA-Script) + kotex** 기반의 한국어 LaTeX 책을 생성하는 저장소 템플릿입니다.

---

## 디렉토리 구조

```
hsbook-template/
├── .github/
│   └── workflows/
│       └── build-pdf.yml # GitHub Actions PDF 빌드 워크플로우
├── .gitignore
├── _quarto.yml            # Quarto 책 프로젝트 설정
├── index.qmd              # 머리말
├── ch00.qmd               # 0장
├── ch01.qmd               # 1장 (embed 통로)
├── ch02.qmd               # 2장 (embed 통로)
├── haskell-error-filter.lua # Quarto/Jupyter 에러 메시지 필터 스크립트
├── Makefile               # 빌드 자동화 명령 모음
├── chapters/              # embed로 가져오는 내용 (quarto에 등록 X)
│   ├── ch01.qmd           # 1장 Quarto Markdown 원본 (jupyter로 이것을 실행)
│   ├── ch01.ipynb         # 1장 Jupyter Notebook (jupytext 동기화로 자동 생성/업데이트)
│   ├── ch02.qmd           # 2장 Quarto Markdown 원본 (jupyter로 이것을 실행)
│   └── ch02.ipynb         # 2장 Jupyter Notebook (jupytext 동기화로 자동 생성/업데이트)
├── latex/
│   └── preamble.tex       # LaTeX 프리앰블 (kotex, scrbook 설정)
├── docker/
│   └── ihaskell-quarto-jupytext/
│       ├── Dockerfile     # IHaskell + Quarto + Jupytext 도커 이미지 빌드 파일
│       └── README.md      # 도커 이미지 빌드 및 실행 안내
├── run_iqj.sh             # ihaskell-quarto-jupytext 도커 컨테이너 실행 스크립트
├── references.bib         # BibTeX 참고문헌
└── README.md
```

---

## 사전 요구 사항

| 도구 | 설치 방법 |
|------|-----------|
| Jupyter 툴체인 (JupyterLab, Jupytext, nbconvert) | `pip install jupyterlab jupytext nbconvert` 또는 배포판 패키지로 설치 |
| IHaskell 커널 | Juypter Docker Stacks 기반 IHaskell 도커 이미지 [ihaskell-notebook](https://github.com/IHaskell/ihaskell-notebook)활용을 추천 |
| Quarto ≥ 1.4 | <https://quarto.org/docs/get-started/> |
| TeX 툴체인 | TeX Live 또는 MiKTeX 설치 후 KOMA-Script, kotex, XeLaTeX, LuaLaTeX 등 필요한 패키지 포함 |

Ubuntu(deb) 기준 Jupyter 툴체인 설치 명령 예시:
```bash
sudo apt update -y
sudo apt install -y jupyterlab python3-nbconvert jupytext
```

> **kotex**는 XeLaTeX/LuaLaTeX 환경에서 동작합니다.  
> TeX Live를 사용한다면 `texlive-lang-korean` 또는 `kotex` 패키지를 별도로 설치하세요.

GHC, Cabal 및 IHaskell 커널을 직접 빌드해 설치하려면 많은 메모리가 필요하고 GHC 버전 설정 등이 까다롭기 때문에 도커 이미지를 통해 활용하는 것을 권장합니다.
참고로, `docker/ihasekll-quarto-jupytext`의 도커 이미지를 빌드해 `run_iqj.sh`로 실행하여 활jupyterlab, quarto, jupytext가 함께 설치된 개발환경(단, LaTeX는 제외)을 활용할 수 있습니다.
도커 이미지를 통해 하스켈 주피터 노트북을 편집/실행하고 HTML이나 LaTeX 소스코드 뽑는 정도까지만 하고, 실제 LaTeX빌드는 로컬 환경(혹은 별도의 TexLive 도커 이미지 등)에서 pdf를 생성하는 작업 방식을 추천합니다.
이 경우 quarto를 로컬에도 중복으로 설치하여 quarto가 pandoc을 통해 LaTeX과 pdf를 생성하는 과정을 처리하도록 맡기는 것이 편리합니다.

이 이미지를 활용할 정도면 이미 LaTeX 환경은 설치해 놓은 경우가 많을 것이라서 불필요하게 도커 이미지 크기를 키우지 않기 위해 이런 작업 방식을 추천한 것이지만, LaTeX이 로컬에 설치되지 않았고 설치할 계획도 없다면,
`docker/ihasekll-quarto-jupytext`의 Dockerfile에 TinyTeX 또는 TexLive및 필요한 LaTeX 패키지를 설치하도록 설정을 추가하여 활용하는 방법도 가능합니다.

---

## 빠른 시작

### 1. 저장소 복제

```bash
git clone https://github.com/<your-org>/hsbook-template.git
cd hsbook-template
```

### 2. HTML 미리보기

```bash
quarto preview
```

### 3. LaTeX 및 PDF 빌드
LaTeX 소스코드까지만 생성하려면
```bash
quarto render --to latex
```
Pandoc을 통해 pdf까지 한번애 생성하려면
```bash
quarto render --to pdf
```
그냥 아무 옵션 없이 이렇게 실행시키면 html과 pdf 모두 생성
```bash
quarto render
```


빌드 결과물은 `_book/` 디렉토리에 생성됩니다.



---

## Jupytext 사용법

`.qmd`와 `.ipynb` 파일은 항상 쌍으로 존재합니다.  
편집과 실행은 `.qmd` 파일을 통해 진행하고
그러한 변경 결과를 `.ipynb` 파일로 동기화합니다.
참고로, `.ipynb` 파일은 한번 실행한 결과를 포함하여 pdf로
렌더링하기 위한 자료이면서 `nbconvert`를 통해 html 렌더링에
도움이 되는 `.md` 파일을 생성하는 데(`Makefile` 참고)도 활용됩니다. 

```bash
# .qmd 파일을 수정한 뒤 .ipynb에 반영
jupytext --sync chapters/ch01.qmd

# .ipynb 파일을 수정한 뒤 .qmd에 반영
jupytext --sync chapters/ch01.ipynb

# 모든 파일 일괄 동기화
jupytext --sync chapters/*.ipynb
```

JupyterLab에서는 **Jupytext 확장**을 설치하면 저장 시 자동으로 동기화됩니다:

```bash
pip install jupyterlab-jupytext
```

그러니 JupyterLab에서는 `.qmd` 파일만 편집/실행하면 됩니다. 

---

## 새 챕터 추가
1. `chapters/chXX.qmd` 파일을 생성합니다.
1. YAML 프런트 매터에 IHaskell 커널을 지정합니다:
   ```yaml
   ---
   title: "챕터 제목"
   jupyter:
     jupytext:
       formats: ipynb,qmd:quarto  # sync 설정
       text_representation:
         extension: .qmd
         format_name: quarto
         format_version: '1.0'
         jupytext_version: 1.19.1
     kernelspec:
       display_name: Haskell
       language: haskell
       name: haskell
   ---
   ```
1. Jupytext로 `.ipynb` 파일을 생성합니다:
   ```bash
   jupytext --to ipynb chapters/chXX.qmd
   ```
1. `chXX.qmd` 파일을 생성하고 `chapters/chXX.qmd`를 embed 합니다.
   (HTML 생성도 고려한다면 nbconvert로 ipynb에서 md를 생성해 include하는 것을 추천)
1. `_quarto.yml`의 `chapters:` 목록에 `chXX.qmd` 파일을 추가합니다.

---

## LaTeX 커스터마이징

`latex/preamble.tex`에서 폰트·레이아웃 등을 조정할 수 있습니다.

```latex
% 시스템에 설치된 한글 폰트로 교체 (예시)
\setmainfont[Ligatures=TeX]{Noto Serif CJK KR}
\setsansfont{Noto Sans CJK KR}
\setmonofont{Hack}
```

`_quarto.yml`에서 문서 클래스 옵션을 조정할 수 있습니다:

```yaml
format:
  pdf:
    documentclass: scrbook   # KOMA-Script book class
    classoption:
      - twoside              # 양면 인쇄
      - 12pt
    pdf-engine: xelatex
    include-in-header: latex/preamble.tex
```

---

## 참고 문헌

- [Quarto Books](https://quarto.org/docs/books/)
- [IHaskell](https://github.com/IHaskell/IHaskell)
- [Jupytext](https://jupytext.readthedocs.io/)
- [KOMA-Script (scrbook)](https://ctan.org/pkg/koma-script)
- [kotex](https://www.ctan.org/pkg/kotex)
