-- haskell-error-filter.lua
function CodeBlock(el)
  -- 하스켈 에러 메시지 패턴 감지
  if el.text:find("<interactive>:") and el.text:find("error:") then
    
    -- 1. 맨 앞의 불필요한 콜론(:) 제거
    local cleaned_text = el.text:gsub("^:%s*", "")
    el.text = cleaned_text

    -- 2. LaTeX 렌더링 시 커스텀 에러 박스 주입
    if FORMAT == "pdf" or FORMAT == "latex" then
      return {
        pandoc.RawBlock("latex", "\\begin{stderrbox}\\vspace{-0.7em}"),
        el,
        pandoc.RawBlock("latex", "\\vspace{-0.9em}\\end{stderrbox}")
      }
    end
  end
end