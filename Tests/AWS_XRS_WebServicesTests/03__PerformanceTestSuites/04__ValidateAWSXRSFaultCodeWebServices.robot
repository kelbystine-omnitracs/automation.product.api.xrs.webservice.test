*** Settings ***
Documentation   Fundamental suite to test XRS AWS Fault Code Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/FaultCode.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Fault Code Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsfaultcoderestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Fault Code REST Web Services Returns 200 OK
  [Documentation]  Get Fault Code Events with basic parameters
  ${wo_slash_response} =  Get Fault Codes Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  ${w_slash_response} =  Get Fault Codes Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Fault Code REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Fault Code Events with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Fault Codes Raw String URI Response Code With /? And Parameters ${XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Fault Codes Raw String URI Response Code With ? And Parameters ${XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Fault Code REST Web Services For All Fault Codes Returns 200 OK
  [Documentation]  Gets all the Fault Code Events
  [Tags]  xrsawsperftest
  ${response} =  Get All Fault Codes
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Fault Codes By Vehicle ID
Validate AWS XRS Get Fault Codes By Vehicle ID REST Web Services Returns 200 OK
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters
  ${wo_slash_response} =  Get Fault Codes By Vehicle ID Response Code With Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  &{XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  ${w_slash_response} =  Get Fault Codes By Vehicle ID Response Code Without Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  &{XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Fault Code By Vehicle ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  vehicle_id=${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  params_string=${XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Fault Codes By Vehicle ID ${test_data.vehicle_id} Raw String URI Response Code With /? And Parameters ${test_data.params_string}
  ${w_question_response} =  Get Fault Codes By Vehicle ID ${test_data.vehicle_id} Raw String URI Response Code With ? And Parameters ${test_data.params_string}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Fault Code By Vehicle ID REST Web Services For All Fault Codes Returns 200 OK
  [Documentation]  Gets all the Fault Code Events By Vehicle ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Fault Codes By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Test Data Setup For XRS AWS Fault Code Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Fault Code Web Service Tests.
  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST} =  Get The nth Active Vehicle ID  0
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
    # Create test params
  &{XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING} =  Set Variable
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS.OrganizationID}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}



