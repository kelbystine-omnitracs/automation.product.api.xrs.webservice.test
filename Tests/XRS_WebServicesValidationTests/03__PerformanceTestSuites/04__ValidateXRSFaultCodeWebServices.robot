*** Settings ***
Documentation   Fundamental suite to test XRS Fault Code Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/FaultCode.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create REST API Session
                ...  AND  Test Data Setup For XRS Fault Code Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      xrsrestwebservicevalidation  xrsfaultcoderestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate XRS Get Fault Code With Forward Slash REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Fault Code Events with basic parameters
  ${w_slash_response} =  Get Fault Codes Response With Forward Slash  &{XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Fault Code Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get Fault Code Events with basic parameters
  ${wo_slash_response} =  Get Fault Codes Response Without Forward Slash  &{XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Fault Code With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Fault Code Events with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Fault Codes Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Fault Code With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get Fault Code Events with basic parameters using a raw URI string
  ${w_question_response} =  Get Fault Codes Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_question_response}

Validate XRS Get Fault Code REST Web Services For All Fault Codes Response Returns 200 OK
  [Documentation]  Gets all the Fault Code Events
  [Tags]  xrsperftest
  ${response} =  Get All Fault Codes
  Request Should Be Successful  ${response}

# Validate Get Fault Codes By Vehicle ID
Validate XRS Get Fault Codes By Vehicle ID With Forward Slash REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters
  ${w_slash_response} =  Get Fault Codes By Vehicle ID Response With Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  &{XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Fault Codes By Vehicle ID Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters
  ${wo_slash_response} =  Get Fault Codes By Vehicle ID Response Without Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  &{XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Fault Code By Vehicle ID With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  vehicle_id=${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  params_string=${XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Fault Codes By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With /? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Fault Code By Vehicle ID With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  vehicle_id=${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  params_string=${XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Fault Codes By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With ? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_question_response}

Validate XRS Get Fault Code By Vehicle ID REST Web Services For All Fault Codes Response Returns 200 OK
  [Documentation]  Gets all the Fault Code Events By Vehicle ID
  [Tags]  xrsperftest
  ${response} =  Get All Fault Codes By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}
  Request Should Be Successful  ${response}

*** Keywords ***
Test Data Setup For XRS Fault Code Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for Fault Code Web Service Tests.
  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST} =  Get The nth Active Vehicle ID  0
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
    # Create test params
  &{XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  Set Suite Variable  &{XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS}
  # Create test params string
  ${XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING} =  Set Variable
  ...  OrganizationID=${XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS.OrganizationID}
  Set Suite Variable  ${XRS_WEBSERVICE_FAULT_CODE_TEST_PARAMS_STRING}



