/*NOME: Thiago Caetano da Silva Ferreira*/
create database if not exists atv_10_03;
use atv_10_03;



create table if not exists projeto(
cod_proj int auto_increment,
tipo_proj varchar(35) not null,
data_ini_proj date not null,
primary key(cod_proj)
);

create table if not exists categoria(
cod_cat int auto_increment,
nome_cat varchar(45) not null,
primary key(cod_cat)
);


create table if not exists empregado(
cod_emp int auto_increment,
nome_emp varchar(45) not null,
cod_cat int not null,
primary key(cod_emp),
foreign key(cod_cat) references categoria(cod_cat)
);

#tabela de relacionamento
create table if not exists proj_emp(
cod_proj int not null,
cod_emp int not null,
data_ini_proj_emp date not null,
tem_ai_proj_emp int not null, #tempo que fica no projeto
primary key(cod_proj,cod_emp),
foreign key(cod_proj) references projeto(cod_proj),
foreign key(cod_emp) references empregado(cod_emp)
);

#inserindo valores
insert into categoria (nome_cat) values ('gerente');
insert into projeto (tipo_proj, data_ini_proj) 
values ('construção de um carro','2025-01-02');
insert into empregado (nome_emp,cod_cat) 
values ('Geraldo Pereira','1');
insert into proj_emp (cod_proj, cod_emp, data_ini_proj_emp, tem_ai_proj_emp) values(1,1,'2025-01-02',45); 

#criando o select
select c.nome_cat, e.nome_emp, r.tem_ai_proj_emp, p.tipo_proj 
from categoria as c inner join empregado  as e on c.cod_cat = e.cod_cat
inner join proj_emp as r on e.cod_emp = r.cod_emp
inner join projeto as p on r.cod_proj = p.cod_proj;

#criando a view
create view consulta1 as  select c.nome_cat, e.nome_emp, r.tem_ai_proj_emp, p.tipo_proj 
from categoria as c inner join empregado  as e on c.cod_cat = e.cod_cat
inner join proj_emp as r on e.cod_emp = r.cod_emp
inner join projeto as p on r.cod_proj = p.cod_proj;

#teste
select * from consulta1;

#alterando a view
alter view consulta1 as select c.nome_cat, e.nome_emp, r.data_ini_proj_emp, p.tipo_proj 
from categoria as c inner join empregado  as e on c.cod_cat = e.cod_cat
inner join proj_emp as r on e.cod_emp = r.cod_emp
inner join projeto as p on r.cod_proj = p.cod_proj;

#teste
select * from consulta1;
#criando usuário
##create user "nome"@"host" identified by senha";
create user "josney"@"localhost" identified by "etecjk1234";
/*Conceder Privilégios*
Manipulação de dados: insert, select, update, delete
Manipulação de tabelas: create, drop, alter

comando:
grant privilegio on nomedabase.nomedatabela to "nome"@"host";
todos os privilégios: grant all privileges on nomedabase.nomedatabela to "nome"@"host"
recarregar os privilégios:flush privileges
revogar privilégios: revoke privilegios on base.tabelas from "nome"@"host"
*/

grant select on atv_10_03.* to "josney"@"localhost"; 
flush privileges;

revoke all privileges on *.* from "josney"@"localhost";