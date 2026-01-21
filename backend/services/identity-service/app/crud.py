from sqlalchemy.orm import Session
from .models import IdentityUser
from .core.security import verify_password

def authenticate_user(db: Session, email: str, password: str):
    user = db.query(IdentityUser).filter(IdentityUser.email == email).first()
    if not user:
        return None
    if not verify_password(password, user.password):
        return None
    return user
