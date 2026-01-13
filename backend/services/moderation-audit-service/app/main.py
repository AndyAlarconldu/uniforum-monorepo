from fastapi import FastAPI

app = FastAPI(title="Forum Service")

@app.get("/")
def health():
    return {"status": "Forum Service running"}

@app.get("/forums")
def forums():
    return ["General", "Programación"]