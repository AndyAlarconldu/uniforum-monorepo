from fastapi import FastAPI

app = FastAPI(
    title="Academic Structure Service",
    version="1.0.0"
)

@app.get("/")
def health():
    return {"status": "Academic Structure Service running"}

@app.get("/careers")
def list_careers():
    return [
        {"id": 1, "name": "Ingeniería en Sistemas"},
        {"id": 2, "name": "Administración de Empresas"}
    ]

@app.get("/subjects")
def list_subjects():
    return [
        {"id": 101, "name": "Programación Distribuida"},
        {"id": 102, "name": "Bases de Datos"}
    ]
