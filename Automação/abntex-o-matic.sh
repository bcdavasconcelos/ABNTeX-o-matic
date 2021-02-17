#!/bin/zsh
PATH=$PATH:/usr/local/bin:/Library/TeX/texbin:/usr/texbin

#cd "..."
/usr/local/bin/pandoc -s -f markdown "Sample.md" --metadata link-citations=true --pdf-engine=xelatex -C "--csl=./ABNT-FA.csl" "--bibliography=./All.json" "--template=./abntex-o-matic.latex" --top-level-division=chapter --toc -o "Sample".pdf && open "Sample".pdf