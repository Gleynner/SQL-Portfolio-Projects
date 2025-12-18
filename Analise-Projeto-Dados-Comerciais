#  Projeto Análise de Dados Comerciais


Este projeto é composto por cinco perguntas que devem ser respondidas com base nos dados fornecidos. Para isso, 
são disponibilizadas quatro tabelas, listadas a seguir:

1. order_detail
2. sku_detail
3. customer_detail
4. payment_detail


Segue abaixo a explicação de cada uma das tabelas de dados fornecidos.

##                          DICIONÁRIO DE DADOS
__________________________________________________________________________
order_detail (detalhe do pedido)

1. id → número único do pedido / id_order
2. customer_id → número único do cliente
3. order_date → data em que a transação foi realizada
4. sku_id → número único do produto (SKU – Stock Keeping Unit)
5. price → preço exibido na etiqueta do produto
6. qty_ordered → quantidade do produto comprada pelo cliente
7. before_discount → valor total do preço do produto (price × qty_ordered)
8. discount_amount → valor total do desconto do produto
9. after_discount → valor total do produto após a aplicação do desconto
10. is_gross → indica que o cliente ainda não pagou o pedido
11. is_valid → indica que o cliente já realizou o pagamento
12. is_net → indica que a transação foi finalizada
13. payment_id → número único do método de pagamento
__________________________________________________________________________

sku_detail (detalhe do produto)

1. id → número único do produto (pode ser usado como chave para join)
2. sku_name → nome do produto
3. base_price → preço do produto exibido na etiqueta
4. cogs → Cost of Goods Sold / custo total para vender 1 unidade do produto
5. category → categoria do produto
__________________________________________________________________________

customer_detail (detalhe do cliente)

1. id → número único do cliente
2. registered_date → data em que o cliente se registrou como membro
__________________________________________________________________________

payment_detail (detalhe do pagamento)

1. id → número único do método de pagamento
2. payment_method → método de pagamento utilizado
__________________________________________________________________________


Vamos ressaltar que na tabela transacional (ou tabela Fato) "order_detail" temos variáveis chaves 
(chaves estrangeiras) para unir às tabelas dimensionais "sku_detail", "customer_detail" e "payment_detail". 
Todas as 5 perguntas devem ser respondidas usando as tabelas acima. AS perguntas e suas respectivas 
resposta estão dispostas a seguir: 
