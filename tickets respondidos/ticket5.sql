USE tisaude;


--CRIAÇÃO DA TABELA
DROP TABLE IF EXISTS `OKRs`;
CREATE TABLE `OKRS` (
`quantidade` int default NULL,
`data1` date default null
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER $$
DROP PROCEDURE IF exists `TESTE`;
CREATE  PROCEDURE TESTE()
BEGIN	
      DECLARE qtd INTEGER;
      DECLARE dataAten DATE;
	  DECLARE done INT DEFAULT FALSE;
      DECLARE cursor_qtd CURSOR FOR select count(*), date(dataatendido) 
      from agendamentos a
      WHERE NOT EXISTS ( SELECT 1 FROM `OKRs` o WHERE o.data1 = date(a.dataatendido)) -- para ele não repetir a mesma data toda meia noite
      AND dataatendido IS NOT NULL 
      GROUP BY date(dataatendido); -- pegando por data, sem hora
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;      
      
      OPEN cursor_qtd;
      
      read_loop: LOOP
       FETCH cursor_qtd INTO qtd, dataAten;
       
       IF DONE THEN
        LEAVE read_loop;
	   END IF;
         INSERT INTO `OKRs` VALUES (qtd, dataAten);
       COMMIT;
      END LOOP; 
END;

call TESTE();

SELECT * FROM `OKRs`;

--CRIAÇÃO DO EVENTO


-- NÃO CRIEI UM GATILHO, MAS SIM UM EVENTO PARA SER DISPARADO TODO DIA A MEIA NOITE CHAMANDO A PROCEDURE QUE TEM O CURSOR PARA FAZER O QUE FOI PEDIDO, 
--PQ GATILHOS SÃO DISPARADOS A PARTIR DE UMA CONSULTA DML
-- UPDATE, INSERT, DELETE
CREATE EVENT IF NOT EXISTS insere_qtd_consultas ON SCHEDULE EVERY  1 DAY
STARTS TIMESTAMP(CURRENT_DATE + INTERVAL 1 DAY) ON COMPLETION PRESERVE -- TODO DIA A MEIA NOITE
DO 
  CALL TESTE();