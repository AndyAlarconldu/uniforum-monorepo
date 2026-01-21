from fastapi import FastAPI, Depends
from datetime import datetime

from app.database import posts_collection
from app.schemas import PostCreate, PostResponse
from app.core.security import get_current_user

app = FastAPI(title="Post Service")


@app.post("/posts", response_model=PostResponse)
def create_post(
    post: PostCreate,
    user=Depends(get_current_user)
):
    post_doc = {
        "title": post.title,
        "content": post.content,
        "user_id": user["id"],
        "created_at": datetime.utcnow()
    }

    result = posts_collection.insert_one(post_doc)

    return {
        "id": str(result.inserted_id),
        **post_doc
    }
