USE Projeto_SQL
GO



/*
Segue o script com as correções de textos e tipo de variáveis necessários para trabalhar de forma adequada com as 
base de dados, e que ocorreram ao carregar tais dados usando o ambiente integrado SSMS (da Microsoft).

*/

-- Consultar tabelas
select * from customer_detail
select * from order_detail
select * from payment_detail
select * from sku_detail





-- Número linhas
select count(*) as total_linhas
from customer_detail;

select count(*) as total_linhas
from order_detail;

select count(*) as total_linhas
from payment_detail;

select count(*) as total_linhas
from sku_detail;




-- Ao carregar os dados ficaram com aspas duplas na maioria  nos nomes das colunas da tabela "sku_detail". 
-- Corrigir erro de forma definitiva

EXEC sp_rename 'sku_detail.["id"]', 'id', 'COLUMN';
EXEC sp_rename 'sku_detail.["sku_name"]', 'sku_name', 'COLUMN';
EXEC sp_rename 'sku_detail.["base_price"]', 'base_price', 'COLUMN';
EXEC sp_rename 'sku_detail.["cogs"]', 'cogs', 'COLUMN';
EXEC sp_rename 'sku_detail.["category"]', 'category', 'COLUMN';





-- Verificar o nome de cada coluna da tabela SKU_DETAIL após a correção:
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sku_detail';





-- Verificar o tipo de cada coluna
SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_detail';


SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'order_detail';


SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'payment_detail';


SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sku_detail';





-- Alterar o tipo de variável da tabela CUSTOMER_DETAIL

-- A coluna ID ja está com a tipagem correta, vamos alterar somente a coluna "registered_date"  convertendo-a  de varchar para date.

-- Verificar os valores inválidos da coluna "registered_date". Essa verificação irá retornar linhas que precisam ser corrigidas (isto é, 
-- que nao estão no tipo DATE)

SELECT registered_date
FROM customer_detail
WHERE TRY_CONVERT(DATE, registered_date, 103) IS NULL
  AND registered_date IS NOT NULL;

-- Converter dados para o tipo DATE
ALTER TABLE customer_detail
ALTER COLUMN registered_date DATE;





-- Alterar o tipo de variável da tabela ORDER_DETAIL

-- Nesta tabela temos um maior número de converções para fazer, pois temos todas as 13 variáveis do tipo varchar().
-- Contudo, algumas colunas permanecerão com o mesmo tipo, sendo elas: id, customer_id, sku_id.
-- AS transformações serão executadas sobre as seguintes variáveis: "order_date" para DATE; "price", "befor_discount", 
-- "discount_amount" e "after_discount" para DECIMAL; e "qty_ordered", "is_gross", "is_valid", "is_net" e "payment_id" 
-- para INTEIRO.

-- Converter "order_date" para o tipo DATE
ALTER TABLE order_detail
ALTER COLUMN order_date DATE;

-- Converter "price", "before_discount", "discount_amount" e "after_discount" para o tipo DECIMAL
ALTER TABLE order_detail
ALTER COLUMN price DECIMAL(10,2);

ALTER TABLE order_detail
ALTER COLUMN before_discount DECIMAL(20,2);

ALTER TABLE order_detail
ALTER COLUMN discount_amount DECIMAL(20,2);

ALTER TABLE order_detail
ALTER COLUMN after_discount DECIMAL(20,2);

-- Converter "qty_ordered", "is_gross", "is_valid", "is_net" e "payment_id" para INTEIRO.
ALTER TABLE order_detail
ALTER COLUMN qty_ordered INT;

ALTER TABLE order_detail
ALTER COLUMN is_gross INT;

ALTER TABLE order_detail
ALTER COLUMN is_valid INT;

ALTER TABLE order_detail
ALTER COLUMN is_net INT;

ALTER TABLE order_detail
ALTER COLUMN payment_id INT;





-- Alterar o tipo de variável para a tabela PAYMENT_DETAIL

-- Nesta tabela temos apenas as colunas "id" e "payment_method", não faremos alterações nela.






-- Alterar o tipo de variável para a tabela SKU_DETAIL

-- Nesta tabela iremos manter as colunas "id", "sku_name" e "category" como varchar e alterar somente as colunas "base_price" e "cogs" para decimal.

-- Converter "base_price" e "cogs" para DECIMAL.
ALTER TABLE sku_detail
ALTER COLUMN base_price DECIMAL(20,2);

ALTER TABLE sku_detail
ALTER COLUMN cogs DECIMAL(20,2);





-- Verificar novamente o tipo de cada coluna após as transformações
SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_detail';


SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'order_detail';


SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'payment_detail';


SELECT 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sku_detail';


