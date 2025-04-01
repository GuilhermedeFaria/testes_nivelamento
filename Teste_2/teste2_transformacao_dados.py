import pdfplumber
import pandas as pd
import zipfile
import os

# Caminho relativo ao diretório do script para garantir que o anexo seja encontrado
base_dir = os.path.dirname(os.path.abspath(__file__))  # Diretório do script
pdf_path = os.path.join(base_dir, "Anexo_I.pdf")
csv_filename = os.path.join(base_dir, "Rol_de_Procedimentos_e_Eventos_em_Saude.csv")
zip_filename = os.path.join(base_dir, "Teste_Guilherme.zip")

# Verificar se o arquivo PDF existe
if not os.path.exists(pdf_path):
    print(f"Erro: O arquivo '{pdf_path}' não foi encontrado no diretório do script.")
    print("Diretório do script:", base_dir)
    exit(1)

# Dicionário para substituir abreviações
substituicoes = {
    "OD": "Seg. Odontológica",
    "AMB": "Seg. Ambulatorial"
}

# Abrir o PDF e extrair tabelas das páginas 3 a 181
dataframes = []
with pdfplumber.open(pdf_path) as pdf:
    for page_number in range(2, 181):  # Índice começa em 0, então página 3 é índice 2
        page = pdf.pages[page_number]
        table = page.extract_table()
        if table:
            # Converter a tabela em um DataFrame e adicionar à lista
            df = pd.DataFrame(table[1:], columns=table[0])  # Usar a primeira linha como cabeçalho
            dataframes.append(df)

# Concatenar todos os DataFrames em um único
if dataframes:
    final_df = pd.concat(dataframes, ignore_index=True)

    # Substituir abreviações nas colunas OD e AMB
    for col, desc in substituicoes.items():
        if col in final_df.columns:
            final_df[col] = final_df[col].replace(substituicoes)

    # Salvar o DataFrame consolidado em um arquivo CSV
    final_df.to_csv(csv_filename, index=False, encoding="utf-8")

    # Compactar o arquivo CSV em um ZIP
    with zipfile.ZipFile(zip_filename, "w", zipfile.ZIP_DEFLATED) as zipf:
        zipf.write(csv_filename, os.path.basename(csv_filename))

    # Remover o arquivo CSV após compactação
    os.remove(csv_filename)

    print(f"\nArquivo {zip_filename} criado com sucesso!\n")
else:
    print("Nenhuma tabela encontrada no PDF.")