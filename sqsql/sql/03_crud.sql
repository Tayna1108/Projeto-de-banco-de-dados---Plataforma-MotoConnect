-- 1. CREATE - INSERIR DADOS
INSERT INTO public.usuario
(nome_completo, email, senha, data_nascimento, cidade)
VALUES
('Usuario Teste CRUD',
 'teste.crud@motoconnect.com',
 'senha_teste_123',
 '2000-05-15',
 'Franca')
RETURNING *;


-- 2. READ - CONSULTAR DADOS
SELECT *
FROM public.usuario
WHERE email = 'teste.crud@motoconnect.com';


-- 3. UPDATE - ATUALIZAR DADOS
UPDATE public.usuario
SET nome_completo = 'Usuario Teste CRUD Atualizado'
WHERE email = 'teste.crud@motoconnect.com'
RETURNING *;


-- 4. DELETE - EXCLUIR DADOS
DELETE FROM public.usuario
WHERE email = 'teste.crud@motoconnect.com'
RETURNING *;
