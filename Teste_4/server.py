from flask import Flask, request, jsonify
import pandas as pd
from flask_cors import CORS
import csv

app = Flask(__name__)
CORS(app)  # Permite requisições do frontend

# Função para carregar os dados do CSV
def carregar_dados_csv(caminho_csv):
    dados = []
    with open(caminho_csv, mode='r', encoding='utf-8') as arquivo_csv:
        leitor = csv.DictReader(arquivo_csv)
        for linha in leitor:
            dados.append(linha)
    return dados

# Carregar os dados do CSV
dados_operadoras = carregar_dados_csv('dados_cadastrais_operadoras_ativas.csv')


@app.route('/buscar', methods=['GET'])
def buscar_operadoras():
    termo = request.args.get('termo', '').lower()
    resultados = [op for op in dados_operadoras if termo in op['nome_operadora'].lower()]
    return jsonify(resultados)

if __name__ == '__main__':
    app.run(debug=True)
