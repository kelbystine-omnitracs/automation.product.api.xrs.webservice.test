*** Settings ***
Library  ../Libraries/ParseNewmanTest.py

*** Variables ***
# ${FILE_PATH} =  WebServicesTestsCollection[Initialconditionsareindescription]-2020-03-17-16-49-03-025-0.html
# ${FILE_PATH} =  WebServicesTestsCollection[Initialconditionsareindescription]-2020-03-17-15-23-58-045-0.html
${FILE_PATH} =  Q2WebServicesTestCollection.html

*** Tasks ***
Create Newman Results CSV File
    @{text} =  get test results  ${CURDIR}/${FILE_PATH}
    create csv file  ${text}  Q2TestResults.csv