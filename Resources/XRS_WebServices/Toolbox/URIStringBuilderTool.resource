*** Settings ***
Documentation  Set of keywords that are used to create uri strings.
...  Version 1.1

*** Variables ***

*** Keywords ***
Create URI String With
  [Arguments]  ${base_uri}  ${request_type}  ${character_string}  ${params_string}
  [Documentation]  Helper Keyword to construct the request uri with different character strings
  ...  base_uri = webservice uri
  ...  request_type = request extension for the webservice
  ...  character_string = final character of the uri. i.e. /, /?, etc ...
  ...  params_string =  a string of parameters that is delimited by '&'
  ${uri_string} =  Set Variable  ${base_uri}${request_type}${character_string}${params_string}
  [Return]  ${uri_string}