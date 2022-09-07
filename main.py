from typing import Optional
from fastapi import FastAPI
from router import partition_get
from router import partition_post
from db.database import engine
from db import models


app = FastAPI()
app.include_router(partition_get.router)
app.include_router(partition_post.router)

@app.get('/hello')
def index():
    return {'message': 'Hello world!'}

models.Base.metadata.create_all(engine)