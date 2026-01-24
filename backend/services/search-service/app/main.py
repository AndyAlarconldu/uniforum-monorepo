from fastapi import FastAPI, Query
from app.redis_client import redis_client

app = FastAPI(title="Search Service")

# 🔹 Health check
@app.get("/health")
def health():
    return {"status": "ok"}

# 🔹 Search endpoint
@app.get("/search")
def search(q: str = Query(..., min_length=1)):
    """
    Búsqueda simple simulada usando Redis
    """
    key = f"search:{q}"

    # Si existe en cache
    cached = redis_client.get(key)
    if cached:
        return {
            "query": q,
            "source": "cache",
            "result": cached
        }

    # Simulación de búsqueda
    result = f"Resultados simulados para '{q}'"

    # Guardar en Redis
    redis_client.set(key, result)

    return {
        "query": q,
        "source": "new",
        "result": result
    }
