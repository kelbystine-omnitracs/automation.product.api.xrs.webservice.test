*** Settings ***
Documentation   Fundamental suite to test XRS Black Box Summary Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/BlackBox.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Driver.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create REST API Session
                ...  AND  Test Data Setup For XRS Black Box Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      xrsrestwebservicevalidation  xrsblackboxrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate XRS Get Black Box Summary With Forward Slash REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Black Box Events with basic parameters
  ${wo_slash_response} =  Get Black Box Summary Response With Forward Slash  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Black Box Summary Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events with basic parameters
  ${w_slash_response} =  Get Black Box Summary Response Without Forward Slash  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Black Box Summary With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Black Box Events with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Black Box Summary Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Black Box Summary With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events with basic parameters using a raw URI string
  ${w_question_response} =  Get Black Box Summary Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_question_response}

Validate XRS Get Black Box Summary REST Web Services For All Black Box Summaries Response Returns 200 OK
  [Documentation]  Gets all the Black Box Events
  [Tags]  xrsperftest
  ${response} =  Get All Black Box Summaries
  Request Should Be Successful  ${response}

# Validate Get Black Box Summaries By Driver ID
Validate XRS Get Black Box Summaries By Driver ID With Forward Slash REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Black Box Events By Driver ID with basic parameters
  ${w_slash_response} =  Get Black Box Summary By Driver ID Response With Forward Slash  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Black Box Summaries By Driver ID Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events By Driver ID with basic parameters
  ${wo_slash_response} =  Get Black Box Summary By Driver ID Response Without Forward Slash  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Black Box Summary By Driver ID With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Black Box Events By Driver ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  driver_id=${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  params_string=${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Black Box Summary By Driver ID ${test_data.driver_id} Raw String URI Response With /? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Black Box Summary By Driver ID With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events By Driver ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  driver_id=${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  params_string=${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Black Box Summary By Driver ID ${test_data.driver_id} Raw String URI Response With ? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_question_response}

Validate XRS Get Black Box Summary By Driver ID REST Web Services For All Black Box Summaries Response Returns 200 OK
  [Documentation]  Gets all the Black Box Events By Driver ID
  [Tags]  xrsperftest
  ${response} =  Get All Black Box Summaries By Driver ID  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  Request Should Be Successful  ${response}

# Validate Get Black Box Summaries By Vehicle ID
Validate XRS Get Black Box Summaries By Vehicle ID With Forward Slash REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters
  ${w_slash_response} =  Get Black Box Summary By Vehicle ID Response With Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Black Box Summaries By Vehicle ID Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters
  ${wo_slash_response} =  Get Black Box Summary By Vehicle ID Response Without Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Black Box Summary By Vehicle ID With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  vehicle_id=${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  params_string=${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Black Box Summary By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With /? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Black Box Summary By Vehicle ID With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  vehicle_id=${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  params_string=${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Black Box Summary By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With ? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_question_response}

Validate XRS Get Black Box Summary By Vehicle ID REST Web Services For All Black Box Summaries Response Returns 200 OK
  [Documentation]  Gets all the Black Box Events By Vehicle ID
  [Tags]  xrsperftest
  ${response} =  Get All Black Box Summaries By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}
  Request Should Be Successful  ${response}

*** Keywords ***
Test Data Setup For XRS Black Box Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for Black Box Web Service Tests.
  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST} =  Get The nth Active Driver ID  0
  Set Suite Variable  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST} =  Get The nth Active Vehicle ID  0
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}
  # Create test params
  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IncludeHistory=True
  ...  OrderDirection=Ascending
  Set Suite Variable  &{XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  # Create test params string
  ${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS.OrganizationID}
  ...  IncludeHistory=${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS.IncludeHistory}
  ...  OrderDirection=${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS.OrderDirection}
  Set Suite Variable  ${XRS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
