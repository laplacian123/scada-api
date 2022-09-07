from .database import Base
from sqlalchemy import Column, Integer, String, Identity
from sqlalchemy.schema import ForeignKey


class DbPartition(Base):
    __tablename__ = "PARTITION"
    partition_id = Column(Integer, Identity(start=1, cycle=True), primary_key=True, index=True, autoincrement=True)
    name = Column(String, nullable = False)
    
class DbPoint(Base):
    __tablename__ = "POINTS"
    point_id = Column(Integer, Identity(start=1, cycle=True), primary_key=True, index=True, autoincrement=True)
    name = Column(String, nullable = False)
    partition_id = Column(Integer, ForeignKey("DbPartition.id"), nullable = False)
    type = Column(String, nullable = False)

class DbDiList(Base):
    __tablename__ = "DI_LIST"
    di_id = Column(Integer,  Identity(start=1, cycle=True), primary_key=True, index=True, autoincrement=True)
    name = Column(String, nullable = False)
    point_id = Column(Integer, ForeignKey("DbPoint.id"), nullable = False)
    point_num = Column(Integer, nullable = False)