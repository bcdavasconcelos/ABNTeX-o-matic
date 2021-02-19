# ABNTeX-o-matic

(em preparação)

Para converter arquivos de texto em markdown para arquivos PDF, o Pandoc pode utilizar dois caminhos: LaTeX e HTML. Ou seja, ele faz o caminho `Markdown → LaTeX/HTML → PDF`. Ambos caminhos pressupõe a existência de um modelo que determina onde cada elemento do arquivo de texto fonte deve aparecer no produto final — de outro modo o mecanismo de conversão não teria como saber qual parte do texto integra os elementos pré-textuais (*e.g.* abreviações, agradecimentos) e qual contém o corpo do texto propriamente.  

A preparação de um modelo para conversão via LaTeX (usando um mecanismo chamado XeLaTeX) é mais complexa e difícil, mas os resultados são muito superiores àqueles obtidos com a conversão via HTML. Por isso, é interessante contar com modelos para fazer a conversão de artigos, dissertações e teses de doutorado seguindo os padrões da ABNT. Infelizmente, todos os projetos que se encarregavam de manter esses modelos — e de atualizá-los — foram abandonados, de modo que não há no momento (Fev 2021) nenhum template funcional disponível para esse fim.  

Para sanar essa demanda e gerar o arquivo final do meu próprio trabalho, preparei um novo modelo utilizando como fonte o [Mimosis](https://github.com/Pseudomanifold/latex-mimosis).  

![](/Samples/2021-02-17_20-00-08.png)
![](/Samples/2021-02-17_19-56-59.png)
![](/Samples/2021-02-17_19-57-26.png)
![](/Samples/2021-02-17_19-57-42.png)

A rigor, esse template diverge em detalhes muito pequenos das normas da ABNT. As margens, por exemplo, não são 3,3,2,2cm; ao invés disso, elas são automaticamente calculadas pelo mecanismo de conversão para obter o melhor resultado possível no posicionamento do texto.  

## Fonte em Markdown

Toda a tese pode ser gerada a partir de um simples arquivo em formato markdown com um cabeçalho YAML.

```markdown
---
### Opções ###
capa: true
sumario: true
alegreyamainfont: true
mainfont: ''
sansfont: ''
monofont: ''
### Metadados ###
autor:
titulo:
faculdade:
subtitulo:
lugar:
ano:
tipodetrabalho:
curso:
faculdade:
grau:
orientador:
linhadepesquisa:
dedicatoria:
agradecimentos:
epigrafe:
advertencia:
resumo:
abstract:
abreviacoes:  
---


# Capítulo 1

Introdução ao capítulo 1

## Seção 1

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum (@Metaph_Ross_a, p. 134).

## Seção 2

Lorem ipsum dolor sit amet (@Rossi2013, p. 10), consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

# Capítulo 2

Introdução ao capítulo 2

## Seção 1

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum (@Carr2005, p. 90).

## Seção 2

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum (@deHaas2004, p. 4).

# Bibliografia {-}



::: {#refs}
:::

```

## Comando para a conversão

Adicione o arquivo `abntex-o-matic.latex` à pasta de templates do Pandoc.   

**Windows:** `C:\Users\USERNAME\AppData\Roaming\pandoc`  
**Mac:** `$HOME/.local/share/pandoc`   

Se você quiser que o Pandoc cuide da bibliografia, adicione também à pasta os arquivos de estilo ([ABNT-FA.csl](https://github.com/bcdavasconcelos/CSL-ABNT-para-Autores-Antigos/blob/main/Pandoc/ABNT-FA.csl)) e da bibliografia em formato BibTeX ou JSON. Em caso de dúvida, consulte [a documentação do pandoc](https://pandoc.org/MANUAL.html#citations) ou abra um `issue` neste repositório.  

```bash

/usr/local/bin/pandoc -s -f markdown "Sample.md" --metadata link-citations=true --pdf-engine=xelatex -C "--csl=ABNT-FA.csl" "--bibliography=All.json" "--template=abntex-o-matic.latex" -o "Sample".pdf && open "Sample".pdf

```

Para entender um pouco mais sobre como funcionam os comandos do Pandoc, [confira esta página](https://gdct.blot.im/pandoc).  


## Agradecimentos

Outros projetos que não foram mencionados, mas que tornaram o ABNTeX-o-matic possível:

A inspiração veio do [Scrivomatic](https://github.com/iandol/scrivomatic) e foi possível graças ao [Pandocomatic](https://github.com/htdebeer/pandocomatic).

O template LaTeX veio em grande medida do [Mimosis](https://github.com/Pseudomanifold/latex-mimosis).

Algumas ideias para a adaptação do template Mimosis para a ABNT vieram do [Limarka](https://github.com/abntex/trabalho-academico-limarka).
