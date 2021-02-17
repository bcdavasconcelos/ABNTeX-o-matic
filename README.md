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

# Texto base

Toda a tese pode ser gerada a partir de um simples arquivo em formato markdown com um cabeçalho YAML.

```markdown
---
titulo: 'A insustentável leveza dos entes matemáticos'
autor: 'João Sebastião Ribeiro'
orientador: 'Prof. Dr. Antonio Salieri'
faculdade: 'Faculdade de Filosofia e Ciências Humanas da Universidade Federal de Minas Gerais'
lugar: 'Belo Horizonte - MG'
ano: '2021'
grau: 'Doutor'
curso: 'Filosofia'
tipodetrabalho: 'Tese'
linhadepesquisa: 'Filosofia Antiga e Medieval'
mainfont: 'Alegreya'
sansfont: 'Alegreya Sans'
book: true    
top-level-division: chapter    
dedicatoria: |
  Dedico a tese ao verme que primeiro roer a fria carne de meu cadáver.  
agradecimentos: |
  Ao Brasil, por eleger Bolsonaro e mostrar que o ruim sempre pode ficar pior.  
epigrafe: |
  She should have died hereafter;      
  There would have been a time for such a word.      
  To-morrow, and to-morrow, and to-morrow,      
  Creeps in this petty pace from day to day,      
  To the last syllable of recorded time;      
  And all our yesterdays have lighted fools      
  The way to dusty death.      
  Out, out, brief candle!      
  Life is but a walking shadow, a poor player      
  That struts and frets his hour upon the stage      
  And then is heard no more. It is a tale      
  Told by an idiot, full of sound and fury      
  Signifying nothing.      

  --- Macbeth (Act 5, Scene 5, lines 17–28)  
advertencia: |
  Este trabalho foi realizado com atenção às diretrizes da *Associação Brasileira de Normas Técnicas* (ABNT). No entanto, no que toca à citação e referência de autores antigos, seguimos as normas consagradas no meio dos Estudos Clássicos; isto é, citar os autores a partir da numeração presente na edição de referência do texto grego, e não a partir das traduções e edições recentes.   
resumo: |
  Texto do resumo  
abstract: |
  The content of the abstract  
abreviacoes: |
  **Aristóteles**  
  APo - *Analytica Posteriora*  
  APr - *Analytica Priora*  
  Aud - *de Audibilibus*  
  Cael - *de Caelo*  
  Cat - *Categoriae*  
  Col - *de Coloribus*  
  DA - *de Anima*  
  DivSomn - *de Divinatione per Somnia*  
  EE - *Ethica Eudemia*  
  EN - *Ethica Nicomachea*  
  GA - *de Generatione Animalium*  
  GC - *de Generatione et Corruptione*  
  HA - *Historia Animalium*  
  IA - *de Incessu Animalium*  
  Insomn - *de Insomniis*  
  Int - *de Interpretatone*  
  Juv - *de Juventute*  
  LI - *de Lineis Insecabilibus*  
  Long - *De Longitudine et Brevitate Vitae*  
  MA - *de Motu Animalium*  
  MM - *Magna Moralia*  
  Mech - *Mechanica*  
  Mem - *de Memoria*  
  Metaph - *Metaphysica*  
  Mete - *Meteorologica*  
  Mir - *Mirabilia*  
  Mu - *de Mundo*  
  Oec - *Oeconomica*  
  PA - *de Partibus Animalium*  
  Phys - *Physica*  
  Phgn - *Physiognomonica*  
  Poet - *Poetica*  
  Pol - *Politica*  
  Pr - *Problemata*  
  Resp - *de Respiratione*  
  Rhet - *Rhetorica*  
  RhAl - *Rhetorica ad Alexandrum*  
  SE - *De Sophisticis Elenchis*  
  Sensu - *de Sensu et Sensibilibus*  
  SomnVig - *de Somno et Vigilia*  
  Spir - *de Spiritu*  
  Top - *Topica*  
  VV - *de Virtutibus et Vitiis*  
  Vent - *de Ventis*  
  Xen - *de Xenophane*  

  **Platão **  
  Apol - *Apologia*  
  Charm - *Cármides*  
  Crat - *Crátilo*  
  Crit - *Críton*  
  Euth - *Eutidemo*  
  Euth - *Eutífron*  
  Gorg - *Górgias*  
  Lach - *Laques*  
  Lg - *Leis*  
  Lys - *Lísis*  
  Men - *Mênon*  
  Parm - *Parmênides*  
  Phae - *Fedro*  
  Phae - *Fédon*  
  Philb - *Filebo*  
  Prot - *Protágoras*  
  Rep - *República*  
  Soph - *Sofista*  
  State - *Político*  
  Symp - *Simpósio*  
  Thea - *Teeteto*  
  Tim - *Timeu*  
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
