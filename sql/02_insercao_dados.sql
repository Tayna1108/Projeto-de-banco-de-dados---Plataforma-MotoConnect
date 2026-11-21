BEGIN;

-- 1. USUARIO
INSERT INTO public.usuario
(id_usuario, nome_completo, email, senha, cpf, telefone,
 data_nascimento, data_cadastro, rua, numero, bairro, cep, cidade)
SELECT
    n,
    'Motociclista ' || n,
    'motociclista' || n || '@motoconnect.com',
    'senha_teste_' || n,
    LPAD(n::TEXT, 11, '0'),
    '(16) 9' || LPAD(n::TEXT, 8, '0'),
    DATE '1980-01-01' + (n % 9000),
    CURRENT_TIMESTAMP,
    'Rua das Motocicletas',
    n::TEXT,
    'Centro',
    '14400-' || LPAD((n % 1000)::TEXT, 3, '0'),
    CASE
        WHEN n % 3 = 0 THEN 'Franca'
        WHEN n % 3 = 1 THEN 'Ribeirao Preto'
        ELSE 'Sao Paulo'
    END
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 2. PERFIL
INSERT INTO public.perfil
(id_perfil, id_usuario, biografia, interesses, nome_perfil, foto)
SELECT
    n,
    n,
    'Perfil do motociclista ' || n,
    'Motociclismo, viagens e encontros',
    'MotoUser' || n,
    'foto_' || n || '.jpg'
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 3. MOTO
INSERT INTO public.moto
(id_moto, id_usuario, marca, modelo, ano, cilindrada, cor, placa)
SELECT
    n,
    n,
    CASE
        WHEN n % 4 = 0 THEN 'Honda'
        WHEN n % 4 = 1 THEN 'Yamaha'
        WHEN n % 4 = 2 THEN 'Suzuki'
        ELSE 'Kawasaki'
    END,
    CASE
        WHEN n % 4 = 0 THEN 'CG 160'
        WHEN n % 4 = 1 THEN 'Fazer 250'
        WHEN n % 4 = 2 THEN 'Intruder 125'
        ELSE 'Ninja 400'
    END,
    (2015 + (n % 11))::SMALLINT,
    CASE
        WHEN n % 4 = 0 THEN 160
        WHEN n % 4 = 1 THEN 250
        WHEN n % 4 = 2 THEN 125
        ELSE 400
    END,
    CASE
        WHEN n % 3 = 0 THEN 'Preta'
        WHEN n % 3 = 1 THEN 'Vermelha'
        ELSE 'Azul'
    END,
    'ABC' || LPAD(n::TEXT, 4, '0')
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 4. EVENTO
INSERT INTO public.evento
(id_evento, nome_evento, descricao, data_evento, horario,
 rua, numero, bairro, cep, cidade)
SELECT
    n,
    'Encontro MotoConnect ' || n,
    'Evento de integracao entre motociclistas',
    CURRENT_DATE + n,
    TIME '09:00' + ((n % 8) * INTERVAL '1 hour'),
    'Avenida dos Motociclistas',
    n::TEXT,
    'Centro',
    '14400-' || LPAD((n % 1000)::TEXT, 3, '0'),
    CASE
        WHEN n % 3 = 0 THEN 'Franca'
        WHEN n % 3 = 1 THEN 'Ribeirao Preto'
        ELSE 'Sao Paulo'
    END
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 5. PUBLICACAO
INSERT INTO public.publicacao
(id_publicacao, id_perfil, titulo, descricao, foto, data_publicacao)
SELECT
    n,
    n,
    'Publicacao de motociclista ' || n,
    'Compartilhando experiencias sobre motociclismo. Registro ' || n,
    'publicacao_' || n || '.jpg',
    CURRENT_TIMESTAMP
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 6. PARTICIPACAO
INSERT INTO public.participacao
(id_participacao, id_usuario, id_evento, data_inscricao, status, limite_participante)
SELECT
    n,
    n,
    n,
    CURRENT_TIMESTAMP,
    CASE WHEN n % 2 = 0 THEN 'confirmada' ELSE 'pendente' END,
    500
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 7. COMENTARIO
INSERT INTO public.comentario
(id_comentario, id_usuario, id_publicacao, texto, data_comentario)
SELECT
    n,
    n,
    n,
    'Otima publicacao! Comentario de exemplo ' || n,
    CURRENT_TIMESTAMP
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 8. ANUNCIO
INSERT INTO public.anuncio
(id_anuncio, id_usuario, id_moto, preco, status, data_anuncio, descricao_anuncio)
SELECT
    n,
    n,
    n,
    (5000 + (n * 25))::DECIMAL(10,2),
    CASE
        WHEN n % 3 = 0 THEN 'ativo'
        WHEN n % 3 = 1 THEN 'pausado'
        ELSE 'vendido'
    END,
    CURRENT_TIMESTAMP,
    'Anuncio de motocicleta ' || n
FROM GENERATE_SERIES(1, 500) AS serie(n);

-- 9. TELEFONE_USUARIO
INSERT INTO public.telefone_usuario
(id_telefone, id_usuario, telefone)
SELECT
    n,
    n,
    '(16) 9' || LPAD(n::TEXT, 8, '0')
FROM GENERATE_SERIES(1, 500) AS serie(n);

COMMIT;

-- CONFERENCIA DOS REGISTROS
SELECT 'usuario' AS tabela, COUNT(*) AS total FROM public.usuario
UNION ALL
SELECT 'perfil', COUNT(*) FROM public.perfil
UNION ALL
SELECT 'moto', COUNT(*) FROM public.moto
UNION ALL
SELECT 'evento', COUNT(*) FROM public.evento
UNION ALL
SELECT 'publicacao', COUNT(*) FROM public.publicacao
UNION ALL
SELECT 'participacao', COUNT(*) FROM public.participacao
UNION ALL
SELECT 'comentario', COUNT(*) FROM public.comentario
UNION ALL
SELECT 'anuncio', COUNT(*) FROM public.anuncio
UNION ALL
SELECT 'telefone_usuario', COUNT(*) FROM public.telefone_usuario
ORDER BY tabela;
