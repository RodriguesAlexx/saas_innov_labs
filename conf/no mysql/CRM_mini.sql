-- aqui um banco de dados que em aula exploro como data warehouse...
create user 'saas'@'localhost' identified by 'saas';
create database controle_de_inventário;
grant all privileges on controle_de_inventário .* to 'saas'@'localhost';
flush privileges;
use controle_de_inventário;
create table Fornecedor (cnpjPK varchar(18) not null primary key, nome varchar(50) not null, contato varchar(50) not null);
create table Categoria (idPK int not null auto_increment primary key, tipo varchar(50) not null);
create table Produto (idPK int not null auto_increment primary key, nome varchar(50) not null, descricao varchar(200) not null, preco float not null, estoque int, categoriaIdFK int not null, fornecedorFK int not null, foreign key (categoriaIdFK) references Categoria(idPK), foreign key (fornecedorFK) references Fornecedor(cnpjPK));
create table Inventario (idProdPK int not null primary key, quantidade int not null, contatoFornFK varchar(50) not null, foreign key (idProdPK) references Produto(idPK), foreign key (contatoFornFK) references Fornecedor(contato));
exit;
