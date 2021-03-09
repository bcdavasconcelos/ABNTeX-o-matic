# ABNTeX-o-matic

*Em preparação*

Uma tese ou dissertação pode ser preparada utilizando um processador de texto convencional, como o Word, ou utilizando apenas texto plano em Markdown — uma linguagem leve, simples e fácil de aprender. Dentre as vantagens oferecidas por esta última abordagem, encontramos a possibilidade de produzir um documento final de alta qualidade tipográfica em qualquer formato de divulgação concebível, como PDF, DOCX, HTML, EPUB, etc. Além de produzir resultados superiores, não há qualquer necessidade de gastar tempo formatando trabalhos e adequando-os às regras da ABNT. Isso acontece *automagicamente*. Tudo isso é possível graças a um conversor universal de documentos, gratuito e *open-source*, chamado Pandoc.

## A necessidade de um modelo  

A conversão de texto em markdown para arquivos PDF no Pandoc pode acontecer por duas vias: LaTeX ou HTML. Dizendo de outro modo, ele faz o caminho `Markdown → LaTeX → PDF` ou `Markdown → HTML → PDF`. Ambos pressupõe a existência de um modelo que determina onde cada elemento do arquivo de texto fonte deve aparecer no produto final — de outro modo o mecanismo de conversão não teria como saber qual parte do texto integra os elementos pré-textuais (*e.g.* abreviações, agradecimentos) e qual contém o corpo do texto.  

O resultado de uma conversão utilizando LaTeX é bastante superior àquele que poderíamos obter via HTML. A preparação de um modelo, entretanto, é consideravelmente mais difícil. Todos os projetos que se encarregavam de manter modelos baseados nas normas da ABNT foram abandonados nos últimos anos e em Fev 2021 não havia qualquer opção funcional disponível para este fim. O **ABNTeX-o-matic** é uma tentativa de preencher esta falta e oferecer uma opção simples e prática para estudantes de qualquer universidade brasileira. Para quem estiver se perguntando acerca da origem do nome do projeto, trata-se de um chiste inspirado pelos projetos Pandoc, Pandocomatic e Scrivomatic.

O ABNTeX-o-matic nada mais é do que uma laboriosa adaptação do [Mimosis](https://github.com/Pseudomanifold/latex-mimosis) com inúmeros acréscimos para facilitar a produção de um documento final acabado sem a necessidade de editar arquivos em qualquer outro formato complexo (*e.g.* LaTeX). Tudo acontece automaticamente a partir do texto em markdown.


## Funcionamento do template

Todos os elementos do trabalho que não fazem parte do corpo do texto propriamente — isto é, dos capítulos centrais que são numerados — são geradas automaticamente a partir das variáveis que são inseridas do documento em blocos de código no formato YAML. 

Blocos nesse formato devem respeitar as seguintes regras:

- Delimite o bloco utilizando `---` antes do início e depois do fim. 
- Sempre salte uma linha antes do início e depois do fim.
- Eles podem ser inseridos em qualquer parte do texto, pois não fazem parte do texto propriamente e não aparecem no documento final nesse formato.

Este exemplo é baseado [na documentação](https://pandoc.org/MANUAL.html#metadata-blocks) do Pandoc:

```yaml
---
title:  'Título'
author:
- Aristocles
- Platão
keywords: [forma, ideia]
abstract: |
  Resumo com múltiplos parágrafos.

  É preciso saltar dois espaços em branco antes de dar início ao texto.
---
```

O uso das aspas para proteger o valor de alguns campos é indicado sempre que houver algum caracter especial (*e.g.* uma vírgula) no texto. Na dúvida, proteja o valor utilizando aspas ou inserindo uma barra vertical `|` e registrando o valor na linha abaixo.

Para a conveniência dos possíveis usuários, o template foi criado **com variáveis em português**. Deve-se utilizar, portanto, `autor` e não `author`, `titulo` e não `title`, e assim por diante.


## Capa e contracapa

Para gerar uma capa, é preciso que se tenha definido as seguintes variáveis: `autor`, `titulo`, `instituicao`, `lugar` e `ano`. Se a capa não for gerada, isso é um indício de que alguma variável está sem valor.

```yaml
---
autor: 'João Sebastião Ribeiro'
titulo: 'A insustentável leveza dos entes matemáticos'
instituicao: 'Faculdade de Filosofia e Ciências Humanas da Universidade Federal de Minas Gerais'
lugar: 'Belo Horizonte - MG'
ano: '2021'
---
```

Para gerar uma contracapa, é preciso que se tenha definido as variáveis supracitadas e ainda: `contracapa` OU `grau`, `curso`, `tipodetrabalho`, `linhadepesquisa` e `orientador`.  

**Opção 1:**  

```yaml
---
contracapa: 'Tese apresentada ao programa de Pós-Graduação em Filosofia da Universidade Federal de Minas Gerais, como requisito parcial para a obtenção do título de Doutor em Filosofia.'
---
```

**Opção 2 (recomendada):**  

```yaml
---
grau: 'Doutor'
curso: 'Filosofia'
tipodetrabalho: 'Tese'
linhadepesquisa: 'Filosofia Antiga e Medieval'
---
```


![](/img/2021-02-17_20-00-08.png)  
![](/img/2021-02-17_19-56-59.png)  


## Elementos pré-textuais  

Para os elementos pré-textuais que demandam mais espaço, o mais indicado é utilizar a barra vertical e o texto indentado com dois espaços em branco logo abaixo. 

```YAML
resumo: |
  Texto do resumo...
```

Uma outra opção, mais natural, envolve criar uma seção de texto para esses elementos (`dedicatoria`,`agradecimentos`, `epigrafe`, `advertencia`, `resumo`, `abstract`, `abreviacoes`) e acrescentar um filtro no comando que se encarregará de converte-los em blocos de metadados. Os filtros para essa finalidade estão todos disponíveis no repositório.   

**Exemplo:**  

```markdown

# Dedicatoria

Dedico o trabalho...

# Agradecimentos

Agradeço a...

# Epigrafe

ἡ δὲ κρίσις περὶ τούτων ἐν τῷδ’ ἔστιν· ἔστιν ἢ οὐκ ἔστιν
Parmênides  

# Resumo

Texto do resumo...

# Abstract

The text deals with...

# Advertencia

Uma advertência...
```

**Observe que o título da seção deve ser idêntico ao nome da variável: sem qualquer acentos.**

## Como funciona o Pandoc



![](/img/2021-02-17_19-57-26.png)
![](/img/2021-02-17_19-57-42.png)

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
