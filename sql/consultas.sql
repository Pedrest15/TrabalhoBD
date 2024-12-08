-- seleciona informações sobre as organizações universitárias participantes de cada torneio
SELECT DISTINCT
     t.Nome  AS "Nome do Torneio",
     ou.Nome AS "Nome da Organizacao",
     ou.Tipo AS "Tipo da Organizacao",
     u.Nome  AS "Nome da Universidade"
 FROM
     Torneio t
 JOIN
     Jogo j ON t.Nome = j.Torneio
 JOIN
     Time_Disputa_Jogo tdj ON j.ID = tdj.Jogo
 JOIN
     Time ti ON tdj.Time = ti.ID
 JOIN
     Organizacao_Universitaria ou ON ti.Universidade = ou.Universidade AND ti.Organizacao_Universitaria = ou.Nome
 JOIN
     Universidade u ON ou.Universidade = u.Codigo_MEC
 ORDER BY
     t.Nome, ou.Nome;

-- seleciona júizes com experiência acima da média para o esporte em que atuam
SELECT
    j.Nome AS Juiz,
    j.Esporte,
    j.Anos_Experiencia AS "Experiencia do Juiz",
    e.Media_Experiencia AS "Media Experiencia Esporte"
FROM
    Juiz j
JOIN
    (SELECT
         Esporte,
         ROUND(AVG(Anos_Experiencia), 2) AS Media_Experiencia
     FROM
         Juiz
     GROUP BY
         Esporte) e
    ON j.Esporte = e.Esporte
WHERE
    j.Anos_Experiencia > e.Media_Experiencia
ORDER BY
    j.Esporte, j.Anos_Experiencia DESC;

-- seleciona os atletas mais velhos de cada esporte
SELECT DISTINCT
       A.Nome AS Atleta, 
       T.Esporte, 
       MAX(A.Idade) OVER (PARTITION BY T.Esporte) AS Idade_Maxima
FROM Atleta A
JOIN Atleta_Participa_Time APT ON A.CPF = APT.Atleta
JOIN Time T ON APT.Time = T.ID
ORDER BY T.Esporte, Idade_Maxima DESC;

-- seleciona jogos sem juízes
SELECT
    j.id as "ID Jogo",
    j.torneio AS Torneio,
    l.Rua || ', ' || l.Bairro || ' - ' || l.Cidade AS Local,
    j.DataHora
FROM 
    Jogo j
JOIN 
    Local l ON j.Local = l.ID
LEFT JOIN 
    Juiz_Apita_Jogo jaj ON j.ID = jaj.Jogo
WHERE 
    jaj.Jogo IS NULL
ORDER BY 
    j.DataHora;

-- seleciona times disponíveis para se inscrever e participar 
SELECT
    t.ID AS Time_ID,
    t.Esporte,
    t.Universidade,
    t.Organizacao_Universitaria,
    t.Genero
FROM
    Time t
LEFT JOIN
    Time_Disputa_Jogo tdj ON t.ID = tdj.Time
LEFT JOIN
    Jogo j ON tdj.Jogo = j.ID
WHERE
    (j.ID IS NULL OR j.DataHora > SYSDATE) -- times não associados a jogos futuros
GROUP BY
    t.ID, t.Esporte, t.Universidade, t.Organizacao_Universitaria, t.Genero
HAVING
    EXISTS (
        SELECT 1
        FROM Atleta a
        WHERE a.Genero = t.Genero
    )
ORDER BY
    t.Esporte, t.Universidade, t.Organizacao_Universitaria;

-- consulta de atléticas que participaram de todos os torneios finalizados
-- consulta de divisão relacional
SELECT a.Universidade, a.Nome AS Atletica
FROM Atletica a
JOIN Time t ON a.Universidade = t.Universidade
JOIN Time_Disputa_Jogo tdj ON t.ID = tdj.Time
JOIN Jogo j ON tdj.Jogo = j.ID
JOIN Torneio tor ON j.Torneio = tor.Nome
WHERE 
    tor.Tipo = 'ATLÉTICA' AND 
    tor.Campeao IS NOT NULL
GROUP BY 
    a.Universidade, a.Nome
HAVING 
    COUNT(DISTINCT tor.Nome) = 
    (
        SELECT 
            COUNT(DISTINCT tor.Nome)
        FROM Torneio tor
        WHERE 
            tor.Tipo = 'ATLÉTICA' 
            AND tor.Campeao IS NOT NULL
    );

