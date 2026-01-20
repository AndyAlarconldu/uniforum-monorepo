from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session

from .database import Base, engine, SessionLocal
from .schemas import PostCreate, PostResponse
from .crud import create_post
from .core.security import get_current_user

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Forum Service")

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/posts", response_model=PostResponse)
def create_post_endpoint(
    post: PostCreate,
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    return create_post(db, post, author_id=int(user["sub"]))
