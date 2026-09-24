# Dossiê dos projetos — briefing para Claude

**Data:** 24 de setembro de 2026  
**Pessoa:** Henrique Monteiro  
**Objetivo:** entender o ecossistema de projetos, preservar suas fronteiras e sugerir próximos experimentos úteis.

## Como usar este documento

Leia este dossiê antes de sugerir mudanças. Trate cada repositório como uma linha de trabalho diferente. Não misture conteúdo editorial, material privado, banco de estudo e portfólio sem uma decisão explícita. Antes de editar, verifique o estado real do projeto, a branch ativa e os arquivos de origem.

## Mapa rápido

| Projeto | Papel | Estado | GitHub |
|---|---|---|---|
| `banco-ficticio` | laboratório full-stack e PostgreSQL | ativo, `main`, 272 testes aprovados | github.com/henriquemonteiro098/banco-ficticio |
| `projects` | caderno de estudos financeiros e SQL | base educacional, sem runner | github.com/henriquemonteiro098/projects |
| `ponto-cego` | pipeline editorial de curiosidade e filosofia | pipeline local amplo; versão pública limpa | github.com/henriquemonteiro098/ponto-cego |
| `retratos-tech-ia` | estudo e produção de retratos de marca pessoal | pipeline por estados, sem testes | github.com/henriquemonteiro098/retratos-tech-ia |
| `site-portifolio-human` | site/experimento de portfólio visual | smoke test HTTP passou | github.com/henriquemonteiro098/site-portifolio-human |
| `workspace-criativo` | índice transversal dos aprendizados | branch local `experiment/arquivo-vivo` e `main` remoto | github.com/henriquemonteiro098/workspace-criativo |

## Regras de colaboração

1. **Preservar fronteiras.** `ponto-cego` é canal editorial; `retratos-tech-ia` é retrato de marca pessoal; `banco-ficticio` é sandbox educacional; `projects` é estudo; o site é portfólio.
2. **Ler antes de responder.** Para uma ideia de vídeo, consulte `IDEIAS.md`, a pasta da ideia e `publicacao.md`. Para o banco, consulte `PROJECT.md`, testes e schema. Para retratos, consulte `CLAUDE.md`, referências e a ideia específica.
3. **Estado é fonte de verdade.** Pasta, nome, frontmatter e índice devem concordar. Não mover ideias manualmente se houver script oficial.
4. **Não publicar automaticamente.** Mídia, campanhas, ideias cruas, logs pessoais e saídas grandes precisam de revisão antes de qualquer upload.
5. **Uma variável por iteração.** Em prompts visuais e experimentos criativos, mude um eixo por vez e registre o motivo.
6. **Fonte antes da síntese.** Em estudos financeiros, cite a fonte, separe definição de interpretação e declare o que o material não cobre.
7. **Nunca tratar o banco como produção.** Os nomes, contas e valores são fictícios. Não sugerir uso real sem revisão de segurança, privacidade, auditoria e requisitos regulatórios.
8. **Testar a fronteira.** Priorize entradas vazias, estados inválidos, rollback, concorrência, links quebrados, arquivos ausentes e inconsistência entre índices.

## 1. Banco Fictício

**Local:** `/Users/henriquemonteiro/Projetos/banco-ficticio`

Aplicação Node/Express conectada ao PostgreSQL `banco_ficticio`. Possui painel administrativo, portal de cliente, autenticação demo, dashboard, contas, movimentações, transferências, pagamentos, Command Bar com Chat IA e simulação/contratação de empréstimos.

### Aprendizados técnicos

- dinheiro usa `NUMERIC`, nunca `FLOAT`;
- alterações de saldo e histórico acontecem na mesma transação;
- transferências usam queries parametrizadas, bloqueio `FOR UPDATE` e isolamento de origem/destino;
- testes verificam comportamento por HTTP e integridade no PostgreSQL;
- a interface é avaliada por assets, acessibilidade estrutural, latência e linguagem.

### Próximas ideias

- separar testes unitários puros do cálculo de empréstimo dos testes E2E;
- adicionar testes de rollback forçado e idempotência de requisições;
- gerar um relatório de cobertura de rotas e queries;
- adicionar testes de acessibilidade da Command Bar;
- documentar uma arquitetura de domínio para saldo, transação e auditoria.

## 2. Projects

**Local:** `/Users/henriquemonteiro/Projetos/projects`

Caderno de estudo sobre inflação, IPCA, Selic, juros simples e compostos, liquidez, risco, Tesouro Direto e vieses comportamentais. Também contém um exercício de banco relacional e um schema de viagens.

### Aprendizados conceituais

- separar ato de poupar de produto poupança;
- comparar fontes públicas sem transformá-las em recomendação pessoal;
- usar perguntas de recuperação ativa em vez de pedir resumos genéricos;
- declarar limites: fontes não fornecem timing de mercado, produto “melhor hoje” ou recomendação individual.

### Próximas ideias

- transformar o `STUDY_GUIDE.md` em pequenos testes de recuperação com respostas ocultas;
- conectar o estudo financeiro ao banco fictício com cenários didáticos, sem conselho de investimento;
- criar um glossário navegável de termos e confusões comuns;
- adicionar citações por seção e uma matriz “fonte → afirmação → pergunta”.

## 3. Ponto Cego

**Local:** `/Users/henriquemonteiro/Projetos/ponto-cego`

Pipeline de conteúdo para duas linhas editoriais: `curiosidade` e `filosofia`. Uma ideia é uma pasta; o estágio é parte do estado. O fluxo vai de referências para ideias cruas, maturação, gravação, pronto para postar e publicado.

### Aprendizados de processo

- scripts são guardrails: criar, mover e indexar são operações explícitas;
- publicação só termina quando links e status estão registrados;
- referências virais não são ideias próprias;
- vídeo, carrossel e imagem têm linhas de produção separadas;
- produção de mídia, campanhas e memória do time ficam fora da versão pública limpa.

### Próximas ideias

- teste de contrato que verifica `status`, pasta e frontmatter;
- comando de auditoria que encontra ideias sem `publicacao.md` ou links incompletos;
- painel local somente leitura com contagem por estágio e linha editorial;
- validação de fontes e datas antes de marcar uma peça como publicada;
- geração de um “brief de próxima ação” para cada pasta parada.

## 4. Retratos Tech IA

**Local:** `/Users/henriquemonteiro/Projetos/retratos-tech-ia`

Sistema isolado para retratos realistas de marca pessoal em tecnologia. Trabalha por referências, ideias e estágios. A gramática visual privilegia pele com textura, luz motivada, ausência de texto/logo no retrato e prompts baseados em física de câmera, não em adjetivos vazios.

### Aprendizados visuais

- análise pode citar referências; prompt final deve descrever física e composição;
- uma variável por iteração facilita comparação;
- referências, produção e publicação têm papéis diferentes;
- o resultado precisa preservar identidade sem cair em “CEO cinematic” genérico.

### Próximas ideias

- ficha de consistência por personagem com variáveis bloqueadas;
- comparador de versões que destaca a única variável alterada;
- índice de retratos por luz, lente, ambiente e uso;
- checklist automático de prompt contra marcas, texto embutido e clichês visuais.

## 5. Site Portfólio Human

**Local:** `/Users/henriquemonteiro/Projetos/site portifolio ideia human/project beta/site`

Site estático com HTML, CSS e JavaScript, servido atualmente pelo script `dev` na porta 4321. O projeto raiz também contém materiais de campanha, memória e estudo, que não devem ser tratados como código do site sem decisão explícita.

### Próximas ideias

- adicionar `npm test` com smoke tests de HTML e links;
- testar responsividade em mobile e desktop;
- incluir auditoria de acessibilidade e contraste;
- separar o pacote publicável do arquivo de campanha;
- adicionar build/reproducibilidade se o site evoluir para Astro ou outro framework.

## 6. Workspace Criativo / Arquivo Vivo

**Local:** `/Users/henriquemonteiro/vscode`

Índice transversal criado para ligar sistemas, estudos e criação. A primeira prova é estática e filtrável: atlas de trabalho, princípios extraídos e próxima trilha. A estética é de arquivo técnico editorial: blueprint azul, papel mineral, preto azulado e laranja queimado.

### Próximas ideias

- migrar cartões HTML para um `knowledge-index.json`;
- gerar o índice a partir de metadados dos repositórios;
- validar links locais e GitHub em CI;
- permitir conexões entre fonte, regra, projeto e experimento;
- criar uma visão “o que está parado?” baseada em idade do último estado;
- usar o Claude como curador: sugerir apenas ideias que respeitem as fronteiras e explicitar a fonte da sugestão.

## Perguntas que Claude deve fazer antes de sugerir

- Qual projeto é o dono desta ideia?
- É uma hipótese, uma referência ou uma entrega?
- Qual fonte sustenta a afirmação?
- Que estado deve mudar depois desta ação?
- Qual é a menor experiência que testa a hipótese?
- Como saberemos que funcionou?
- O que precisa permanecer privado ou local?

## Melhorias transversais de alto valor

1. Criar um formato de metadados comum: `title`, `project`, `type`, `status`, `source`, `next_action`, `updated_at`.
2. Criar uma suíte de contratos para os pipelines de ideias e retratos.
3. Adicionar smoke tests de links e arquivos em cada site.
4. Separar dados de estudo, código e mídia pesada em artefatos explicitamente publicáveis.
5. Transformar o `workspace-criativo` em uma camada de leitura, não em uma nova fonte duplicada.
6. Registrar resultados dos experimentos junto da hipótese, para que o próximo ciclo comece com evidência.
