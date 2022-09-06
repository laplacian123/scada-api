@router.get('/{id}', status_code=status.HTTP_200_OK)
def get_blog(id: int, response: Response):
    if id > 5:
      response.status_code = status.HTTP_404_NOT_FOUND
      return {'error': f'Blog {id} not found'}
    else : 
      response.status_code = status.HTTP_200_OK
      return {'message': f'Blog with id {id}'}