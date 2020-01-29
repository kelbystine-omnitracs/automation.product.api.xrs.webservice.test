*** Settings ***
Documentation   Fundamental suite to test XRS AWS Daily Detail Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/DailyDetail.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Driver.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Daily Detail Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsdailydetailrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Daily Detail REST Web Services Returns 200 OK
  [Documentation]  Get Daily Detail Events with basic parameters
  ${wo_slash_response} =  Get Daily Detail Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS}
  ${w_slash_response} =  Get Daily Detail Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Daily Detail REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Daily Detail Events with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Daily Detail Raw String URI Response Code With /? And Parameters ${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Daily Detail Raw String URI Response Code With ? And Parameters ${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Daily Detail REST Web Services For All Daily Details Returns 200 OK
  [Documentation]  Gets all the Daily Detail Events
  [Tags]  xrsawsperftest
  ${response} =  Get All Daily Details With Organization ID  ${XRS_GENERAL_INFORMATION.Company.Company_ID}
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Daily Details By Driver ID
Validate AWS XRS Get Daily Details By Driver ID REST Web Services Returns 200 OK
  [Documentation]  Get Daily Detail Events By Driver IDwith basic parameters
  ${wo_slash_response} =  Get Daily Detail By Driver ID Response Code With Forward Slash  ${SAMPLE_DRIVER_ID_FOR_DAILY_DETAIL_TEST}  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS}
  ${w_slash_response} =  Get Daily Detail By Driver ID Response Code Without Forward Slash  ${SAMPLE_DRIVER_ID_FOR_DAILY_DETAIL_TEST}  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Daily Detail By Driver ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Daily Detail Events By Driver IDwith basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  driver_id=${SAMPLE_DRIVER_ID_FOR_DAILY_DETAIL_TEST}  params_string=${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Daily Detail By Driver ID ${test_data.driver_id} Raw String URI Response Code With /? And Parameters ${test_data.params_string}
  ${w_question_response} =  Get Daily Detail By Driver ID ${test_data.driver_id} Raw String URI Response Code With ? And Parameters ${test_data.params_string}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Daily Detail By Driver ID REST Web Services For All Daily Details Returns 200 OK
  [Documentation]  Gets all the Daily Detail Events By Driver ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Daily Details By Driver ID  ${SAMPLE_DRIVER_ID_FOR_DAILY_DETAIL_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Daily Details By Vehicle ID
Validate AWS XRS Get Daily Details By Vehicle ID REST Web Services Returns 200 OK
  [Documentation]  Get Daily Detail Events By Vehicle ID with basic parameters
  ${wo_slash_response} =  Get Daily Detail By Vehicle ID Response Code With Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_DAILY_DETAIL_TEST}  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS}
  ${w_slash_response} =  Get Daily Detail By Vehicle ID Response Code Without Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_DAILY_DETAIL_TEST}  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Daily Detail By Vehicle ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Daily Detail Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  driver_id=${SAMPLE_DRIVER_ID_FOR_DAILY_DETAIL_TEST}  params_string=${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Daily Detail By Vehicle ID ${test_data.vehicle_id} Raw String URI Response Code With /? And Parameters ${test_data.params_string}
  ${w_question_response} =  Get Daily Detail By Vehicle ID ${test_data.vehicle_id} Raw String URI Response Code With ? And Parameters ${test_data.params_string}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Daily Detail By Vehicle ID REST Web Services For All Daily Details Returns 200 OK
  [Documentation]  Gets all the Daily Detail Events By Vehicle ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Daily Details By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_DAILY_DETAIL_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Test Data Setup For XRS AWS Daily Detail Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Daily Detail Web Service Tests.
  ${SAMPLE_DRIVER_ID_FOR_DAILY_DETAIL_TEST} =  Get The nth Active Driver ID  0
  Set Suite Variable  ${SAMPLE_DRIVER_ID_FOR_DAILY_DETAIL_TEST}
  ${SAMPLE_VEHICLE_ID_FOR_DAILY_DETAIL_TEST} =  Get The nth Active Vehicle ID  0
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_DAILY_DETAIL_TEST}
  # Create test params
  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IncludeHistory=True
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS.OrganizationID}
  ...  IncludeHistory=${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS.IncludeHistory}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_DAILY_DETAIL_TEST_PARAMS_STRING}