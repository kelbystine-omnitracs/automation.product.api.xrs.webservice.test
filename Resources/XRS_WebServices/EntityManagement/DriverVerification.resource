*** Settings ***
Documentation  Custom Keyword Library for abstracting test verifications
Resource  ./Driver.resource
Resource  ../Toolbox/ParseResponse.resource

*** Keywords ***
Verify ${status_code} Is Returned From Get Driver By ID ${driver_id}
  ${response} =  Get Driver By ID  ${driver_id}
  Status Should Be  ${status_code}  ${response}

Verify Post Driver Method Returns Code 201 ${driver_list_body}
  ${response} =  Post Drivers  @{driver_list_body}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Verify Get Driver By ID ${driver_id} Is successful
  ${response} =  Get Driver By ID  ${driver_id}
  Request Should Be Successful  ${response}
  [Return]  ${response}

Verify Put Driver ${driver_list_body} Description Returns "Driver edited successfully."
  ${response} =  Put Drivers  @{driver_list_body}
  &{expected_values} =  Create Dictionary  key=Description  value=Driver edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Verify Get Drivers With Parameters ${parameter_dictionary} Method Is Successful With Forward Slash
  ${w_slash_response} =  Get Drivers Response With Forward Slash  &{parameter_dictionary}
  Request Should Be Successful  ${w_slash_response}

Verify Get Drivers With Parameters ${parameter_dictionary} Method Is Successful Without Forward Slash
  [Documentation]  Get drivers with basic parameters
  ${wo_slash_response} =  Get Drivers Response Without Forward Slash  &{parameter_dictionary}
  Request Should Be Successful  ${wo_slash_response}

Verify Get Drivers Raw String ${raw_uri_string} With ${char_string} Is Successful
  ${w_slash_question_response} =  Get Drivers Raw String URI Response With ${char_string} And Parameters ${raw_uri_string}
  Request Should Be Successful  ${w_slash_question_response}

Verify Delete Driver By ID ${driver_id} Is Successful
  ${response} =  Delete Driver By ID  ${driver_id}
  Request Should Be Successful  ${response}

Verify Get All Drivers Is Successful
  ${response} =  Get All Drivers
  Request Should Be Successful  ${response}

Verify Delete Drivers By IDs ${driver_id} Response ErrorMessage Returns "Driver <driver_sid> doesn't exist."
  ${response} =  Delete Drivers By IDs  ${driver_id}
  &{expected_value} =  Create Dictionary  key=ErrorMessage  value=Driver ${driver_id} doesn't exist.
  ${actual_error_message} =  Get Value From Response With Key  ${expected_value.key}  ${response}
  Should Be Equal As Strings  ${actual_error_message}  ${expected_value.value}