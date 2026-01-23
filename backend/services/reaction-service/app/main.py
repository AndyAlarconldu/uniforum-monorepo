from fastapi import FastAPI
from app.database import redis_client

app = FastAPI(title="Reaction Service")

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/reactions/{post_id}/like")
def like_post(post_id: int):
    key = f"post:{post_id}:likes"
    likes = redis_client.incr(key)
    return {"post_id": post_id, "likes": likes}

@app.get("/reactions/{post_id}")
def get_likes(post_id: int):
    key = f"post:{post_id}:likes"
    likes = redis_client.get(key)
    return {"post_id": post_id, "likes": int(likes) if likes else 0}
