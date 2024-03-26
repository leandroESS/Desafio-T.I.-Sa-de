DROP TABLE IF EXISTS `valores_totais`;
CREATE TABLE `valores_totais` (
`valor` DECIMAL (11,2) default NULL,
`mes` int default null,
`perca` DECIMAL (11,2) DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*RESOLVI FAZER UMA PROCEDURE EM QUE ELE CRIA UM CURSOR E JOGA EM VARIÁVEIS PARA POPULAR A TABELA 'VALORES_TOTAIS' COM O VALOR DE LUCRO E UMA CONSULTA NORMAL
PARA CONTAR O PREJUÍZO */
DELIMITER $$
DROP PROCEDURE IF exists `TESTE2`;
CREATE  PROCEDURE TESTE2()
BEGIN	
      
      DECLARE mes INTEGER;
	  DECLARE valor_total int;
      DECLARE perca VARCHAR(255);
	  DECLARE done INT DEFAULT FALSE;
      DECLARE cursor_qtd_mes CURSOR FOR  SELECT SUM(subquery.total), subquery.month 
      FROM ( -- a Query externa soma por mês os valores do resultado da multiplicação entre o numero de ocorrencias pelo valor do procedimento
            SELECT COUNT(a.idProcedimento) * t.procedimentoValor AS total, MONTH(a.dataatendido) AS month
            FROM agendamentos a
            INNER JOIN procedimentos p ON a.idProcedimento = p.id -- Join entre 3 tabelas: agendamento, tabela_valores e procedimentos
            INNER JOIN tabela_valores t ON t.idProcedimento = p.id
            WHERE a.idStatus = 2  -- Condição que status seja 2, ou seja, atendido para calcular lucro
            GROUP BY MONTH(a.dataatendido), t.procedimentoValor
        ) AS subquery
      GROUP BY subquery.month;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;      
      
      OPEN cursor_qtd_mes;
      
      read_loop: LOOP
       FETCH cursor_qtd_mes INTO valor_total, mes;
       IF DONE THEN
        LEAVE read_loop;
	   END IF;
       INSERT INTO `valores_totais` VALUES (valor_total, mes,NULL);
      END LOOP; 
      
	 INSERT INTO  `valores_totais` (perca) SELECT SUM(subquery2.total)
     FROM (
           SELECT COUNT(a.idProcedimento) * t.procedimentoValor AS total
           FROM agendamentos a
           INNER JOIN procedimentos p ON a.idProcedimento = p.id
           INNER JOIN tabela_valores t ON t.idProcedimento = p.id
           WHERE a.dataatendido IS NULL -- -- fiquei bastante confuso, tinha  dados com status -2 (desmarcado) e ao mesmo tempo data de atendido, me baseei em datas em null que não teve atedimento
           GROUP BY t.procedimentoValor
          ) AS subquery2;     
          
         
      
END;

call TESTE2();

SELECT FORMAT(valor, 2, 'de_DE') as LUCRO , mes as MÊS , FORMAT(perca,2,'de_DE') AS PREJUIZO FROM valores_totais ORDER BY MeS;