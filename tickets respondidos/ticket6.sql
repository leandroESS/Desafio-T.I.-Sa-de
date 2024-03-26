
-- CODIGO NÃO PEGA NO WORKBENCH, rodei no terminal e foi de boa
----------------6.1-----------------------

 SELECT DATE_FORMAT(a.data, '%d/%m/%Y') as data , count(a.idUsuario) as quantidade,
   CASE
      WHEN a.idStatus = 2 THEN 'Atendidos' 
      WHEN a.idStatus IN (-1,-2,0) THEN 'no-show'
      WHEN a.idStatus = 1 THEN 'Horários Restantes'
	END as tipo,
    a.idUsuario  
from agendamentos a where a.idStatus NOT IN (3,4,5,6)
 group by data, a.idUsuario, a.idStatus;



--------------6.2-----------------


SELECT year(b.data) as ano, month(b.data) as mes,
  CASE
      WHEN b.idStatus = 2 THEN 'Atendidos' 
      WHEN b.idStatus IN (-1,-2,0) THEN 'no-show'      
  END as tipo,
  FORMAT(SUM(subquery.total), 2, 'de_DE') as VALOR
      FROM ( -- a Query externa soma do resultado da multiplicação da quantidade de usuario agrupado pelo status e valor do procedimento,
            SELECT count(a.idUsuario)* t.procedimentoValor AS total, a.idStatus
            FROM agendamentos a
            INNER JOIN procedimentos p ON a.idProcedimento = p.id -- Join entre 3 tabelas: agendamento, tabela_valores e procedimentos para o calculo do valor
            INNER JOIN tabela_valores t ON t.idProcedimento = p.id
            GROUP BY a.idStatus, t.procedimentoValor
        ) AS subquery, agendamentos b
        WHERE b.idStatus NOT IN (1,3,4,5,6) -- só consideranto no-show e atendidos
      GROUP BY year(b.data), month(b.data), tipo; -- agrupar select externo como foi dito na questão










 -------------------------------------------

 
