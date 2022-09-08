from .database import Base
from sqlalchemy import Column, Integer, String, Identity
from sqlalchemy.schema import ForeignKey


class DbPartition(Base):
    __tablename__ = "PARTITION"
    partition_id = Column("partition_id", Integer, Identity(start=1, increment = 1, cycle=True), primary_key=True, index=True)
    name = Column("name", String, nullable = False)
    
class DbPoint(Base):
    __tablename__ = "POINT"
    point_id = Column("point_id", Integer, Identity(start=1, increment = 1, cycle=True), primary_key=True, index=True)
    name = Column("name", String, nullable = False)
    partition_id = Column("partition_id", Integer, ForeignKey("PARTITION.partition_id"), nullable = False)
    type = Column("type", String, nullable = False)

class DbDiList(Base):
    __tablename__ = "DI_LIST"
    di_id = Column(Integer,  Identity(start=1, increment = 1, cycle=True), primary_key=True, index=True)
    name = Column(String, nullable = False)
    point_id = Column(Integer, ForeignKey("POINT.point_id"), nullable = False)
    point_num = Column(Integer, nullable = False)