import pandas as pd
import pdfplumber
import zipfile

class Transforma_pdf:
    @staticmethod
    def transforma_pdf():

        arquivo = "Anexo_I_Rol_2021RN_465.2021_RN627L3.2024.pdf"
        tabelas = []
        nome = arquivo.split(".pdf")[0]
        with pdfplumber.open(arquivo) as pdf:
            for i, pagina in enumerate(pdf.pages):
                tabelas_pdf = pagina.extract_tables()

                for tabela in tabelas_pdf:
                    if tabela: 
                        try:
                            df = pd.DataFrame(tabela[1:], columns=tabela[0])
                            tabelas.append(df)
                            print(f" Página que está sendo processada: {i+1}")
                        except Exception as e:
                            print(f" Erro ao processar a página: {i+1}: {e}")

        df_final = pd.concat(tabelas, ignore_index=True)

        df_final = df_final.rename(columns={ 'OD': 'Seg. Odontológica',
                                            'AMB': 'Seg. Ambulatorial'})
        
        df_final.to_csv(f"{nome}.csv", sep=';', index=False, encoding='utf-8')

        with zipfile.ZipFile("Teste_Pedro_Noleto.zip", "w") as zipf:
                    zipf.write(f"{nome}.csv")
                    print(f"Adicionado ao zip: {arquivo}")
    
        






