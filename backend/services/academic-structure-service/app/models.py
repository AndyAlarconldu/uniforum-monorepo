from sqlalchemy import Column, Integer, String, ForeignKey
from .database import Base

from sqlalchemy import Column, Integer, String
from .database import Base

class Career(Base):
    __tablename__ = "careers"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)

