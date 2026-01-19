from fastapi import FastAPI
from .routes import auth
from .database import Base, engine

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Identity Service")

app.include_router(auth.router)
