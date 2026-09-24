# Relatório de testes — 24 de setembro de 2026

## Resumo

| Projeto | Tipo de validação | Resultado |
|---|---|---|
| `banco-ficticio` | Suíte E2E Node/PostgreSQL | **272 passou, 0 falhou** |
| `site-portifolio-human` | Smoke test HTTP estático | **HTML, CSS e JS: HTTP 200** |
| `workspace-criativo` | Sintaxe e smoke test HTTP | **JS válido; HTML, CSS e JS: HTTP 200** |
| `ponto-cego` | Compilação Python + sintaxe Shell | **Passou** |
| `retratos-tech-ia` | Compilação Python + sintaxe Shell | **Passou** |
| `projects` | Nenhum runner configurado | **Não executado: sem testes automatizados** |

## O que rodou

### Banco Fictício

Comando:

```bash
npm --prefix /Users/henriquemonteiro/Projetos/banco-ficticio test
```

O servidor foi iniciado na porta `3000` e encerrado depois da execução. A suíte cobriu:

- assets e integração visual;
- Command Bar e Chat IA;
- comandos `/saldo`, `/extrato`, `/pix`, `/contas`, `/agencias`, `/ajuda` e `/emprestimo`;
- consultas em linguagem natural;
- cálculo de empréstimos e precisão financeira;
- transferências atômicas e concorrência com `SELECT FOR UPDATE`;
- rollback, saldos e histórico no PostgreSQL;
- entradas vazias, limites e entidades inexistentes;
- resistência a SQL Injection;
- latência abaixo de 500 ms;
- auditoria de linguagem Humanizer.

Resultado: **272 testes, 272 aprovados, 0 falhas, duração aproximada de 1,7 s**.

### Ponto Cego e Retratos Tech IA

Comandos equivalentes executados:

```bash
python3 -m compileall -q <projeto>
for script in $(find <projeto> -name '*.sh'); do bash -n "$script"; done
```

Resultado: todos os scripts Python compilaram e todos os scripts Shell passaram pela validação sintática. Isso não executa movimentação de ideias, renderização, download de mídia ou publicação.

### Site Portfólio Human

Foi servido com `python3 -m http.server` e os seguintes recursos responderam corretamente:

- `/` — HTTP 200, 4.280 bytes;
- `/styles.css` — HTTP 200, 7.235 bytes;
- `/main.js` — HTTP 200, 586 bytes.

Não existe suíte unitária, lint ou build configurado no `package.json` do site.

### Workspace Criativo / Arquivo Vivo

Validações executadas:

- `node --check app.js`;
- presença de HTML, CSS e JS;
- smoke test HTTP dos três arquivos;
- busca e filtros já verificados no navegador em execução anterior.

Recursos HTTP:

- `/` — HTTP 200, 7.244 bytes;
- `/styles.css` — HTTP 200, 8.645 bytes;
- `/app.js` — HTTP 200, 1.105 bytes.

### Projects

É uma base de estudos e SQL, sem `package.json`, suíte de testes ou runner configurado. Não havia comando seguro e explícito para executar automaticamente.

## O que não rodou

- Não renderizei vídeos nem executei pipelines de mídia do Ponto Cego.
- Não executei scripts que movem ideias entre estados ou reindexam conteúdo, para não modificar sua organização local durante a auditoria.
- Não rodei geração de assets do banco, pois os assets existentes já foram verificados pela suíte E2E.
- Não fiz teste visual automatizado em múltiplos viewports.
- Não fiz análise de segurança profunda, dependências ou conteúdo de mídia.

## Leitura do resultado

O `banco-ficticio` é o projeto com maior maturidade de validação: há testes de comportamento, integração, concorrência, segurança e linguagem. Os pipelines criativos têm scripts com sintaxe saudável, mas ainda dependem de testes de contrato para garantir que estados, frontmatter e índices permaneçam sincronizados. Os sites têm smoke tests básicos, mas ainda não têm regressão visual, acessibilidade automatizada ou testes de interação persistentes.
