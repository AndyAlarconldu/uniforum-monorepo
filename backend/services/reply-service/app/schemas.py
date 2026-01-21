from pydantic import BaseModel
from datetime import datetime

class ReplyCreate(BaseModel):
    content: str
    post_id: str

class ReplyResponse(ReplyCreate):
    id: str
    user_id: str
    created_at: datetime
