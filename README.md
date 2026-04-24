# hsbook-template

[![Build PDF](https://github.com/kyagrd/hsbook-template/actions/workflows/build-pdf.yml/badge.svg)](https://github.com/kyagrd/hsbook-template/actions/workflows/build-pdf.yml)

IHaskell Jupyter Notebook 여러 개를 Jupytext로 동기화하고 Quarto로 묶어
**scrbook(KOMA-Script) + kotex** 기반의 한국어 LaTeX 책을 생성하는 저장소 템플릿입니다.

---

## 디렉토리 구조

```
hsbook-template/
├── _quarto.yml            # Quarto 책 프로젝트 설정
├── index.qmd              # 머리말
├── chapters/
│   ├── ch01.qmd           # 1장 Quarto Markdown 원본
│   ├── ch01.ipynb         # 1장 Jupyter Notebook (jupytext 동기)
│   ├── ch02.qmd           # 2장 Quarto Markdown 원본
│   └── ch02.ipynb         # 2장 Jupyter Notebook (jupytext 동기)
├── latex/
│   └── preamble.tex       # LaTeX 프리앰블 (kotex, scrbook 설정)
├── references.bib         # BibTeX 참고문헌
├── .jupytext.toml         # Jupytext 페어링 설정
└── .gitignore
```

---

## 사전 요구 사항

| 도구 | 설치 방법 |
|------|-----------|
| GHC / Cabal | `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org \| sh` |
| IHaskell 커널 | `cabal install ihaskell && ihaskell install` |
| Jupyter | `pip install jupyter jupyterlab` |
| Jupytext | `pip install jupytext` |
| Quarto ≥ 1.4 | <https://quarto.org/docs/get-started/> |
| XeLaTeX + kotex | TeX Live 또는 MiKTeX 설치 후 `kotex`, `scrbook(KOMA-Script)` 패키지 포함 |

> **kotex**는 XeLaTeX/LuaLaTeX 환경에서 동작합니다.  
> TeX Live를 사용한다면 `texlive-lang-korean` 또는 `kotex` 패키지를 별도로 설치하세요.

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

### 3. PDF(LaTeX) 빌드

```bash
quarto render --to pdf
```

빌드 결과물은 `_book/` 디렉토리에 생성됩니다.

---

## Jupytext 사용법

`.qmd`와 `.ipynb` 파일은 항상 쌍으로 존재합니다.  
**편집 후 반드시 동기화**하여 두 파일을 일치시키세요.

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

---

## 새 챕터 추가

1. `chapters/chXX.qmd` 파일을 생성합니다.
2. YAML 프런트 매터에 IHaskell 커널을 지정합니다:

   ```yaml
   ---
   title: "챕터 제목"
   jupyter:
     kernelspec:
       display_name: Haskell
       language: haskell
       name: haskell
   ---
   ```

3. Jupytext로 `.ipynb` 파일을 생성합니다:

   ```bash
   jupytext --to ipynb chapters/chXX.qmd
   ```

4. `_quarto.yml`의 `chapters:` 목록에 새 파일을 추가합니다.

---

## LaTeX 커스터마이징

`latex/preamble.tex`에서 폰트·레이아웃 등을 조정할 수 있습니다.

```latex
% 시스템에 설치된 한글 폰트로 교체 (예시)
\setmainfont[Ligatures=TeX]{Noto Serif CJK KR}
\setsansfont{Noto Sans CJK KR}
\setmonofont{D2Coding}
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
