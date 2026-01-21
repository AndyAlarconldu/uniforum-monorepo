from fastapi import FastAPI

app = FastAPI(title="Search Service")

@app.get("/")
def health():
    return {"status": "Search Service running"}

@app.get("/search")
def search(q: str):
    return {"query": q}
