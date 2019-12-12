*** Settings ***
Documentation  Set of keywords that are used to create uri strings.

*** Variables ***

*** Keywords ***
Create URI String With
  [Arguments]  ${base_uri}  ${request_type}  ${character_string}
  [Documentation]  Helper Keyword to construct the request uri with different character strings
  ...  base_uri = webservice uri
  ...  request_type = request extentenstion for the webservice
  ...  character_string = final character of the uri. i.e. /, /?, etc ...
  ${uri} =  Set Variable  ${base_uri}${request_type}${character_string}
  [Return]  ${uri}