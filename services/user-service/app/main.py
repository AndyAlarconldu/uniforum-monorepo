from fastapi import FastAPI

app = FastAPI(
    title="User Service",
    version="1.0.0"
)

@app.get("/")
def health():
    return {"status": "User Service running"}

@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {
        "id": user_id,
        "name": "Demo User"
    }
