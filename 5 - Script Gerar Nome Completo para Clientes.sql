/* -------------------------------------------------------------
# Autor: 	Osni Teodoro de Souza Júnior
# Objetivo: Gerar dados com nome completo para tabela Clientes. Criar nomes fictícios ou com menor probabilidade de existência pois são nomes raros. 
-------------------------------------------------------------
*/

/* Temporária para preencher com nome completo*/
CREATE TABLE #dados (
    iddados int,
    descnomecompleto character varying(300) NOT NULL,
	codigonome bigint
);


DECLARE @cnt 				INT = 0;
DECLARE @cnt_total 			INT = 1000; /* Define o máximo de nomes a serem gerados*/
DECLARE @count_nome 		INT = 0;
DECLARE @count_sobrenome 	INT = 0;

DECLARE @nome 			character varying(300);
DECLARE @sobrenome_1 	character varying(300);
DECLARE @sobrenome_2 	character varying(300)

SET @count_nome		= (SELECT COUNT(*) AS CONTATOR FROM pessoa.basenome)
SET @count_sobrenome = (SELECT COUNT(*) AS CONTATOR FROM pessoa.sobrenome)


WHILE @cnt < @cnt_total
BEGIN

DECLARE @id_nome 			INT = 0;
DECLARE @id_sobrenome_1 	INT = 0;
DECLARE @id_sobrenome_2 	INT = 0;


set @id_nome 		= (select round(CAST (RAND()*@count_nome	 AS NUMERIC),0));
set @id_sobrenome_1 = (select round(CAST (RAND()*@count_sobrenome AS NUMERIC),0)); 
set @id_sobrenome_2 = (select round(CAST (RAND()*@count_sobrenome AS NUMERIC),0));

set @nome		= (select nome from  pessoa.basenome where idnome = @id_nome);
set @sobrenome_1 = (select surname from pessoa.sobrenome where idsobrenome = @id_sobrenome_1);
set @sobrenome_2 = (select surname from pessoa.sobrenome where idsobrenome = @id_sobrenome_2);
 
/* Caso deseje printar o que está sendo gerado. Verificar os códigos para nome e sobrenome (1 e 2) e Nomes com Sobrenomes gerados)
print 'Id Nome: ' +cast(@id_nome as varchar) 
print 'Id Sobrenome 1: ' +cast(@id_sobrenome_1 as varchar) 
print 'Id Sobrenome 2: ' +cast(@id_sobrenome_2 as varchar) 

print 'Nome: ' +cast(@nome as varchar) 
print 'Sobrenome 1: ' +cast(@sobrenome_1 as varchar) 
print 'Sobrenome 2: ' +cast(@sobrenome_2 as varchar) 
*/

/*Preenche a temporária de acordo com códigos (nome, sobrenome1 e sobrenome2)*/
INSERT INTO #dados (iddados,descnomecompleto,codigonome) 
select ROW_NUMBER() OVER (
ORDER BY x.idnome
) id,
      CONCAT(cast(x.nome_1 as varchar) ,' ', cast(x.nome_2 as varchar) ,' ', cast(x.sobrenome_1 as varchar) ,' ', cast(x.sobrenome_2 as varchar)) as nome,
	  cast(@id_nome as varchar)+cast(@id_sobrenome_1 as varchar)+cast(@id_sobrenome_2 as varchar) as codigo
from 

(
select  idnome,
		nome as nome_1,
        @nome as nome_2,  
        @sobrenome_1 as sobrenome_1,
	    @sobrenome_2 as sobrenome_2
from pessoa.basenome
 where idnome = @id_nome
 ) as x



  SET @cnt = @cnt + 1;
END;

/*Gravar dados na tabela cliente*/
INSERT INTO pessoa.cliente (descnomecompleto,codigonome)
select d.descnomecompleto, codigonome
from #dados as d
where not exists ( select * from pessoa.cliente as c
                     where d.codigonome = c.codigonome
				  )	 
group by d.descnomecompleto, codigonome



drop table #dados



