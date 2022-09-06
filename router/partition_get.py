from fastapi import APIRouter, Response, status
from enum import Enum
from typing import Optional

router = APIRouter(
    prefix='/partition',
    tags=['partition']
)



@router.get(
    '/all',
    summary='Retrieve all partitions',
    description='This api call fetches all partitions',
    response_description="The list of available partitions"
    )
def get_all_partitions():
    # TODO: code to fetch all partitions
    return {'message': }
