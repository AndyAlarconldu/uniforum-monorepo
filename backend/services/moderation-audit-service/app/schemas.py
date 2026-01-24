from pydantic import BaseModel
from datetime import datetime

class AuditCreate(BaseModel):
    user_id: int
    action: str

class AuditResponse(BaseModel):
    id: int
    user_id: int
    action: str
    created_at: datetime

    class Config:
        from_attributes = True
