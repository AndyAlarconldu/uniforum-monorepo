from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from app.database import Base, engine, SessionLocal
from app.models import AuditLog
from app.schemas import AuditCreate, AuditResponse

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Moderation & Audit Service")
@app.get("/health")
def health():
    return {"status": "ok"}

# DB dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# 🔹 HEALTH
@app.get("/health")
def health():
    return {"status": "ok"}

# 🔹 CREAR LOG
@app.post("/audit", response_model=AuditResponse)
def create_audit(audit: AuditCreate, db: Session = Depends(get_db)):
    log = AuditLog(
        user_id=audit.user_id,
        action=audit.action
    )
    db.add(log)
    db.commit()
    db.refresh(log)
    return log

# 🔹 LISTAR LOGS
@app.get("/audit", response_model=list[AuditResponse])
def list_audits(db: Session = Depends(get_db)):
    return db.query(AuditLog).all()
