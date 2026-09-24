INSERT INTO usuarios (nome, email, senha_hash)
VALUES
    ('Ana Souza', 'ana@exemplo.test', 'HASH_GERADO_PELA_APLICACAO_ANA'),
    ('Bruno Lima', 'bruno@exemplo.test', 'HASH_GERADO_PELA_APLICACAO_BRUNO'),
    ('Carla Mendes', 'carla@exemplo.test', 'HASH_GERADO_PELA_APLICACAO_CARLA');

INSERT INTO contas (usuario_id, numero, tipo, saldo)
SELECT id, '0001-000001', 'estudo', 1000.00
FROM usuarios WHERE email = 'ana@exemplo.test';

INSERT INTO contas (usuario_id, numero, tipo, saldo)
SELECT id, '0001-000002', 'estudo', 500.00
FROM usuarios WHERE email = 'bruno@exemplo.test';

INSERT INTO contas (usuario_id, numero, tipo, saldo)
SELECT id, '0001-000003', 'estudo', 250.00
FROM usuarios WHERE email = 'carla@exemplo.test';

INSERT INTO movimentacoes (conta_id, tipo, valor, saldo_apos, descricao)
SELECT id, 'deposito', saldo, saldo, 'Saldo inicial fictício'
FROM contas;
