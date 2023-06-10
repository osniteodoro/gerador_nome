
/* -------------------------------------------------------------
# Autor: 	Osni Teodoro de Souza Júnior
# Objetivo: Gerar CNPJ para clientes 
-------------------------------------------------------------
*/

Declare @n Int, @n1 Int, @n2 Int, @n3 Int, @n4 Int, @n5 Int, @n6 Int, @n7 Int, @n8 Int, @n9 Int, @n10 Int, @n11 Int, @n12 Int
Declare @d1 Int, @d2 Int

Declare @NumeroCNPJs Int, @Id Int

Create Table #TabelaCNPJ (IdTabela INT, sCNPJ VarChar(18))

Set @NumeroCNPJs = 1
Set @Id = 1

While @NumeroCNPJs < 5000
Begin

	Set @n = 9
	Set @n1 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n2 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n3 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n4 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n5 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n6 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n7 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n8 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n9 = 0
	Set @n10 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n11 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n12 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @d1 = @n12*2+@n11*3+@n10*4+@n9*5+@n8*6+@n7*7+@n6*8+@n5*9+@n4*2+@n3*3+@n2*4+@n1*5
	Set @d1 = 11 - (@d1%11)

	if (@d1>=10)
		Set @d1 = 0
		Set @d2 = @d1*2+@n12*3+@n11*4+@n10*5+@n9*6+@n8*7+@n7*8+@n6*9+@n5*2+@n4*3+@n3*4+@n2*5+@n1*6
		Set @d2 = 11 - (@d2%11)
	if (@d2>=10)
	Set @d2 = 0

	Insert Into #TabelaCNPJ (IdTabela, sCNPJ)
	Select @NumeroCNPJs,
		Cast(@n1 as VarChar)+
		Cast(@n2 as VarChar)+'.'+
		Cast(@n3 as VarChar)+
		Cast(@n4 as VarChar)+
		Cast(@n5 as VarChar)+'.' +
		Cast(@n6 as VarChar)+
		Cast(@n7 as VarChar)+
		Cast(@n8 as VarChar)+'/'+
		Cast(@n9 as VarChar)+
		Cast(@n10 as VarChar)+
		Cast(@n11 as VarChar)+
		Cast(@n12 as VarChar)+'-'+
		Cast(@d1 as VarChar)+
		Cast(@d2 as VarChar)
	

	Set @NumeroCNPJs = @NumeroCNPJs + 1



End


-- Atualiza dados de cliente em DESENV ou HOMOL com resultado da geração anterior
UPDATE pessoa.cliente 
SET numcpf_cnpj = T.sCNPJ
FROM (
    SELECT IdTabela, sCNPJ 
    FROM  #TabelaCNPJ) AS T
WHERE  pessoa.cliente.idcliente = T.IdTabela
AND NOT EXISTS ( SELECT * FROM PESSOA.CLIENTE AS C
                     WHERE D.numcpf_cnpj = T.sCNPJ
				  )	
-- Apaga tabela temporária
drop table #TabelaCNPJ


