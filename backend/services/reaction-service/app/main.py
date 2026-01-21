from fastapi import FastAPI

app = FastAPI(title="Reply Service")

@app.get("/")
def health():
    return {"status": "Reply Service running"}

@app.post("/replies")
def reply():
    return {"message": "Reply created"}
