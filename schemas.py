from pydantic import BaseModel, Field
from typing import Optional


class PartitionPost(BaseModel):
    name: str

class PartitionGet(BaseModel):
    partition_id: Optional[int] = Field(default = None, primary_key=True)
    name: str

class Point(BaseModel):
    point_id: Optional[int] = Field(default = None, primary_key=True)
    name: str
    partition_id: int
    type: str

class Element(BaseModel):
    elem_id: Optional[int] = Field(default = None, primary_key=True)
    name: str
    point_id: int

class AiList(BaseModel):
    ai_id: Optional[int] = Field(default = None, primary_key=True)
    name: str
    point_id: int
    data_type: str
    scailing: float
    precision: int
    min: float
    max: float

class DiList(BaseModel):
    di_id: Optional[int] = Field(default = None, primary_key=True)
    name: str
    point_id: int
    point_num: int
