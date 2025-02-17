create database if not exists BDIII;
use BDIII;
create table if not exists pessoa(
id_pes int auto_increment not null,
nome_pes varchar(45) not null,
cpf_pes char(11) unique not null,
data_nasc_pes date not null,
primary key(id_pes)
);

create table if not exists garagem(
id_gar int auto_increment not null,
ident_gar varchar(45) not null,
primary key(id_gar)
);

create table if not exists reservista(
id_res int auto_increment not null,
id_pes int not null unique,
sit_res enum("Ativa","Reserva  ") not null,
data_emis_res date not null,
primary key(id_res),
foreign key(id_pes) references pessoa(id_pes)
);

create table if not exists veiculo(
id_vec int auto_increment not null,
id_pes int not null,
mod_vec varchar(45) not null,
marca_vec varchar(45) not null,
placa_vec char(7) not null,
primary key(id_vec),
foreign key(id_pes) references pessoa(id_pes)
);

create table if not exists vec_has_gar(
id_al int auto_increment,
id_vec int not null,
id_gar int not null,
entrada_al datetime,
vaga_al int not null,
saida_al datetime,
primary key(id_al,id_vec,id_gar),
foreign key(id_vec) references veiculo(id_vec),
foreign key(id_gar) references garagem(id_gar)
);

desc pessoa;
insert into Pessoa(nome_pes,cpf_pes,data_nasc_pes) values
("Josney","44839484758","1985-04-19"),
("Karla","44839484337","1994-05-02"),
("Mirosmar","32993039485","1974-11-12"),
("Vanessa","48993849584","2002-06-20");
