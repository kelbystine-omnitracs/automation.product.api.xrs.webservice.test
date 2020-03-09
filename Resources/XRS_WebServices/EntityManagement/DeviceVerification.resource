*** Settings ***
Documentation  Custom Keyword Library for abstracting test verifications
Resource  ./Device.resource
Resource  ../Toolbox/ParseResponse.resource

*** Keywords ***
Verify ${status_code} Is Returned From Get Device By Phone Number ${phone_number}
    ${response} =  Get Device By Phone Number  ${phone_number}
    Status Should Be  ${status_code}  ${response}

Verify Post Device Method Returns Code 201 ${device_list_body}
    ${response} =  Post Devices  @{device_list_body}
    &{expected_values} =  Create Dictionary  key=Code  value=201
    Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Verify Get Device By Phone Number ${phone_number} Is successful
    ${response} =  Get Device By Phone Number  ${phone_number}
    Request Should Be Successful  ${response}

Verify Put Device ${device_list_body} Description Returns "Device edited successfully."
    ${response} =  Put Devices  @{device_list_body}
    &{expected_values} =  Create Dictionary  key=Description  value=Device edited successfully.
    Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Verify Get Devices With Parameters ${parameter_dictionary} Method Is Successful With Forward Slash
    ${w_slash_response} =  Get Devices Response With Forward Slash  &{parameter_dictionary}
    Request Should Be Successful  ${w_slash_response}

Verify Get Devices With Parameters ${parameter_dictionary} Method Is Successful Without Forward Slash
    ${wo_slash_response} =  Get Devices Response Without Forward Slash  &{XRS_WEBSERVICE_DEVICE_TEST_PARAMS}
    Request Should Be Successful  ${wo_slash_response}

Verify Get Devices Raw String ${raw_uri_string} With ${char_string} Is Successful
    ${w_slash_question_response} =  Get Devices Raw String URI Response With ${char_string} And Parameters ${raw_uri_string}
    Request Should Be Successful  ${w_slash_question_response}

Verify Get All Devices is Successful
    ${response} =  Get All Devices
    Request Should Be Successful  ${response}

Verify Delete Device ${phone_number} Is Successful
    ${response} =  Delete Device By Phone Number  ${phone_number}
    Request Should Be Successful  ${response}