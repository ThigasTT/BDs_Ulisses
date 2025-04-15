create database if not exists lojinha;
use lojinha;
create table if not exists Produto(
	id_prod int auto_increment,
    nome_prod varchar(255) not null,
    preco_unit decimal(5,2) not null,
    estoque_prod int unsigned default 0,
    primary key(id_prod)
);
insert into Produto(nome_prod,preco_unit,estoque_prod)values
('Pão de Forma Panco',8.49,427),('Creme dental Colgate',4.35,592),
('Leite UHT Aurora',5.99,384);
create table if not exists itens_venda(
	id_venda int auto_increment,
    id_prod int not null,
    quantidade int,
    primary key(id_venda),
    foreign key(id_prod) references Produto(id_prod)
);

## Trigger que gera uma baixa no estoque na tabela produto
## toda vez que um insert ocorre na tabela itens_venda
delimiter $$
create trigger tr_compra after insert on itens_venda
for each row
begin
update Produto set estoque_prod=estoque_prod-new.quantidade 
where id_prod=new.id_prod;
end
$$

insert into itens_venda(id_prod,quantidade)values(2,10);
insert into itens_venda(id_prod,quantidade)values(1,2);

create table if not exists preco_hist(
	id_hist int auto_increment,
    id_prod int not null,
    valor_antigo decimal(5,2) not null,
    data_hist date,
    primary Key(id_hist),
    foreign key(id_prod) references Produto(id_prod));
    
    delimiter $$
    create trigger tr_hist_preco before update on Produto
    for each row
    begin
    if old.preco_unit!=new.preco_unit then
		insert into preco_hist(id_prod,valor_antigo,data_hist)
        values(old.id_prod,old.preco_unit,curdate());
    end if;
    end
    $$
    update Produto set preco_unit=9.37 where id_prod=1;
    select * from preco_hist;
    select * from produto;
    update Produto set estoque_prod=500 where id_prod=1;
    