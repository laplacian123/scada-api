from db.hash import Hash
from sqlalchemy.orm.session import Session
from schemas import UserBase
from db.models import DbPartition


def create_partition(db: Session, request: UserBase):
    new_partition = DbPartition(name = request.name)
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


