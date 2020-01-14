*** Settings ***
Documentation  Helper Keywords for parsing and verifiying various elements in REST responses.
Library  Collections
Library  RequestsLibrary

*** Variables ***

*** Keywords ***
Verify Response List ${response_list} Has Key ${key} And Contains Value ${value}
  [Documentation]  Expects a reponse list, converts list to json
  ...  searches throught he list for a value from the given key
  ...  will throw an error if the reponse is not a list
  ${json_response_list} =  To Json  ${response_list.content}
  FOR  ${r}  IN  @{json_response_list}
    ${get_value} =  Get From Dictionary  ${r}  ${key}
    Should Be Equal As Strings  ${get_value}  ${value}
  END

Get Value From Response With Key
    [Arguments]  ${key}  ${response}
    [Documentation]  Converts response to json
    ...  Returns the value from the given key.
    ${json_response} =  To Json  ${response.content}
    ${get_value} =  Get From Dictionary  ${json_response}  ${key}
    [Return]  ${get_value}
