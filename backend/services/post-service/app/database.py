import os
from pymongo import MongoClient

MONGO_URL = os.getenv("MONGO_URL", "mongodb://mongo:27017")
MONGO_DB = os.getenv("MONGO_DB", "postdb")

client = MongoClient(MONGO_URL)
db = client[MONGO_DB]

# 👇 ESTA LÍNEA ES LA QUE FALTABA
posts_collection = db["posts"]
