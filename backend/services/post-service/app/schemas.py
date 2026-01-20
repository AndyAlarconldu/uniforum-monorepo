from pydantic import BaseModel

class PostCreate(BaseModel):
    content: str

class PostResponse(PostCreate):
    id: str
    user_id: str
