import requests
from bs4 import BeautifulSoup
import zipfile


class DownloadArq:

    @staticmethod
    def downloadarq():
        url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
        headers = {"user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36"}
        session = requests.Session()
        resposta = session.get(url, headers=headers)
        soup = BeautifulSoup(resposta.text, "html.parser")
        nomes_arquivos = []
        for link in soup.find_all('a', href=True):
            href = link['href']
            if 'anexo' in href.lower() and href.endswith('.pdf'):
                nome = href.split("/")[-1]    
                try:
                    resposta_pdf = session.get(href)
                    with open(nome, "wb") as arquivo:
                        arquivo.write(resposta_pdf.content)
                        nomes_arquivos.append(nome)
                        print(f"Arquivo baixado: {nome}")
                except:
                    print(f"Erro ao baixar: {link}")
            
        try:
            with zipfile.ZipFile("anexos.zip", "w") as zipf:
                for arquivo in nomes_arquivos:
                    zipf.write(arquivo)
                    print(f"Adicionado ao zip: {arquivo}")
        except:
            print("--Erro ao criar o arquivo zip!--")
     
     
     
    
    

