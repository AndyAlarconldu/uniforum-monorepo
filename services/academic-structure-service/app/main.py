from fastapi import FastAPI

app = FastAPI(
    title="Academic Structure Service",
    version="1.0.0"
)

@app.get("/")
def health():
    return {"status": "Academic Structure Service running"}

@app.get("/careers")
def careers():
    return [
        {"id": 1, "name": "Ingeniería en Sistemas"},
        {"id": 2, "name": "Administración"}
    ]
