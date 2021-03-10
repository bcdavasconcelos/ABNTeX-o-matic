# ABNTeX-o-matic

*Em preparação*

Uma tese ou dissertação pode ser preparada utilizando um processador de texto convencional, como o Word, ou utilizando apenas texto plano em Markdown — uma linguagem leve, simples e fácil de aprender. Dentre as vantagens oferecidas por esta última abordagem, encontramos a possibilidade de produzir um documento final de alta qualidade tipográfica em qualquer formato de divulgação concebível, como PDF, DOCX, HTML, EPUB, LaTeX, XML, ODT, RTF, PPTX, etc. Além de produzir resultados superiores, não há qualquer necessidade de gastar tempo formatando trabalhos e adequando-os às regras da ABNT. Isso acontece *automagicamente*. Tudo isso é possível graças a um conversor universal de documentos, gratuito e *open-source*, chamado [Pandoc](https://pandoc.org).

## A necessidade de um modelo  

A conversão de texto em markdown para arquivos PDF no Pandoc pode acontecer por duas vias: LaTeX ou HTML. Dizendo de outro modo, ele faz o caminho `Markdown → LaTeX → PDF` ou `Markdown → HTML → PDF`. Ambos pressupõe a existência de um modelo que determina onde cada elemento do arquivo de texto fonte deve aparecer no produto final — de outro modo o mecanismo de conversão não teria como saber qual parte do texto integra os elementos pré-textuais (*e.g.* abreviações, agradecimentos) e qual contém o corpo do texto.  

O resultado de uma conversão utilizando LaTeX é bastante superior àquele que poderíamos obter via HTML. A preparação de um modelo, entretanto, é consideravelmente mais difícil. Prova disso é que todos os projetos que se encarregavam de manter modelos baseados nas normas da ABNT foram abandonados ao longo destes últimos anos (e.g. [abnTeX](https://www.abntex.net.br)). Para preencher esta lacuna, criei este projeto template chamado **ABNTeX-o-matic**, que oferecer uma opção simples e prática para estudantes de qualquer universidade brasileira. A rigor, esse template diverge em detalhes muito pequenos das normas da ABNT. (As margens, por exemplo, não são 3, 3, 2, 2cm; ao invés disso, elas são automaticamente calculadas pelo mecanismo de conversão para obter o melhor resultado possível no posicionamento do texto.) Incorporar esta regra seria possível, mas os resultados são claramente inferiores.  

O ABNTeX-o-matic nada mais é do que uma laboriosa adaptação do [Mimosis](https://github.com/Pseudomanifold/latex-mimosis) com inúmeros acréscimos para facilitar a produção de um documento final acabado sem a necessidade de editar arquivos em qualquer outro formato complexo (*e.g.* LaTeX). Tudo acontece automaticamente a partir do texto em markdown. Para transmitir ao modelo informações sobre a autora ou o autor, sobre a instituição, o local, etc., utilizamos um simples cabeçalho isolado do restante do texto por meio de três traços (`---`) acima e abaixo e contendo os campos e os dados necessários para gerar o arquivo da dissertação ou tese. (Esse cabeçalho está em um formato conhecido como [YAML](https://en.wikipedia.org/wiki/YAML), mas não há qualquer necessidade de conhecer suas minúcias e demais regras). 

Para quem estiver se perguntando acerca da origem do nome do projeto, trata-se de um chiste inspirado pelos projetos [Pandoc](https://pandoc.org), [Pandocomatic](https://github.com/htdebeer/pandocomatic) e [Scrivomatic](https://github.com/iandol/scrivomatic).


## Funcionamento do template

Todos os elementos do trabalho que não fazem parte do corpo do texto propriamente — isto é, dos capítulos centrais que são numerados — são geradas automaticamente a partir das variáveis que são inseridas do documento em blocos no formato YAML. 

Blocos nesse formato devem respeitar as seguintes regras:

- Delimite o bloco utilizando `---` antes do início e depois do fim. 
- Sempre salte uma linha antes do início e depois do fim. (`---autor: Fulano` não funcionará).
- Eles podem ser inseridos *em qualquer parte do texto*, pois **não fazem parte do texto** propriamente e **não aparecem no documento final nesse formato**.

Este exemplo é baseado [na documentação](https://pandoc.org/MANUAL.html#metadata-blocks) do Pandoc:

```yaml
---
title:  'Aspásia e a importância das mulheres na tradição filosófica socrática'
---
```

O uso das aspas para proteger o valor de alguns campos é indicado sempre que houver algum caracter especial (*e.g.* uma vírgula) no texto. Na dúvida, proteja o valor utilizando aspas ou inserindo uma barra vertical `|` e registrando o valor na linha abaixo depois de saltar dois espaços em branco. Palavras-chave podem, teoricamente, ser inseridas entre colchetes utilizando uma vírgula como separador, mas o abnTeX-o-matic não faz uso dessa variável.

```yaml
author:
- Paula Carvalho
- Valentina Tereshkova
keywords: [forma, ideia, espaço]
abstract: |
  O resumo com múltiplos parágrafos fica mais fácil de ser escrito utilizando este formato com um traço vertical e uma nova linha começando com dois espaços em branco. 
  
  Cada nova linha que começar com dois espaços em branco fará parte do nosso resumo. Não há necessidade de utilizar aspas.
---
```

Como o template foi criado sobretudo para trabalhos em língua portuguesa, as variáveis também estão, em sua maioria, em português. Deve-se utilizar, portanto, `autora` e não `author`, `titulo` e não `title`, e assim por diante. Eis uma lista das variáveis disponíveis que devem ser preenchidas: `sumario, autora, autor, titulo, instituicao, lugar, ano, trabalho, curso, instituicao, titulacao, orientadora, orientador, linhadepesquisa`.   

Variáveis opcionais para elementos pré-textuais: `dedicatoria, agradecimentos, epigrafe, advertencia, resumo, abstract, abreviacoes`.  

E, por fim, variáveis opcionais que controlam alguns aspectos da aparência do produto final: `creditos, compilado, mainfont, mainfontoptions, sansfont, sansfontoptions, monofont, colorlinks, linkcolor, citecolor, urlcolor, lang`.  

A bibliografia pode ser especificada como uma variável também: `bibliography, bib-style, bib-title` ou incluída diretamente no comando que utilizaremos para fazer a conversão do texto.


## Capa e contracapa

Para gerar uma capa, é preciso que se tenha definido as seguintes variáveis: `autor`/`autora`, `titulo`, `instituicao`, `lugar` e `ano`. Se a capa não for gerada, isso é um indício de que alguma variável está sem valor.

```yaml
---
autor: 'João Sebastião Ribeiro'
titulo: 'A insustentável leveza dos entes matemáticos'
instituicao: 'Faculdade de Filosofia e Ciências Humanas da Universidade Federal de Minas Gerais'
lugar: 'Belo Horizonte - MG'
ano: '2021'
---
```

Para gerar uma contracapa, é preciso que se tenha definido as variáveis supracitadas e ainda: `contracapa` OU `titulacao`, `curso`, `trabalho`, `linhadepesquisa` e `orientador`/`orientadora`.  

**Opção 1:**  

```yaml
---
contracapa: 'Tese apresentada ao programa de Pós-Graduação em Filosofia da Universidade Federal de Minas Gerais, como requisito parcial para a obtenção do título de Doutor em Filosofia.'
---
```

**Opção 2 (recomendada):**  

```yaml
---
titulacao: 'Doutor'
curso: 'Filosofia'
trabalho: 'Tese'
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

Dedico este trabalho...

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

<br>

---

<br>

## Como funciona o Pandoc

![](/img/2021-02-17_19-57-26.png)
![](/img/2021-02-17_19-57-42.png)


## Fonte em Markdown

Toda a tese pode ser gerada a partir de um simples arquivo em formato markdown com um cabeçalho YAML. [Veja aqui um exemplo de arquivo](https://github.com/bcdavasconcelos/ABNTeX-o-matic/blob/main/Sample.md).


## Comando para a conversão

Utilizar o Pandoc para realizar a conversão de arquivos pode parecer uma tarefa intimidadora, pois ele não possue uma interface tradicional como um programa comum e pode ser utilizado apenas a partir da linha de comando. Por esse motivo, ofereço aqui instruções detalhadas e passo-a-passo. Siga as instruções e não terá nenhum problema.


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
