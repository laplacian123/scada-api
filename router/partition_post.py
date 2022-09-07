from typing import Optional, List, Dict
from fastapi import APIRouter, Query, Body, Path
from pydantic import BaseModel
from schemas import Partition



router = APIRouter(
    prefix='/partition',
    tags=['partition']
)

