from fastapi import APIRouter, HTTPException
from app.schemas import LoginRequest, TokenResponse
from app.core.security import verify_password, create_access_token, create_refresh_token

router = APIRouter(prefix="", tags=["auth"])

@router.post("/login", response_model=TokenResponse)
def login(data: LoginRequest):
    # EJEMPLO SIMPLE (sin DB)
    if data.email != "andyx@mail.com" or data.password != "123456":
        raise HTTPException(status_code=401, detail="Credenciales inválidas")

    access_token = create_access_token({"sub": data.email})
    refresh_token = create_refresh_token({"sub": data.email})

    return {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer"
    }
