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

<br>

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


<br>

## QUESTÃO 4
<br>

> Exiba os 5 métodos de pagamento mais populares usados ​​durante 2022 (com base no total de pedidos únicos). Use "is_valid = 1" para filtrar os dados da transação. Tabela de origem: "order_detail", "payment_detail".

**RESPOSTA 4**

Segue abaixo nossa consulta SQL para o exercício proposto:

<br>
<div align="center">
       <img width="585" height="256" alt="Consulta_Q4" src="https://github.com/user-attachments/assets/d680d978-5102-4bb8-b437-5bd43c4f5985" /><p><em>Fig. 07: Consulta da questão 04.</em></p>
</div>
<br>

Este código realiza uma análise agregada com o objetivo de identificar os cinco métodos de pagamento mais utilizados no ano de 2022, considerando apenas pedidos is_valid = 1. Inicialmente, a consulta seleciona o ano do pedido por meio da função YEAR(), o método de pagamento a partir da tabela payment_detail e conta o número único de pedidos. Em seguida, é executado um INNER JOIN entre a tabela "order_detail" e a tabela de detalhes de pagamentos, utilizando o identificador do pagamento como chave de relacionamento. O filtro aplicado na cláusula WHERE restringe os dados a registros com pagamnetos já realizados (is_valid = 1) e ao período de interesse (ano de 2022). A métrica principal é calculada utilizando a função de agregação COUNT(DISTINCT A.id), que contabiliza o número de pedidos únicos por método de pagamento. Posteriormente, os dados são agrupados pelo ano do pedido e pelo método de pagamento. Por fim, a cláusula ORDER BY organiza os resultados de forma decrescente pelo total de pedidos, enquanto o uso do TOP 5 limita a saída aos cinco métodos de pagamento com maior volume de pedidos no período analisado.

<br>
<div align="center">
       <img width="258" height="121" alt="Resultado_Q4" src="https://github.com/user-attachments/assets/94e710d6-905e-4759-9c0f-d44182217817" /><p><em>Fig. 08: Resultado da questão 04.</em></p>
</div>
<br>

Com o resultado do que foi proposto pelo exercício, observamos que os 5 tipos de pagamentos mais utilizados no ano de 2022 foram: cod, payaxis, customercredit, easypay e jazzwallet.

<br>

## QUESTÃO 5
<br>

> Ordene estes 5 produtos com base em seus valores de transação.
> 1. Samsung, 2. Apple, 3. Sony, 4. Huawei, 5. Lenovo
> Use is_valid = 1 para filtrar os dados da transação.

**RESPOSTA 5**

Nesta atividade, teremos um desafio a mais pois não temos a coluna contendo as marcas dos produtos. Para alcançar o nosso objetivo, vamos criar uma coluna que armazenará as marcas desses itens pretendidos e então calcular o valor de transações relativo a cada uma delas.

Segue abaixo nossa consulta SQL:

<br>
<div align="center">
       <img width="615" height="509" alt="Consulta_Q5" src="https://github.com/user-attachments/assets/a678a766-6dbf-494d-bf95-9bbb1a222cc3" /><p><em>Fig. 09: Consulta da questão 05.</em></p>
</div>
<br>

Este código utiliza CTE's para organizar uma análise agregada do valor total de transações por marca de produto. Inicialmente, a CTE denominada base realiza um INNER JOIN entre a tabela "order_detail" e a tabela "sku_detail", associando cada pedido ao respectivo produto por meio do identificador do SKU. Nessa etapa, é aplicada uma expressão condicional CASE WHEN, que classifica os produtos em marcas específicas com base em palavras-chave presentes no nome do SKU (sku_name), após a normalização do texto com a função LOWER(). Produtos que não se enquadram nas regras definidas são classificados como “Outros”. Ainda na CTE base, é aplicado um filtro para considerar apenas registros is_valid = 1, e o valor da transação após desconto (after_discount) é preservado para agregação posterior.

Em seguida, a CTE "Tabela_final" consome os dados previamente preparados na CTE "base" para realizar a etapa de agregação. Nessa fase, os registros classificados como “Outros” são excluídos, e os valores de transação são somados por marca utilizando a função de agregação SUM(), resultando no valor total por marca de produto. Por fim, a consulta principal seleciona os resultados agregados e ordena as marcas de forma decrescente com base no valor total das transações, permitindo identificar aquelas com maior relevância financeira no conjunto de dados analisado


<br>
<div align="center">
       <img width="225" height="120" alt="Resultado_Q5" src="https://github.com/user-attachments/assets/c82514a5-fdfc-41a4-88d9-6f54835c8c10" /><p><em>Fig. 10: Resultado da questão 05.</em></p>
</div>
<br>

Com base nos resultados, a marca Samsung apresenta maior valor em transaçoes, seguida pela marca Apple. Na seqência temos a Sony em terceiro lugar, Huawei em quarto e Lenovo em quinto.



## Conclusão


O SQL é uma ferramenta essencial em projetos de Data Science por permitir o acesso, a organização e a análise de grandes volumes de dados de forma eficiente e estruturada. Por meio de consultas declarativas, é possível filtrar, transformar, agregar e relacionar dados diretamente no banco, reduzindo custos computacionais e garantindo maior desempenho. Funcionalidades como joins, agregações, expressões condicionais e CTEs facilitam a preparação dos dados e a criação de métricas analíticas confiáveis, tornando o SQL uma base sólida para análises exploratórias, construção de indicadores e integração com ferramentas como Python, R e soluções de visualização de dados.


