-- Usuários e contas ativas.
SELECT u.nome, u.email, c.numero, c.tipo, c.saldo, c.moeda
FROM usuarios u
JOIN contas c ON c.usuario_id = u.id
WHERE u.ativo = TRUE
ORDER BY u.nome;

-- Histórico de uma conta.
SELECT m.criado_em, m.tipo, m.valor, m.saldo_apos, m.descricao
FROM movimentacoes m
WHERE m.conta_id = 1
ORDER BY m.criado_em DESC, m.id DESC;

-- Transferências enviadas ou recebidas por uma conta.
SELECT t.id,
       origem.numero AS conta_origem,
       destino.numero AS conta_destino,
       t.valor,
       t.status,
       t.criada_em,
       t.descricao
FROM transferencias t
JOIN contas origem ON origem.id = t.conta_origem_id
JOIN contas destino ON destino.id = t.conta_destino_id
WHERE t.conta_origem_id = 1 OR t.conta_destino_id = 1
ORDER BY t.criada_em DESC;

-- Total guardado por usuário, considerando apenas contas ativas.
SELECT u.id,
       u.nome,
       COALESCE(SUM(c.saldo), 0)::NUMERIC(14,2) AS valor_guardado
FROM usuarios u
LEFT JOIN contas c ON c.usuario_id = u.id AND c.ativa = TRUE
GROUP BY u.id, u.nome
ORDER BY valor_guardado DESC;

-- Depósito: execute em uma transação e confirme a linha atualizada.
BEGIN;
UPDATE contas
SET saldo = saldo + 200.00
WHERE id = 1 AND ativa = TRUE;
INSERT INTO movimentacoes (conta_id, tipo, valor, saldo_apos, descricao)
SELECT id, 'deposito', 200.00, saldo, 'Depósito de estudo'
FROM contas
WHERE id = 1;
COMMIT;

-- Retirada: se o UPDATE afetar zero linhas, faça ROLLBACK na aplicação.
BEGIN;
UPDATE contas
SET saldo = saldo - 100.00
WHERE id = 1 AND ativa = TRUE AND saldo >= 100.00;
INSERT INTO movimentacoes (conta_id, tipo, valor, saldo_apos, descricao)
SELECT id, 'retirada', 100.00, saldo, 'Retirada de estudo'
FROM contas
WHERE id = 1;
COMMIT;

-- Transferência: o backend deve verificar os dois UPDATEs antes do COMMIT.
BEGIN;
SELECT id, saldo
FROM contas
WHERE id IN (1, 2)
ORDER BY id
FOR UPDATE;

UPDATE contas
SET saldo = saldo - 75.50
WHERE id = 1 AND ativa = TRUE AND saldo >= 75.50;

UPDATE contas
SET saldo = saldo + 75.50
WHERE id = 2 AND ativa = TRUE;

INSERT INTO transferencias (
    conta_origem_id, conta_destino_id, valor, status, descricao, concluida_em
)
VALUES (1, 2, 75.50, 'concluida', 'Transferência de estudo', NOW());

INSERT INTO movimentacoes (conta_id, tipo, valor, saldo_apos, descricao)
SELECT id, 'transferencia_saida', 75.50, saldo, 'Transferência para conta 2'
FROM contas WHERE id = 1;

INSERT INTO movimentacoes (conta_id, tipo, valor, saldo_apos, descricao)
SELECT id, 'transferencia_entrada', 75.50, saldo, 'Transferência da conta 1'
FROM contas WHERE id = 2;
COMMIT;

-- Conferência entre saldo atual e a última movimentação registrada.
WITH ultima_movimentacao AS (
    SELECT DISTINCT ON (conta_id) conta_id, saldo_apos
    FROM movimentacoes
    ORDER BY conta_id, criado_em DESC, id DESC
)
SELECT c.id,
       c.numero,
       c.saldo AS saldo_da_conta,
       u.saldo_apos AS saldo_da_ultima_movimentacao
FROM contas c
JOIN ultima_movimentacao u ON u.conta_id = c.id
WHERE c.saldo <> u.saldo_apos;

-- Simulações didáticas, sem alterar contas.saldo.
SELECT 1000.00 AS valor_inicial,
       1000.00 * POWER(1 + 0.05, 6) AS juros_compostos,
       1000.00 + (1000.00 * 0.05 * 6) AS juros_simples;
