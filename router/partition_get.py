from fastapi import APIRouter, Response, status, Depends
from enum import Enum
from typing import Optional
from db import db_partition
from schemas import Partition



router = APIRouter(
    prefix='/partition',
    tags=['partition']
)





@router.get('/all', response_model = List[Partition])
def get_all_partitions(db: Session = Depends(get_db)):
    return db_partition.get_all_partitions(db)