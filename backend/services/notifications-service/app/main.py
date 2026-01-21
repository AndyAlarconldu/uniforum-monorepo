from fastapi import FastAPI

app = FastAPI(title="Notification Service")

@app.get("/")
def health():
    return {"status": "Notification Service running"}

@app.post("/notify")
def notify():
    return {"message": "Notification sent"}
