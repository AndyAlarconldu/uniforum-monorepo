from fastapi import FastAPI, Depends
from app.database import posts_collection
from app.schemas import PostCreate
from app.core.security import get_current_user

app = FastAPI(title="Post Service")

@app.post("/posts")
def create_post(
    post: PostCreate,
    user=Depends(get_current_user)
):
    data = {
        "content": post.content,
        "user_id": user.get("sub")
    }

    result = posts_collection.insert_one(data)
    data["_id"] = str(result.inserted_id)

    return data
