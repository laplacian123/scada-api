from .database import Base
from sqlalchemy import Column, Integer, String


class DbPartition(Base):
    __tablename__ = 'PARTITION'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    
