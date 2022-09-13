from db.db_partition import create_partition
from fastapi import APIRouter, Depends
from schemas import PartitionPost
from db.database import get_db
from sqlalchemy.orm import Session



router = APIRouter(
    prefix='/partition',
    tags=['partition']
)


@router.post("/new")
def post_new_partition(request: PartitionPost, db: Session = Depends(get_db)):
    return {"data": create_partition(db, request)}