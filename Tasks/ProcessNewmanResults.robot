*** Settings ***
Library  ../Libraries/ParseNewmanTest.py

*** Variables ***
# ${FILE_PATH} =  WebServicesTestsCollection[Initialconditionsareindescription]-2020-03-17-16-49-03-025-0.html
# ${FILE_PATH} =  WebServicesTestsCollection[Initialconditionsareindescription]-2020-03-17-15-23-58-045-0.html
${FILE_PATH} =  C:\\Users\\kstine\\github\\automation.product.api.xrs.webservice.test\\WebServices_Postman\\newman\\Q2WebServicesTestCollection5.html

*** Tasks ***
Create Newman Results CSV File
    @{text} =  get test results  ${FILE_PATH}
    create csv file  ${text}  Q2TestResults5.csv