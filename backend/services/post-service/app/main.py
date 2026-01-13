from fastapi import FastAPI

app = FastAPI(title="Post Service")

@app.get("/")
def health():
    return {"status": "Post Service running"}

@app.post("/posts")
def create_post():
    return {"message": "Post created"}
