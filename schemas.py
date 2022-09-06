from pydantic import BaseModel

class Partition(BaseModel):
    partition_id: int
    name: str