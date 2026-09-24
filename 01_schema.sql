CREATE DATABASE banco_ficticio;

-- Execute o restante deste arquivo conectado ao banco banco_ficticio.

CREATE TABLE usuarios (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT ck_usuario_nome CHECK (length(trim(nome)) >= 2),
    CONSTRAINT ck_usuario_email CHECK (position('@' IN email) > 1)
);

CREATE TABLE contas (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL REFERENCES usuarios(id) ON DELETE RESTRICT,
    numero VARCHAR(20) NOT NULL UNIQUE,
    tipo VARCHAR(20) NOT NULL DEFAULT 'corrente',
    saldo NUMERIC(14,2) NOT NULL DEFAULT 0,
    moeda CHAR(3) NOT NULL DEFAULT 'BRL',
    ativa BOOLEAN NOT NULL DEFAULT TRUE,
    criada_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT ck_conta_tipo CHECK (tipo IN ('corrente', 'poupanca', 'estudo')),
    CONSTRAINT ck_conta_saldo CHECK (saldo >= 0),
    CONSTRAINT ck_conta_moeda CHECK (moeda = 'BRL')
);

CREATE TABLE movimentacoes (
    id BIGSERIAL PRIMARY KEY,
    conta_id BIGINT NOT NULL REFERENCES contas(id) ON DELETE RESTRICT,
    tipo VARCHAR(24) NOT NULL,
    valor NUMERIC(14,2) NOT NULL,
    saldo_apos NUMERIC(14,2) NOT NULL,
    descricao VARCHAR(255),
    criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT ck_movimentacao_tipo CHECK (tipo IN ('deposito', 'retirada', 'transferencia_entrada', 'transferencia_saida')),
    CONSTRAINT ck_movimentacao_valor CHECK (valor > 0),
    CONSTRAINT ck_movimentacao_saldo CHECK (saldo_apos >= 0)
);

CREATE TABLE transferencias (
    id BIGSERIAL PRIMARY KEY,
    conta_origem_id BIGINT NOT NULL REFERENCES contas(id) ON DELETE RESTRICT,
    conta_destino_id BIGINT NOT NULL REFERENCES contas(id) ON DELETE RESTRICT,
    valor NUMERIC(14,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'concluida',
    descricao VARCHAR(255),
    criada_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    concluida_em TIMESTAMPTZ,
    CONSTRAINT ck_transferencia_contas_diferentes CHECK (conta_origem_id <> conta_destino_id),
    CONSTRAINT ck_transferencia_valor CHECK (valor > 0),
    CONSTRAINT ck_transferencia_status CHECK (status IN ('pendente', 'concluida', 'cancelada'))
);

CREATE TABLE simulacoes_juros (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    valor_inicial NUMERIC(14,2) NOT NULL,
    taxa_mensal NUMERIC(8,5) NOT NULL,
    quantidade_meses INTEGER NOT NULL,
    regime VARCHAR(12) NOT NULL,
    valor_final NUMERIC(14,2) NOT NULL,
    criada_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT ck_simulacao_valor CHECK (valor_inicial > 0),
    CONSTRAINT ck_simulacao_taxa CHECK (taxa_mensal >= 0),
    CONSTRAINT ck_simulacao_meses CHECK (quantidade_meses > 0),
    CONSTRAINT ck_simulacao_regime CHECK (regime IN ('simples', 'compostos')),
    CONSTRAINT ck_simulacao_valor_final CHECK (valor_final >= valor_inicial)
);

CREATE INDEX idx_contas_usuario_id ON contas(usuario_id);
CREATE INDEX idx_movimentacoes_conta_id_data ON movimentacoes(conta_id, criado_em DESC);
CREATE INDEX idx_transferencias_origem ON transferencias(conta_origem_id, criada_em DESC);
CREATE INDEX idx_transferencias_destino ON transferencias(conta_destino_id, criada_em DESC);
CREATE INDEX idx_transferencias_status ON transferencias(status);
CREATE INDEX idx_simulacoes_usuario_id ON simulacoes_juros(usuario_id);
