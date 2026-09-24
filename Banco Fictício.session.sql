-- Dados fictícios para o banco banco_ficticio.
-- Execute este arquivo conectado ao banco banco_ficticio no pgAdmin.

BEGIN;

INSERT INTO  (nome, email, senha_hash)
VALUES
		('Ana Souza', 'ana@exemplo.test', 'HASH_FICTICIO_ANA'),
		('Bruno Lima', 'bruno@exemplo.test', 'HASH_FICTICIO_BRUNO'),
		('Carla Mendes', 'carla@exemplo.test', 'HASH_FICTICIO_CARLA')
ON CONFLICT (email) DO NOTHING;

INSERT INTO contas (usuario_id, numero, tipo, saldo)
SELECT u.id, dados.numero, 'estudo', dados.saldo
FROM usuarios u
JOIN (
		VALUES
				('ana@exemplo.test', '0001-000001', 1000.00::NUMERIC(14,2)),
				('bruno@exemplo.test', '0001-000002', 500.00::NUMERIC(14,2)),
				('carla@exemplo.test', '0001-000003', 250.00::NUMERIC(14,2))
) AS dados(email, numero, saldo) ON dados.email = u.email
ON CONFLICT (numero) DO NOTHING;

INSERT INTO movimentacoes (conta_id, tipo, valor, saldo_apos, descricao)
SELECT c.id, 'deposito', c.saldo, c.saldo, 'Saldo inicial fictício'
FROM contas c
WHERE NOT EXISTS (
		SELECT 1
		FROM movimentacoes m
		WHERE m.conta_id = c.id
			AND m.descricao = 'Saldo inicial fictício'
);

-- Transferência fictícia de Ana para Bruno.
WITH contas_selecionadas AS (
		SELECT
				MAX(id) FILTER (WHERE numero = '0001-000001') AS origem_id,
				MAX(id) FILTER (WHERE numero = '0001-000002') AS destino_id
		FROM contas
)
INSERT INTO transferencias (
		conta_origem_id,
		conta_destino_id,
		valor,
		status,
		descricao,
		concluida_em
)
SELECT origem_id, destino_id, 75.50, 'concluida',
			 'Transferência fictícia de estudo', NOW()
FROM contas_selecionadas
WHERE origem_id IS NOT NULL
	AND destino_id IS NOT NULL
	AND NOT EXISTS (
			SELECT 1
			FROM transferencias t
			WHERE t.conta_origem_id = origem_id
				AND t.conta_destino_id = destino_id
				AND t.valor = 75.50
				AND t.descricao = 'Transferência fictícia de estudo'
	);

-- Registra a transferência e ajusta os saldos somente se ela foi criada agora.
WITH transferencia AS (
		SELECT t.id, t.conta_origem_id, t.conta_destino_id, t.valor
		FROM transferencias t
		WHERE t.descricao = 'Transferência fictícia de estudo'
			AND t.valor = 75.50
		ORDER BY t.id DESC
		LIMIT 1
),
ajuste_origem AS (
		UPDATE contas c
		SET saldo = saldo - transferencia.valor
		FROM transferencia
		WHERE c.id = transferencia.conta_origem_id
			AND NOT EXISTS (
					SELECT 1 FROM movimentacoes m
					WHERE m.conta_id = c.id
						AND m.tipo = 'transferencia_saida'
						AND m.descricao = 'Transferência fictícia de estudo'
			)
		RETURNING c.id, c.saldo
),
ajuste_destino AS (
		UPDATE contas c
		SET saldo = saldo + transferencia.valor
		FROM transferencia
		WHERE c.id = transferencia.conta_destino_id
			AND EXISTS (SELECT 1 FROM ajuste_origem)
		RETURNING c.id, c.saldo
)
INSERT INTO movimentacoes (conta_id, tipo, valor, saldo_apos, descricao)
SELECT id, 'transferencia_saida', 75.50, saldo,
			 'Transferência fictícia de estudo'
FROM ajuste_origem
UNION ALL
SELECT id, 'transferencia_entrada', 75.50, saldo,
			 'Transferência fictícia de estudo'
FROM ajuste_destino;

INSERT INTO simulacoes_juros (
		usuario_id,
		valor_inicial,
		taxa_mensal,
		quantidade_meses,
		regime,
		valor_final
)
SELECT u.id, 1000.00, 0.05000, 6, 'simples', 1300.00
FROM usuarios u
WHERE u.email = 'ana@exemplo.test'
	AND NOT EXISTS (
			SELECT 1 FROM simulacoes_juros s
			WHERE s.usuario_id = u.id AND s.regime = 'simples'
	);

INSERT INTO simulacoes_juros (
		usuario_id,
		valor_inicial,
		taxa_mensal,
		quantidade_meses,
		regime,
		valor_final
)
SELECT u.id, 1000.00, 0.05000, 6, 'compostos',
			 ROUND((1000.00 * POWER(1 + 0.05, 6))::NUMERIC, 2)
FROM usuarios u
WHERE u.email = 'ana@exemplo.test'
	AND NOT EXISTS (
			SELECT 1 FROM simulacoes_juros s
			WHERE s.usuario_id = u.id AND s.regime = 'compostos'
	);

COMMIT;

-- Confira os dados inseridos.
SELECT u.nome, c.numero, c.saldo, c.moeda
FROM usuarios u
JOIN contas c ON c.usuario_id = u.id
ORDER BY u.nome;

SELECT tipo, valor, saldo_apos, descricao
FROM movimentacoes
ORDER BY id;

SELECT valor, status, descricao
FROM transferencias
ORDER BY id;

SELECT regime, valor_inicial, valor_final
FROM simulacoes_juros
ORDER BY id;

