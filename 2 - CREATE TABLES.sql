
/*
DROP TABLE IF EXISTS pessoa.basenome;

DROP TABLE IF EXISTS pessoa.sobrenome;

DROP TABLE IF EXISTS pessoa.cliente;
*/



CREATE TABLE pessoa.basenome  
(  
    idnome int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nome character varying(200),
	tiponac character varying(3)
   	
);  



CREATE TABLE pessoa.sobrenome 
(  
    idsobrenome int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	surname character varying(300),
	tiponac character varying(3)
   	
);  


CREATE TABLE pessoa.cliente 
(  
    idcliente int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	descnomecompleto character varying(300) NOT NULL,
	numcpf_cnpj character varying(14),
	codibge_endereco INT  NULL,
	tipo_pessoa CHAR(1),
	codigonome bigint UNIQUE
);  



