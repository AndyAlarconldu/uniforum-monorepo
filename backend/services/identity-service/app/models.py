from sqlalchemy import Column, Integer, String
from .database import Base

class IdentityUser(Base):
    __tablename__ = "identity_users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)
    role = Column(String, default="user")
