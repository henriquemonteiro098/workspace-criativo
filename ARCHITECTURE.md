# Arquivo Vivo: arquitetura do experimento

## Intenção

Uma página estática, sem framework e sem dependências, para testar a navegação entre aprendizado técnico, pesquisa e produção criativa.

## Direção visual

**Arquivo técnico editorial**: blueprint azul, papel mineral, preto azulado e laranja queimado. A grade de fundo remete a desenho de bancada; a tipografia Space Grotesk dá ao título uma voz própria e DM Mono marca estados e metadados.

A assinatura é o cartão azul vertical do primeiro item: ele funciona como peça de origem, não como decoração, e ancora o mapa no projeto bancário que deu origem a parte do método.

## Comportamento

- Busca textual filtra os quatro cartões do atlas.
- Filtros por área combinam com a busca.
- O estado vazio comunica quando a combinação não encontra material.
- Navegação e links preservam o retorno às fontes.
- Layout adapta-se a telas pequenas.
- `prefers-reduced-motion` reduz transições e scroll suave.

## Próximo incremento

Trocar os cartões codificados por dados gerados a partir de um índice JSON, mantendo as fontes como autoridade e validando links quebrados automaticamente.
