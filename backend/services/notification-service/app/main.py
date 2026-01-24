from fastapi import FastAPI
from pydantic import BaseModel
from app.redis_client import redis_client

app = FastAPI(title="Notification Service")
@app.get("/health")
def health():
    return {"status": "ok"}

class NotificationCreate(BaseModel):
    message: str

# 🔹 Health

# 🔹 Crear notificación
@app.post("/notifications")
def create_notification(notification: NotificationCreate):
    redis_client.rpush("notifications", notification.message)
    return {
        "status": "created",
        "message": notification.message
    }

# 🔹 Listar notificaciones
@app.get("/notifications")
def list_notifications():
    notifications = redis_client.lrange("notifications", 0, -1)
    return {
        "count": len(notifications),
        "notifications": notifications
    }
