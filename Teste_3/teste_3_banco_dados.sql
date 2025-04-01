CREATE DATABASE TESTE_3;
USE TESTE_3;

/* CRIAÇÃO DAS TABELAS BASEANDO NOS ARQUIVOS .csv*/
CREATE TABLE operadoras (
    id_operadora INT AUTO_INCREMENT PRIMARY KEY,
    registro_ans VARCHAR(30) UNIQUE,
    cnpj CHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(30),
    complemento VARCHAR(255),
    bairro VARCHAR(150),
    cidade VARCHAR(150),
    uf CHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(5),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    email VARCHAR(255),
    representante VARCHAR(100),
    cargo_representante VARCHAR(100),
    regiao_comercializacao VARCHAR(255),
    data_registro DATE NOT NULL
);

CREATE TABLE demonstracoes_contabeis (
    id_demonstracoes SERIAL PRIMARY KEY,
    data DATE,
    registro_ans VARCHAR(30),
    cd_conta_contabil VARCHAR(20), 
    descricao VARCHAR(150), 
    vl_saldo_inicial DECIMAL(20,2), 
    vl_saldo_final DECIMAL(20,2),
    FOREIGN KEY (registro_ans) REFERENCES operadoras(registro_ans) -- Relacionamento direto com registro_ans
        ON DELETE CASCADE ON UPDATE CASCADE
);

/* Habilitar a importação de arquivos locais */
SET GLOBAL local_infile = 1;

/* Importação do arquivo de Operadoras Ativas */
LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\dados_cadastrais_operadoras_ativas.csv'
INTO TABLE operadoras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento, bairro, cidade, uf, cep, ddd, 
telefone, fax, email, representante, cargo_representante, regiao_comercializacao, data_registro);

/* Importação dos 8 arquivos das Demonstrações Contábeis dos dois últimos anos */
LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\1T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\2T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\3T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\4T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\1T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\2T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\3T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE 'C:\\Users\\Guilherme\\Documents\\Testes_IntuitiveCare\\Teste_3\\dados\\4T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`data`, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

SELECT COUNT(*) FROM operadoras;
SELECT COUNT(*) FROM demonstracoes_contabeis;

/* Consulta das top 10 operadoras com maiores despesas no último trimestre */
SELECT 
    o.nome_fantasia AS operadora,
    SUM(dc.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras o ON dc.registro_ans = o.registro_ans
WHERE 
    dc.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
    AND dc.data BETWEEN '2024-10-01' AND '2024-12-31' -- Último trimestre de 2024
GROUP BY 
    o.nome_fantasia
ORDER BY 
    total_despesas DESC
LIMIT 10;


/* Consulta das top 10 operadoras com maiores despesas no último ano */
SELECT 
    o.nome_fantasia AS operadora,
    SUM(dc.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras o ON dc.registro_ans = o.registro_ans
WHERE 
    dc.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
    AND YEAR(dc.data) = 2024 -- Último ano
GROUP BY 
    o.nome_fantasia
ORDER BY 
    total_despesas DESC
LIMIT 10;


