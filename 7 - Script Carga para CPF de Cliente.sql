
/* -------------------------------------------------------------
##### Autor: 	Osni Teodoro de Souza Júnior
##### Objetivo: Gerar CPF para clientes 
##### 
-------------------------------------------------------------
*/

Declare @n Int, @n1 Int, @n2 Int, @n3 Int, @n4 Int, @n5 Int, @n6 Int, @n7 Int, @n8 Int, @n9 Int
Declare @d1 Int, @d2 Int

Declare @NumeroCPFs Int, @Id Int

Create Table #TabelaCPF (IdTabela INT, sCPF VarChar(14))

Set @NumeroCPFs = 1
Set @Id = 1

While @NumeroCPFs < 1000
Begin

	Set @Id = @NumeroCPFs;
	Set @n = 9;
	Set @n1 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n2 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n3 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n4 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n5 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n6 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n7 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n8 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @n9 = Cast((@n + 1) * RAND(CAST(NEWID() AS varbinary )) as int)
	Set @d1 = @n9*2+@n8*3+@n7*4+@n6*5+@n5*6+@n4*7+@n3*8+@n2*9+@n1*10;
	Set @d1 = 11 - (@d1%11);
	if (@d1>=10)
		Set @d1 = 0
		Set @d2 = @d1*2+@n9*3+@n8*4+@n7*5+@n6*6+@n5*7+@n4*8+@n3*9+@n2*10+@n1*11;
		Set @d2 = 11 - ( @d2%11 );
	if (@d2>=10)
		Set @d2 = 0;

		Insert Into #TabelaCPF (IdTabela, sCPF)
		Values (@Id,
		Cast(@n1 as VarChar)+
		Cast(@n2 as VarChar)+
		Cast(@n3 as VarChar)+'.'+
		Cast(@n4 as VarChar)+
		Cast(@n5 as VarChar)+
		Cast(@n6 as VarChar)+'.'+
		Cast(@n7 as VarChar)+
		Cast(@n8 as VarChar)+
		Cast(@n9 as VarChar)+'-'+
		Cast(@d1 as VarChar)+
		Cast(@d2 as VarChar))

	Set @NumeroCPFs = @NumeroCPFs + 1



End



UPDATE pessoa.cliente 
SET numcpf_cnpj = T.sCPF
FROM (
    SELECT IdTabela, sCPF 
    FROM  #TabelaCPF) AS T
WHERE  pessoa.cliente.idcliente = T.IdTabela
AND NOT EXISTS ( SELECT * FROM PESSOA.CLIENTE AS C
                     WHERE D.numcpf_cnpj = T.sCPF
				  )	 

drop table #TabelaCPF

/*
select * from pessoa.cliente as p
 where p.idpessoa > 2000
 */



/*
drop table #TabelaCPF


select * from #TabelaCPF

select * from pessoa.cliente


update pessoa.cliente
 set tipo_pessoa = 'F'
 where idcliente between 1000 and 5000

  update pessoa.cliente
 set tipo_pessoa = 'J'
 where idcliente between 5000 and 10000

*/

