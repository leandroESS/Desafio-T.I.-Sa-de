


--NÃO SEI O MOTIVO, ALGUNS IDS ESTÃO INCORRETOS ENTRE A RELAÇÃO TABELA PROCEDIMENTOS E TABELA_VALORES, há ids em uma e não em outra
--USEI ESSA QUERY PARA RETORNAR o id procedimento de cada tabela, além das duas tabelas mencionadas a tabela AGENDAMENTOS
-- MINHA LÓGICA ERA QUE ID DA TABELA PROCEDIMENTOS FOSSE "JOGADA" PARA AS OUTRAS DUAS TABELAS
-- SENDO ASSIM PARA SABER O VALOR DE UM PROCEDIMENTO ATENDIDO TERIA QUE USAR AS 3 TABELAS
--O QUE DEU PROBLEMA PQ NEM TODOS OS IDS DA TABELA AGENDAMENTOS SE PERDIAM NA TABELA PROCEDIMENTOS PELO MOTIVO DESCRITO INICIALMENTE
select  distinct idProcedimento from agendamentos where dataatendido IS NOT NULL order by idProcedimento ;
select distinct idProcedimento from tabela_valores order by idProcedimento  ;
select distinct id from procedimentos order by id ;

--QUERY PARA RETORNAR TODOS OS IDS QUE ESTÃO NAS 3 TABELAS

select distinct a.idProcedimento, p.id, v.idProcedimento
from agendamentos a
INNER JOIN procedimentos p  ON a.idProcedimento = p.id
INNER JOIN tabela_valores v ON p.id = v.idProcedimento
where a.dataatendido IS NOT NULL;

--RESPOSTA

select  p.nome, FORMAT(sum(v.procedimentoValor),2,'de_DE')
from agendamentos a
INNER JOIN procedimentos p  ON a.idProcedimento = p.id
INNER JOIN tabela_valores v ON p.id = v.idProcedimento
where a.dataatendido IS NOT NULL
group by p.nome
ORDER BY sum(v.procedimentoValor) DESC;