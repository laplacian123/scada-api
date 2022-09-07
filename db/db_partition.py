from sqlalchemy.orm.session import Session
from schemas import *
from db.models import *

def create_partition(db: Session, request: Partition):
    new_partition = DbPartition(partition_id = 0, name = request.name)
    db.add(new_partition)
    db.commit()
    db.refresh(new_partition)
    return new_partition

def get_all_partitions(db: Session):
    return db.query(DbPartition).all()

def get_partition_by_name(db: Session, name: str):
    return db.query(DbPartition).filter(DbPartition.name == name).first()

def get_partition_by_name(db: Session, partition_id: str):
    return db.query(DbPartition).filter(DbPartition.partition_id == partition_id).first()

def get_di_by_partition(db: Session, partition_id: int):
    points = db.query(DbPoint.point_id).filter(DbPoint.partition_id == partition_id).all()
    return db.query(DbDiList).filter(DbDiList.point_id in points).all()