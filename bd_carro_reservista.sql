create database if not exists bd_17_02;
use bd_17_02;
 create table if not exists Pessoa(
	id_pes int auto_increment ,
    nome_pes varchar(255) not null,
    cpf_pes char(11) unique not null,
    data_nasc_pes date not null,
    primary key(id_pes)
 );
 create table if not exists Garagem(
	id_gar int auto_increment,
    indent_gar varchar(255) not null,
    primary key(id_gar)
 );
 create table if not exists Reservista(
	id_res int not null auto_increment,
    id_pes int not null unique,
    sit_res enum("Ativa","Reserva") not null,
    data_emis_res date not null,
    primary key(id_res),
    foreign key(id_pes) references Pessoa(id_pes)
 );
 create table if not exists Veiculo(
	id_vec int auto_increment,
    id_pes int not null,
    mod_vec varchar(100) not null,
    marca_vec varchar(100) not null,
    placa_vec char(7) not null,
    primary key(id_vec),
    foreign key(id_pes) references Pessoa(id_pes)
 );
 
 create table if not exists vec_has_gar(
	id_al int auto_increment,
	id_vec int not null,
    id_gar int not null,
    entrada_al datetime,
    vaga_al int not null,
    saida_al datetime,
    primary key(id_al,id_vec,id_gar),
    foreign key(id_vec) references Veiculo(id_vec),
    foreign key(id_gar) references Garagem(id_gar));
    
    desc Reservista;
    insert into Pessoa(nome_pes,cpf_pes,data_nasc_pes)
    values
    ("Josney","44839484758","1985-04-19"),
    ("Karla","44843948337","1994-05-02"),
    ("Mirosmar","32993039485","1974-11-12"),
    ("Vanessa","48993849584","2002-06-20");
    insert into Reservista(id_pes,sit_res,data_emis_res)
    values
    (3,"Reserva","1987-09-15");
    select *from pessoa;	
    #atualizando linhas na tabela
    update Pessoa set data_nasc_pes = "1994-05-10" where id_pes = 2;
    #deletando pessoas
     delete from pessoa where id_pes = 1;
     desc veiculo;
	insert into veiculo values 
    (1,4,'HB20 Hatch1.6','Hyundai',upper('gek3s93')),
    (2,3,'Monza2.0','Chevrolet',upper('kvs3i23'));
	
	insert into garagem(indent_gar) values
    ('Shopping Riviera'),('AV.Brazil'),('Jabaquara'),('Centro Diadema');
	
    insert into vec_has_gar(id_vec,id_gar,entrada_al,vaga_al)values
    (1,3,now(),5),(2,4,'2025-01-04 13:45',2),(1,2,'2025-02-24 14:53',27);
    
    select * from vec_has_gar; 
    
    #cadastrando a saida do veículo
    update vec_has_gar set saida_al = '2025-01-04 15:42' where id_al = 2;
    
    #consultando os veiculos que estao na garagem
    select * from vec_has_gar where saida_al is null;
    #CONTAR a quantidade de veículos que estão na garagem
	select count(*) from vec_has_gar where saida_al is null;
    
    select p.nome_pes,v.mod_vec,g.indent_gar,al.entrada_al,al.saida_al
    from pessoa as p inner join veiculo as v on p.id_pes = v.id_pes
    inner join vec_has_gar as al on v.id_vec = al.id_vec
    inner join garagem as g on g.id_gar = al.id_gar;
    
    /*VIEW: uma tabela virtual cujo conteúdo é definido por uma consulta,
    é utilizado quando uma determinada consulta se tornar rotina dentro de um banco*/
    
    #criando uma vview
    create view vw_consulta1 as select p.nome_pes,v.mod_vec,g.indent_gar,al.entrada_al,al.saida_al
    from pessoa as p left join veiculo as v on p.id_pes = v.id_pes
    inner join vec_has_gar as al on v.id_vec = al.id_vec
    inner join garagem as g on g.id_gar = al.id_gar;
    
    select * from vw_consulta1;
    
    update vec_has_gar set saida_al = now() where id_al = 1;
    
    #alteramdo a tabela virtual
    alter view vw_consulta1 as select p.nome_pes,v.mod_vec,g.indent_gar,al.entrada_al,al.saida_al
    from pessoa as p left join veiculo as v on p.id_pes = v.id_pes
    inner join vec_has_gar as al on v.id_vec = al.id_vec
    inner join garagem as g on g.id_gar = al.id_gar;
    
    