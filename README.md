# ABNTeX-o-matic

(em preparação)

Para converter arquivos de texto em markdown para arquivos PDF, o Pandoc pode utilizar dois caminhos: LaTeX e HTML. Ou seja, ele faz o caminho `Markdown → LaTeX/HTML → PDF`. Ambos caminhos pressupõe a existência de um modelo que determina onde cada elemento do arquivo de texto fonte deve aparecer no produto final — de outro modo o mecanismo de conversão não teria como saber qual parte do texto integra os elementos pré-textuais (*e.g.* abreviações, agradecimentos) e qual contém o corpo do texto propriamente.  

A preparação de um modelo para conversão via LaTeX (usando um mecanismo chamado XeLaTeX) é mais complexa e difícil, mas os resultados são muito superiores àqueles obtidos com a conversão via HTML. Por isso, é interessante contar com modelos para fazer a conversão de artigos, dissertações e teses de doutorado seguindo os padrões da ABNT. Infelizmente, todos os projetos que se encarregavam de manter esses modelos — e de atualizá-los — foram abandonados, de modo que não há no momento (Fev 2021) nenhum template funcional disponível para esse fim.  

Para sanar essa demanda e gerar o arquivo final do meu próprio trabalho, preparei um novo modelo utilizando como fonte o [Mimosis](https://github.com/Pseudomanifold/latex-mimosis).  

![](/Samples/2021-02-17_19-44-45.png)

A rigor, esse template diverge em detalhes muito pequenos das normas da ABNT. As margens, por exemplo, não são 3,3,2,2cm; ao invés disso, elas são automaticamente calculadas pelo mecanismo de conversão para obter o melhor resultado possível no posicionamento do texto.  
