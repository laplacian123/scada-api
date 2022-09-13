from fastapi import APIRouter, Response, status, Depends
from enum import Enum
from typing import Optional
from db import db_partition
from schemas import *
from typing import List
from db.database import get_db
from sqlalchemy.orm import Session


router = APIRouter(
    prefix='/partition',
    tags=['partition']
)





@router.get("/all")
def get_all_partitions(db: Session = Depends(get_db)):
    return {"data": db_partition.get_all_partitions(db)}


@router.get("/first")
def get_first_partition(db: Session = Depends(get_db)):
    return {"data": db_partition.get_di_by_partition(db, 1)}


