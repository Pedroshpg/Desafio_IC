from fastapi import FastAPI
import csv
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5174"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def leitura_csv():
    with open("C:/Users/pedro.noleto/Documents/desafio_ic4/Backend/Relatorio_cadop.csv", newline='', encoding="utf-8-sig") as f:
        leitor = csv.DictReader(f, delimiter=';')
        return list(leitor)


dados_csv = leitura_csv()   

@app.get("/buscar")
def buscar(termo: str = ""):
    termo = termo.lower()
    resultados = []
    for linha in dados_csv:
        if any(termo in str(valor).lower() for valor in linha.values()):
            resultados.append(linha)
    return resultados
