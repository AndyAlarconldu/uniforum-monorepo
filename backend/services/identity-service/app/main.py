import os
import psycopg2
from fastapi import FastAPI
from datetime import datetime

app = FastAPI(title="Identity Service")

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_NAME = os.getenv("DB_NAME", "uniforum")
DB_USER = os.getenv("DB_USER", "uniforum")
DB_PASSWORD = os.getenv("DB_PASSWORD", "uniforum")

def get_conn():
    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )

@app.get("/")
def health():
    return {"status": "Identity Service running"}

@app.post("/register")
def register_user():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            email TEXT,
            created_at TIMESTAMP
        )
    """)
    cur.execute(
        "INSERT INTO users (email, created_at) VALUES (%s, %s) RETURNING id",
        ("demo@uniforum.edu", datetime.utcnow())
    )
    user_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()

    return {
        "id": user_id,
        "email": "demo@uniforum.edu",
        "created_at": datetime.utcnow()
    }
