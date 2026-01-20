from sqlalchemy.orm import Session
from .models import Post
from .schemas import PostCreate

def create_post(db: Session, post: PostCreate, author_id: int):
    db_post = Post(
        title=post.title,
        content=post.content,
        author_id=author_id
    )
    db.add(db_post)
    db.commit()
    db.refresh(db_post)
    return db_post
