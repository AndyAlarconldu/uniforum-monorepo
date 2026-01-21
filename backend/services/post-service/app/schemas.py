from pydantic import BaseModel
from datetime import datetime

class PostCreate(BaseModel):
    title: str
    content: str

class PostResponse(PostCreate):
    id: str
    user_id: str
    created_at: datetime
