SELECT
    u.nome_completo,
    m.marca,
    m.modelo,
    m.ano,
    m.cilindrada
FROM public.usuario u
INNER JOIN public.moto m
    ON u.id_usuario = m.id_usuario
WHERE m.cilindrada IS NOT NULL
ORDER BY u.nome_completo ASC;


-- 2. Publicacoes e seus autores
SELECT
    u.nome_completo,
    p.nome_perfil,
    pub.titulo,
    pub.descricao,
    pub.data_publicacao
FROM public.publicacao pub
INNER JOIN public.perfil p
    ON pub.id_perfil = p.id_perfil
INNER JOIN public.usuario u
    ON p.id_usuario = u.id_usuario
WHERE pub.titulo IS NOT NULL
ORDER BY pub.data_publicacao DESC;


-- 3. Comentarios e suas publicacoes
SELECT
    u.nome_completo,
    pub.titulo,
    c.texto,
    c.data_comentario
FROM public.comentario c
INNER JOIN public.usuario u
    ON c.id_usuario = u.id_usuario
INNER JOIN public.publicacao pub
    ON c.id_publicacao = pub.id_publicacao
WHERE c.texto IS NOT NULL
ORDER BY c.data_comentario DESC;


-- 4. Usuarios inscritos em eventos
SELECT
    u.nome_completo,
    e.nome_evento,
    p.data_inscricao,
    p.status
FROM public.participacao p
INNER JOIN public.usuario u
    ON p.id_usuario = u.id_usuario
INNER JOIN public.evento e
    ON p.id_evento = e.id_evento
WHERE p.status IS NOT NULL
ORDER BY e.nome_evento ASC;


-- 5. Anuncios ativos e seus anunciantes
SELECT
    u.nome_completo,
    m.marca,
    m.modelo,
    a.preco,
    a.status,
    a.descricao_anuncio
FROM public.anuncio a
INNER JOIN public.usuario u
    ON a.id_usuario = u.id_usuario
INNER JOIN public.moto m
    ON a.id_moto = m.id_moto
WHERE a.status = 'ativo'
ORDER BY a.preco ASC;


-- 6. Motocicletas com cilindrada igual ou superior a 250
SELECT
    u.nome_completo,
    m.marca,
    m.modelo,
    m.cilindrada
FROM public.moto m
INNER JOIN public.usuario u
    ON m.id_usuario = u.id_usuario
WHERE m.cilindrada >= 250
ORDER BY m.cilindrada DESC;


-- 7. Usuarios e suas cidades
SELECT
    u.nome_completo,
    u.email,
    u.cidade,
    p.nome_perfil
FROM public.usuario u
INNER JOIN public.perfil p
    ON u.id_usuario = p.id_usuario
WHERE u.cidade IS NOT NULL
ORDER BY u.cidade ASC;


-- 8. Eventos e seus participantes
SELECT
    e.nome_evento,
    e.data_evento,
    e.cidade,
    u.nome_completo,
    p.status
FROM public.evento e
INNER JOIN public.participacao p
    ON e.id_evento = p.id_evento
INNER JOIN public.usuario u
    ON p.id_usuario = u.id_usuario
WHERE e.data_evento IS NOT NULL
ORDER BY e.data_evento ASC;


-- 9. Perfis e informacoes dos usuarios
SELECT
    u.nome_completo,
    u.email,
    p.nome_perfil,
    p.biografia,
    p.interesses
FROM public.perfil p
INNER JOIN public.usuario u
    ON p.id_usuario = u.id_usuario
WHERE p.nome_perfil IS NOT NULL
ORDER BY u.nome_completo ASC;


-- 10. Anuncios ordenados por preco
SELECT
    a.id_anuncio,
    u.nome_completo,
    m.marca,
    m.modelo,
    a.preco,
    a.status,
    a.data_anuncio
FROM public.anuncio a
INNER JOIN public.usuario u
    ON a.id_usuario = u.id_usuario
INNER JOIN public.moto m
    ON a.id_moto = m.id_moto
WHERE a.preco > 0
ORDER BY a.preco DESC;
