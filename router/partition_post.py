from typing import Optional, List, Dict
from db.db_partition import create_partition
from fastapi import APIRouter, Query, Body, Path, Depends
from pydantic import BaseModel
from schemas import Partition
from db.database import get_db
from sqlalchemy.orm import Session



router = APIRouter(
    prefix='/partition',
    tags=['partition']
)


@router.post("/new", response_model = Partition)
def post_new_partition(request: Partition, db: Session = Depends(get_db)):
    return create_partition(db, request)