SET postman_webservice_collection_file_path=WebServicesTestCollection.postman_collection.json
SET webservice_environment_file_path=Postman_Test_Development_Environment_Definitions\WebServicesAuto_Q2.postman_environment.json
SET report_path=Q2WebServicesTestCollection6.html
SET folder="USER Web Service Test Suite"

newman run %postman_webservice_collection_file_path% -e %webservice_environment_file_path% -r cli,htmlextra --folder %folder% --reporter-htmlextra-export %report_path%