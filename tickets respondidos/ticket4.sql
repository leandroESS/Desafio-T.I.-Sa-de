

-- taxa de cancelamento média para cada médico 
select count(case when a.idStatus = -2 then a.id end) as total_cancelamento, 
u.nome, 
count(a.id) as total_marcado,
round((COUNT(CASE WHEN a.idStatus = -2 THEN a.id END) / COUNT(a.id)),2) * 100 AS taxa_media_cancelamento
from usuarios u inner join   agendamentos a 
on a.idUsuario = u.id
group by u.nome;


-- Média de tempo entre a marcação e o cancelamento para cada médico
SELECT floor(AVG(TIMESTAMPDIFF(day, a.marcacao, a.datadesmarcado))) AS media_tempo_cancelamento, u.nome
FROM  agendamentos a inner join usuarios u ON u.id = a.idUsuario 
and a.datadesmarcado IS NOT NULL
group by u.nome;