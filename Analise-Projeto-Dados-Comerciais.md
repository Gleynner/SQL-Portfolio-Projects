#  Projeto Análise de Dados Comerciais


Este projeto é composto por cinco perguntas que devem ser respondidas com base nos dados fornecidos. Para isso, são disponibilizadas quatro tabelas, listadas a seguir:

1. order_detail
2. sku_detail
3. customer_detail
4. payment_detail


Segue abaixo a explicação de cada uma das tabelas de dados fornecidos.

###                         DICIONÁRIO DE DADOS
________

### order_detail (detalhe do pedido)

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


### sku_detail (detalhe do produto)

1. id → número único do produto (pode ser usado como chave para join)
2. sku_name → nome do produto
3. base_price → preço do produto exibido na etiqueta
4. cogs → Cost of Goods Sold / custo total para vender 1 unidade do produto
5. category → categoria do produto


### customer_detail (detalhe do cliente)

1. id → número único do cliente
2. registered_date → data em que o cliente se registrou como membro


### payment_detail (detalhe do pagamento)

1. id → número único do método de pagamento
2. payment_method → método de pagamento utilizado
______


Vamos ressaltar que na tabela transacional (ou tabela Fato) "order_detail" temos variáveis chaves (chaves estrangeiras) para unir às tabelas dimensionais "sku_detail", "customer_detail" e "payment_detail". Todas as 5 perguntas devem ser respondidas usando as tabelas acima. As perguntas e suas respectivas resposta estão dispostas a seguir: 


Vamos de fato ao que foi pedido ao analista de dados!!!

<br>
<br>

## QUESTÃO 1
<br> 

> Durante as transações ocorridas em 2021, em qual mês o valor total da transação (after_discount) atingiu seu pico? Utilize "is_valid = 1" para filtrar os dados da transação. Tabela de origem: "order_detail".


**RESPOSTA 1**

A partir do exercício proposto, definimos as colunas "Mes_ID", "Mes_nome", "Ano" e "Valor_total_transacao" para estarem presentes no resultado de nossa consulta. Para isso, filtramos os dados para o ano de 2021 e somamos o total de transações para cada mês e, em seguida, ordenamos em ordem decrescente os valores totais de transaçoes realizada, considerando apenas as transações em que os clientes já realizaram o pagamento (is_valid = 1).

Abaixo segue o trecho de código para solucionar o problema proposto.



<br>
<div align="center">
       <img width="481" height="276" alt="Consulta_Q1" src="https://github.com/user-attachments/assets/2cecb1d3-aa03-47a8-b725-25668d776274" /><p><em>Fig. 01: Consulta da questão 01.</em></p>
</div>
<br>

Nesta query, "MONTH()" foi utilizado para extrair o número do mês em cada data, "DATENAME(MONTH, order_date)" para retornar o nome do mês por extenso, "YEAR()" extra o ano da data e "SUM(after_discount)" para somar todos os valores da coluna "after_discount". Como há "GROUP BY", essa soma será feita por grupo e o "Valor_total_transacao" será o faturamento total daquele mês. A cláusula "WHERE" foi utilizada para aplicar os filtros antes do agrupamento. "GROUP BY" foi usado para definir como os dados serão agrupados e, cada combinação  de "Ano", "Mes_ID" e "Mes_nome" formará um grupo. Isso é obrigatório porque toda coluna no "SELECT" que não é função de agregação (SUM, COUNT, etc) precisa estar no "GROUP BY". Por fim, "ORDER BY" define a ordem do resultado final.

<br>
<div align="center">
       <img width="321" height="252" alt="Resultado_Q1" src="https://github.com/user-attachments/assets/da91f8dc-bbb6-4f52-8f90-33a4bac5eafe" /><p><em>Fig. 02: Resultado da questão 01.</em></p>
</div>
<br>

O resultado da consulta acima nos mostra que o pico no valor total da transação foi atingida no mês de agosto, sendo o maior valor para o ano de 2021.

<br>

## QUESTÃO 2
<br>
> Durante as transações realizadas no ano de 2022, qual categoria gerou o maior valor de transação? Utilize "is_valid = 1" para filtrar os dados de transação. Tabela de origem: "order_detail", "sku_detail"
<br>

**RESPOSTA 2**

Dado o enunciado do problema, primeiramente definimos as columas "Ano", "category" e "Valor_total_transacao" como resultado de nossa consulta. Para isso, somamos o valor total das transações que já foram pagas pelo clientes, no ano de 2022, e em seguida ordenamos os valores pelas categorias que mais venderam para aquelas que venderam menos.

A resolução proposta segue abaixo:

<br>
<div align="center">
       <img width="498" height="254" alt="Consulta_Q2" src="https://github.com/user-attachments/assets/3b93ab56-b7c6-4995-9cbc-459881fcc175" /><p><em>Fig. 03: Consulta da questão 02.</em></p>
</div>
<br>

O código realiza uma consulta que calcula o valor total das transações por categoria de produto no ano de 2022, considerando apenas pedidos que o cliente já realizou o pagamento. Para isso, ele relaciona a tabela de pedidos (order_detail) com a tabela de produtos (sku_detail) por meio do identificador do SKU e agrupa os dados pelo ano do pedido e pela categoria do produto. Em seguida, ordena a soma dos valores das transações
do maior para o menor valor total por categoria.

<br>
<div align="center">
       <img width="308" height="313" alt="Resultado_Q2" src="https://github.com/user-attachments/assets/144bc091-6dcc-47a7-9cf1-625328fdca85" /><p><em>Fig. 04: Resultado da questão 02.</em></p>
</div>
<br>

O resultado da consulta nos mostra que a categoria Mobiles & Tablets foi a que gerou maior receita no ano de 2022, apresentando o maior total de transações.

br>

## QUESTÃO 3
<br>

> Compare os valores de transação de cada categoria nos anos de 2021 e 2022. Mencione quais categorias apresentaram aumento e quais diminuiram os valores de transação de 2021 para 2022. Utilize "is_valid = 1" para filtrar os dados de transação. Tabelas de origem: "order_detail", "sku_detail".

**RESPOSTA 3**

Para resolver este exercício vamos calcular o total de transações para o ano de 2012 e 2022 com base na categoria. Depois, calcular a diferença entre o total de cada categoria em cada ano e verificar se houve aumento ou redução de vendas nesse período. A seguir temos a resolução do exercício proposto:

<br>
<div align="center">
       <img width="690" height="515" alt="Consulta_Q3" src="https://github.com/user-attachments/assets/d2632934-fcf0-4e92-9959-0b6892a9e56e" /><p><em>Fig. 05: Consulta da questão 03.</em></p>
</div>
<br>

Neste exercício, para realizar uma análise comparativa do valor de transações por categoria entre os anos de 2021 e 2022, precisamos fazer uso de uma tabela temporária (CTE) para organizar a nossa query, denominada "Tabela_final". Nessa tabela vamos usar o INNER JOIN para consolidar os dados da tabela "order_detail" e da tabela "sku_detail", associando cada pedido à sua respectiva categoria por meio do identificador do sku. Em seguida, aplica-se um filtro para considerar apenas registros em que o cliente já realizaou o pagamento (is_valid = 1), garantindo a qualidade dos dados antes da agregação. O cálculo do faturamento anual é feito por meio de agregações condicionais, utilizando a função SUM combinada com expressões CASE WHEN, que somarão os valores das transações (after_discount) separadamente para os anos de 2021 e 2022. Após o agrupamento por categoria, será calculada a diferença (Delta) entre os anos e classificado o comportamento de cada categoria de acordo com o aumento ou redução no valor das transações. Por fim, o resultado é ordenado pela categoria que teve maior aumento de receita em 2022 para aquelas que tiveram menores crescimento e/ou tiveram vendas menores que no ano de 2021.

<br>
<div align="center">
       <img width="501" height="311" alt="Resultado_Q3" src="https://github.com/user-attachments/assets/a88a17a6-1b27-45bf-864f-21d3184ff805" /><p><em>Fig. 06: Resultado da questão 03.</em></p>
</div>
<br>


Pelo retultado, podemos observar que devido á diversos fatores, como avanço tecnológico e/ou pandemia, o setor de Mobiles & Tablets teve maior crescimento e, Books e Others, tiveram maior redução de vendas comparado com o ano anterior.


br>

## QUESTÃO 4
<br>




