from fastapi import FastAPI
from app.routes.security import router as security_router
from .database import Base, engine
from .routes import auth

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Identity Service")

# 🔴 ENDPOINT OBLIGATORIO PARA AWS
@app.get("/health")
def health():
    return {"status": "ok"}

# Rutas normales
app.include_router(auth.router)