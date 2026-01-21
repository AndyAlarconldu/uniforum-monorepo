from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..schemas import LoginRequest, TokenResponse
from ..crud import authenticate_user
from ..core.security import create_access_token, create_refresh_token
from ..database import SessionLocal

router = APIRouter(prefix="/auth", tags=["auth"])

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/login", response_model=TokenResponse)
def login(data: LoginRequest, db: Session = Depends(get_db)):
    user = authenticate_user(db, data.email, data.password)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    access = create_access_token({
        "sub": str(user.id),
        "role": user.role
    })
    refresh = create_refresh_token({
        "sub": str(user.id)
    })

    return {
        "access_token": access,
        "refresh_token": refresh
    }
