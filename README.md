# Database diagram:

Arquivo README_db_schema.png na raíz do app.

# Instalação:

bin/setup
yarn install
yarn build


# Pré-populando o DB (Seeds):

Rodar rails db:seed
carregar informação no bando de dados.


# Testes:

RSpec
bundler exec rspec

# Descritivo:

A aplicação te possibilita 
  -> criar modalidades de transporte
  -> criar tabela de valores do transporte
  -> criar tabela de prazo de entrega para o transporte
  -> acessar lista de modalidades
  -> cadastrar veiculos
  -> editar cadastro de veículos
  -> cadastrar tipos de veículos
  -> cadastrar categorias de veículos
  -> gerar lista de veículos cadastrados
  -> criar pedidos
  -> editar cadastro de pedidos
  -> iniciar pedido
  -> selecionar modalidade
  -> acessar detalhes do pedido
  -> finalizar pedido
  -> cancelar pedido

Características:
  -> não é possível editar pedido depois de iniciado
  -> não e possivel cancelar o pedido após iniciado
  -> não é possivel editar tipos e categorias de veículos
  




# Executando a aplicação:


Login: user@email.com.br | Senha: pwd123456