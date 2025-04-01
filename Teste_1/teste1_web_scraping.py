import requests
from bs4 import BeautifulSoup 
from urllib.parse import urljoin
import zipfile 
import os

# target URL
url = 'https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos'

# faz requisição para a pg
pagina_web = requests.get(url)
dados_pagina_web = BeautifulSoup(pagina_web.text, 'html.parser') # html em texto

# Procura por links e .pdf e Anexo i e ii
anexo_i = None
anexo_ii = None

for links_anexos in dados_pagina_web.find_all('a', href=True):
    if links_anexos['href'].endswith('.pdf'):
        if 'Anexo I.' in links_anexos.text:
            anexo_i = urljoin(url, links_anexos['href'])  # urljoin garante que o link seja absoluto
            print(f"\nLink anexo I encontrado: {anexo_i}")
        elif 'Anexo II.' in links_anexos.text:
            anexo_ii = urljoin(url, links_anexos['href'])  # urljoin garante que o link seja absoluto
            print(f"\nLink anexo II encontrado: {anexo_ii}")

# Função para baixar arquivos
def baixar_arquivo(url, nome_arquivo):
    try:
        resposta = requests.get(url, stream=True)
        resposta.raise_for_status()  # Verifica se o download foi bem-sucedido
        with open(nome_arquivo, 'wb') as file:
            for chunk in resposta.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"\n{nome_arquivo} salvo com sucesso.")
    except requests.exceptions.RequestException as e:
        print(f"\nErro ao baixar {nome_arquivo}: {e}")

 # cria arquivo .zip no modo escrita e compacta os anexos
with zipfile.ZipFile('Anexos.zip', 'w') as zipf:
     if anexo_i:
          baixar_arquivo(anexo_i, 'Anexo_I.pdf') # chama função para baixar anexo
          zipf.write('Anexo_I.pdf') # adiciona arquivo ao .zip
          os.remove('Anexo_I.pdf') # deleta anexo original
     else:
          print("\nAnexo I não encontrado para download!")     
     
     if anexo_ii:
          baixar_arquivo(anexo_ii, 'Anexo_II.pdf') # chama função para baixar anexo
          zipf.write('Anexo_II.pdf') # adiciona arquivo ao .zip
          os.remove('Anexo_II.pdf') # deleta anexo original
     else:
          print("\nAnexo II não encontrado para download!")
