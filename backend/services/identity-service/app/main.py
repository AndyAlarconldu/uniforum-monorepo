from fastapi import FastAPI
from app.routes.security import router as security_router
from .database import Base, engine
from .routes import auth

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Identity Service")

app.include_router(auth.router)
