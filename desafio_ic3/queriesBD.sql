-- Queries utilizadas para preparação/importação:

LOAD DATA INFILE 'C:/Users/pedro.noleto/Downloads/Relatorio_cadop.csv'
INTO TABLE operadoras_ans
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/pedro.noleto/Downloads/1T2025.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/pedro.noleto/Downloads/1T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/pedro.noleto/Downloads/2T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/pedro.noleto/Downloads/3T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/pedro.noleto/Downloads/4T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

-- 	Quais as 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?

USE teste_bd;

SELECT 
    oa.Razao_Social,
    dc.descricao,
    CONCAT('R$ ', FORMAT(SUM(dc.VL_SALDO_FINAL - dc.VL_SALDO_INICIAL), 2, 'pt_BR')) AS total_despesa
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras_ans oa ON dc.Reg_ANS = oa.Registro_ANS
WHERE 
    dc.DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
    AND dc.DATA_RELATORIO = '2025-01-01'
GROUP BY 
    oa.Registro_ANS, oa.Razao_Social, dc.descricao
ORDER BY 
    SUM(dc.VL_SALDO_FINAL - dc.VL_SALDO_INICIAL) DESC
LIMIT 10;


-- Quais as 10 operadoras com maiores despesas nessa categoria no último ano?

USE teste_bd;

SELECT 
    oa.Razao_Social,
    dc.descricao,
    CONCAT('R$ ', FORMAT(SUM(dc.VL_SALDO_FINAL - dc.VL_SALDO_INICIAL), 2, 'pt_BR')) AS total_despesa
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras_ans oa ON dc.Reg_ANS = oa.Registro_ANS
WHERE 
    dc.DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
    AND dc.DATA_RELATORIO BETWEEN '2024-10-01' AND '2025-01-01'
GROUP BY 
    oa.Registro_ANS, oa.Razao_Social, dc.descricao
ORDER BY 
    SUM(dc.VL_SALDO_FINAL - dc.VL_SALDO_INICIAL) DESC
LIMIT 10;

