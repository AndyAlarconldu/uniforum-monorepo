from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session

from .database import Base, engine, SessionLocal
from .models import Career

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Academic Structure Service")

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/health")
def health():
    return {"status": "ok", "service": "academic-structure"}

@app.get("/careers")
def list_careers(db: Session = Depends(get_db)):
    return db.query(Career).all()
