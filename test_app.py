from app import app, page_not_found



#Check to see if the response received is a status code of 404
def pgNOTfound():
    response = app.test_client().get('page_not_found.html')
    assert response.status_code == 404
    
