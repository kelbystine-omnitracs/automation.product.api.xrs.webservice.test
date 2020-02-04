*** Settings ***
Documentation   Fundamental suite to test XRS AWS Black Box Summary Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/BlackBox.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Driver.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Black Box Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsblackboxrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Black Box Summary REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events with basic parameters
  ${wo_slash_response} =  Get Black Box Summary Response With Forward Slash  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  ${w_slash_response} =  Get Black Box Summary Response Without Forward Slash  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}
  Request Should Be Successful  ${w_slash_response}

Validate AWS XRS Get Black Box Summary REST Web Services Response Returns 200 OK With Raw String URI
  [Documentation]  Get Black Box Events with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Black Box Summary Raw String URI Response With /? And Parameters ${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Black Box Summary Raw String URI Response With ? And Parameters ${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}
  Request Should Be Successful  ${w_question_response}

Validate AWS XRS Get Black Box Summary REST Web Services For All Black Box Summaries Response Returns 200 OK
  [Documentation]  Gets all the Black Box Events
  [Tags]  xrsawsperftest
  ${response} =  Get All Black Box Summaries
  Request Should Be Successful  ${response}

# Validate Get Black Box Summaries By Driver ID
Validate AWS XRS Get Black Box Summaries By Driver ID REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events By Driver ID with basic parameters
  ${w_slash_response} =  Get Black Box Summary By Driver ID Response With Forward Slash  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  ${wo_slash_response} =  Get Black Box Summary By Driver ID Response Without Forward Slash  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}
  Request Should Be Successful  ${wo_slash_response}

Validate AWS XRS Get Black Box Summary By Driver ID REST Web Services Response Returns 200 OK With Raw String URI
  [Documentation]  Get Black Box Events By Driver ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  driver_id=${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  params_string=${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Black Box Summary By Driver ID ${test_data.driver_id} Raw String URI Response With /? And Parameters ${test_data.params_string}
  ${w_question_response} =  Get Black Box Summary By Driver ID ${test_data.driver_id} Raw String URI Response With ? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_slash_question_response}
  Request Should Be Successful  ${w_question_response}

Validate AWS XRS Get Black Box Summary By Driver ID REST Web Services For All Black Box Summaries Response Returns 200 OK
  [Documentation]  Gets all the Black Box Events By Driver ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Black Box Summaries By Driver ID  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  Request Should Be Successful  ${response}

# Validate Get Black Box Summaries By Vehicle ID
Validate AWS XRS Get Black Box Summaries By Vehicle ID REST Web Services Response Returns 200 OK
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters
  ${w_slash_response} =  Get Black Box Summary By Vehicle ID Response With Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  ${wo_slash_response} =  Get Black Box Summary By Vehicle ID Response Without Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}
  Request Should Be Successful  ${wo_slash_response}

Validate AWS XRS Get Black Box Summary By Vehicle ID REST Web Services Response Returns 200 OK With Raw String URI
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  vehicle_id=${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  params_string=${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Black Box Summary By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With /? And Parameters ${test_data.params_string}
  ${w_question_response} =  Get Black Box Summary By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With ? And Parameters ${test_data.params_string}
  Request Should Be Successful  ${w_slash_question_response}
  Request Should Be Successful  ${w_question_response}

Validate AWS XRS Get Black Box Summary By Vehicle ID REST Web Services For All Black Box Summaries Response Returns 200 OK
  [Documentation]  Gets all the Black Box Events By Vehicle ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Black Box Summaries By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}
  Request Should Be Successful  ${response}

*** Keywords ***
Test Data Setup For XRS AWS Black Box Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Black Box Web Service Tests.
  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST} =  Get The nth Active Driver ID  0
  Set Suite Variable  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST} =  Get The nth Active Vehicle ID  0
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}
  # Create test params
  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IncludeHistory=True
  ...  OrderDirection=Ascending
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS.OrganizationID}
  ...  IncludeHistory=${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS.IncludeHistory}
  ...  OrderDirection=${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS.OrderDirection}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_BLACKBOX_TEST_PARAMS_STRING}
