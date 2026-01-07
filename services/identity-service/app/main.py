from fastapi import FastAPI

app = FastAPI(
    title="Identity Service",
    version="1.0.0"
)

@app.get("/")
def health():
    return {"status": "Identity Service running"}

@app.post("/login")
def login():
    return {"message": "Login endpoint"}

@app.post("/register")
def register():
    return {"message": "Register endpoint"}
