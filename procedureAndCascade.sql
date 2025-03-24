create database Empresa;
use Empresa;
create table Usuario (
	id_usuario int primary key not null auto_increment,
	nome_user varchar(50) not null,
	email_user varchar(50) not null unique,
	senha_user varchar(50) not null,
	cpf_user char(11) not null unique,
    data_cad_user date
);

/*Stored Procedure: São funções que criamos no banco de dados onde ações são executadas quando a procedure é chamada
	Sintaxe: 
		delimiter $$
		create procedure nomedaprocedure(parametros)
        begin
			comandos
        end
        $$                                       
*/
desc usuario;
delimiter $$
create procedure pc_add(nome varchar(50), email varchar(50), senha varchar(50), cpf varchar(11), data_cad date)
begin
insert into usuario(nome_user, email_user, senha_user, cpf_user, data_cad_user) values(nome,email,senha,cpf,data_cad);
select * from usuario where id_usuario = last_insert_id(); #last_insert_id(); é o comando para buscar o ultimo id cadastrado em uma tabela
end
$$

##chamar a procedure 
##call nomedaprocedure(valores,valores)

call pc_add('Claudinei Moreira','claudiomir@gmail.com','123456','12345678910',current_date());

call pc_add('Monica Avelange','moniquinha@yahoo','123456','12345678911',current_date());

desc Usuario;
#criando procedure que deleta um usuario
delimiter $$
create procedure pc_delete(id int)
begin
delete from usuario where id_usuario = id;
select * from usuario;
end
$$
select * from usuario;
call pc_delete(1);





delimiter $$
create procedure sel_user()
begin
select * from usuario;
end
$$
desc usuario;
call sel_user;
call pc_add('jose','jose@gmail.com','12313','1323133112',current_time());



#criando tabela de reservista

create table if not exists Reservista(
	id_res int auto_increment,
    num_res char(10) not null unique,
    data_res date not null,
    id_user int unique not null,
    primary key(id_res),
    foreign key(id_user) references usuario(id_usuario) on delete cascade on update cascade
);

call pc_add('Reacher','reacher.army@gmail.com','8458f98','5236464654','2010-10-20');
insert into reservista(num_res,data_res,id_user) values ('10','2018-12-12',6);
call pc_delete(6);
select * from reservista;
)987987987
/*
É possivel definir o que ocorre com um cadastro caso o elemento pai seja excluido:
RESTRICT: Rejeita atualização ou exclusão do elemento pai
CASCADE: Atualiza ou exlcue os registros da tabela filho
SET NULL: Define o valor nulo para a tabela filho caso o pai seja excluído
NO ACTION: Equivalente ao restrict
SET DEFAULT: define um valor padrão para a tabela filha caso o pai seja excluido  
*/