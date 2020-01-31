*** Settings ***
Documentation   Fundamental suite to test XRS AWS Critical Events Summary Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/CriticalEvents.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Driver.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Critical Events Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrscriticaleventsrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Critical Events Summary REST Web Services Returns 200 OK
  [Documentation]  Get Critical Events Events with basic parameters
  ${wo_slash_response} =  Get Critical Events Summary Response With Forward Slash  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS}
  ${w_slash_response} =  Get Critical Events Summary Response Without Forward Slash  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Critical Events Summary REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Critical Events Events with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Critical Events Summary Raw String URI Response With /? And Parameters ${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Critical Events Summary Raw String URI Response With ? And Parameters ${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Critical Events Summary REST Web Services For All Critical Events Summaries Returns 200 OK
  [Documentation]  Gets all the Critical Events Events
  [Tags]  xrsawsperftest
  ${response} =  Get All Critical Events Summaries
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Critical Events Summaries By Driver ID
Validate AWS XRS Get Critical Events Summaries By Driver ID REST Web Services Returns 200 OK
  [Documentation]  Get Critical Events Events By Driver IDwith basic parameters
  ${wo_slash_response} =  Get Critical Events Summary By Driver ID Response With Forward Slash  ${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST}  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS}
  ${w_slash_response} =  Get Critical Events Summary By Driver ID Response Without Forward Slash  ${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST}  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Critical Events Summary By Driver ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Critical Events Events By Driver IDwith basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  driver_id=${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST}  params_string=${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Critical Events Summary By Driver ID ${test_data.driver_id} Raw String URI Response With /? And Parameters ${test_data.params_string}
  ${w_question_response} =  Get Critical Events Summary By Driver ID ${test_data.driver_id} Raw String URI Response With ? And Parameters ${test_data.params_string}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Critical Events Summary By Driver ID REST Web Services For All Critical Events Summaries Returns 200 OK
  [Documentation]  Gets all the Critical Events Events By Driver ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Critical Events Summaries By Driver ID  ${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Critical Events Summaries By Vehicle ID
Validate AWS XRS Get Critical Events Summaries By Vehicle ID REST Web Services Returns 200 OK
  [Documentation]  Get Critical Events Events By Vehicle ID with basic parameters
  ${wo_slash_response} =  Get Critical Events Summary By Vehicle ID Response With Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST}  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS}
  ${w_slash_response} =  Get Critical Events Summary By Vehicle ID Response Without Forward Slash  ${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST}  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Critical Events Summary By Vehicle ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Critical Events Events By Vehicle ID with basic parameters using a raw URI string
  &{test_data} =  Create Dictionary  vehicle_id=${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST}  params_string=${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS_STRING}
  ${w_slash_question_response} =  Get Critical Events Summary By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With /? And Parameters ${test_data.params_string}
  ${w_question_response} =  Get Critical Events Summary By Vehicle ID ${test_data.vehicle_id} Raw String URI Response With ? And Parameters ${test_data.params_string}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Critical Events Summary By Vehicle ID REST Web Services For All Critical Events Summaries Returns 200 OK
  [Documentation]  Gets all the Critical Events Events By Vehicle ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Critical Events Summaries By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Test Data Setup For XRS AWS Critical Events Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Critical Events Web Service Tests.
  ${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST} =  Get The nth Active Driver ID  0
  Set Suite Variable  ${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST}
  ${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST} =  Get The nth Active Vehicle ID  0
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST}
  # Create test params
  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IncludeHistory=True
  ...  OrderDirection=Ascending
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS.OrganizationID}
  ...  IncludeHistory=${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS.IncludeHistory}
  ...  OrderDirection=${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS.OrderDirection}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_CRITICAL_EVENTS_TEST_PARAMS_STRING}

Verify Get Critical Events Summary Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Critical Events Summary  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Critical Events Summary With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Critical_Events}  ${XRS_WEBSERVICE_PERFORMANCE_GET_CRITICAL_EVENTS_SUMMARY}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

# Keywords For Get Critical Events Summaries By Driver ID
Verify Get Critical Events Summary By Driver ID Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Critical Events Summary By Driver ID And Parameters  ${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST}  ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Driver ID With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Critical Events Summary By Driver ID ${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST} With URI Ending With ${ending_character} And Parameters ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Driver ID Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Critical_Events}  ${XRS_WEBSERVICE_PERFORMANCE_GET_CRITICAL_EVENTS_SUMMARY_BY_DRIVER_ID}/${SAMPLE_DRIVER_ID_FOR_CRITICAL_EVENTS_TEST}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

# Keywords For Get Critical Events Summaries By Vehicle ID
Verify Get Critical Events Summary By Vehicle ID Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Critical Events Summary By Vehicle ID And Parameters  ${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST}  ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Vehicle ID With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Critical Events Summary By Vehicle ID ${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST} With URI Ending With ${ending_character} And Parameters ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Vehicle ID Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Critical_Events}  ${XRS_WEBSERVICE_PERFORMANCE_GET_CRITICAL_EVENTS_SUMMARY_BY_VEHICLE_ID}/${SAMPLE_VEHICLE_ID_FOR_CRITICAL_EVENTS_TEST}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
