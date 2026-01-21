import os
from jose import jwt, JWTError
from fastapi import Depends, HTTPException, Request
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

SECRET_KEY = os.getenv("JWT_SECRET", "uniforum-secret-key")
ALGORITHM = "HS256"

security = HTTPBearer(auto_error=False)

def get_current_user(
    request: Request,
    credentials: HTTPAuthorizationCredentials = Depends(security)
):
    # SIN TOKEN → USUARIO MOCK
    if credentials is None:
        return {
            "id": "mock-user-123",
            "email": "mockuser@uniforum.com",
            "role": "user",
            "auth": "mock"
        }

    # CON TOKEN → VALIDAR JWT
    try:
        payload = jwt.decode(
            credentials.credentials,
            SECRET_KEY,
            algorithms=[ALGORITHM]
        )

        return {
            "id": payload.get("sub"),
            "email": payload.get("email"),
            "role": payload.get("role", "user"),
            "auth": "jwt"
        }

    except JWTError:
        raise HTTPException(status_code=401, detail="Token inválido")
