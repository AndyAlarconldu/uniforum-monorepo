from fastapi import FastAPI, Depends
from datetime import datetime

from app.database import replies_collection
from app.schemas import ReplyCreate, ReplyResponse
from app.core.security import get_current_user

app = FastAPI(title="Reply Service")
@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/replies", response_model=ReplyResponse)
def create_reply(
    reply: ReplyCreate,
    user=Depends(get_current_user)
):
    reply_doc = {
        "content": reply.content,
        "post_id": reply.post_id,
        "user_id": user["id"],
        "created_at": datetime.utcnow()
    }

    result = replies_collection.insert_one(reply_doc)

    return {
        "id": str(result.inserted_id),
        **reply_doc
    }
