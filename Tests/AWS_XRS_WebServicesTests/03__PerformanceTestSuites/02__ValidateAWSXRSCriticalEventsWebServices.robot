*** Settings ***
Documentation   Fundamental suite to test XRS AWS Critical Events Summary Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/CriticalEvents.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Driver.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Critical Events Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrscriticaleventsrestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Critical Events Summary REST Web Services Returns 200 OK
  [Documentation]  Get Critical Events Events with basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  Verify Get Critical Events Summary With Forward Slash Returns 200 OK  &{params}
  Verify Get Critical Events Summary Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Critical Events Summary REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Critical Events Events with basic parameters using a raw URI string
  Verify Get Critical Events Summary Raw String URI With /? Returns 200 OK
  Verify Get Critical Events Summary Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Critical Events Summary REST Web Services For All Critical Events Summaries Returns 200 OK
  [Documentation]  Gets all the Critical Events Events
  [Tags]  xrsawsperftest
  ${response} =  Get All Critical Events Summaries
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Critical Events Summaries By Driver ID
Validate AWS XRS Get Critical Events Summaries By Driver ID REST Web Services Returns 200 OK
  [Documentation]  Get Critical Events Events By Driver IDwith basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  Verify Get Critical Events Summary By Driver ID With Forward Slash Returns 200 OK  &{params}
  Verify Get Critical Events Summary By Driver ID Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Critical Events Summary By Driver ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Critical Events Events By Driver IDwith basic parameters using a raw URI string
  Verify Get Critical Events Summary By Driver ID Raw String URI With /? Returns 200 OK
  Verify Get Critical Events Summary By Driver ID Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Critical Events Summary By Driver ID REST Web Services For All Critical Events Summaries Returns 200 OK
  [Documentation]  Gets all the Critical Events Events By Driver ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Critical Events Summaries By Driver ID  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Critical Events Summaries By Vehicle ID
Validate AWS XRS Get Critical Events Summaries By Vehicle ID REST Web Services Returns 200 OK
  [Documentation]  Get Critical Events Events By Vehicle ID with basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  Verify Get Critical Events Summary By Vehicle ID With Forward Slash Returns 200 OK  &{params}
  Verify Get Critical Events Summary By Vehicle ID Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Critical Events Summary By Vehicle ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Critical Events Events By Vehicle ID with basic parameters using a raw URI string
  Verify Get Critical Events Summary By Vehicle ID Raw String URI With /? Returns 200 OK
  Verify Get Critical Events Summary By Vehicle ID Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Critical Events Summary By Vehicle ID REST Web Services For All Critical Events Summaries Returns 200 OK
  [Documentation]  Gets all the Critical Events Events By Vehicle ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Critical Events Summaries By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Test Data Setup For XRS AWS Critical Events Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Critical Events Web Service Tests.
  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST} =  Get The nth Active Driver ID  0
  Set Suite Variable  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST} =  Get The nth Active Vehicle ID  0
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}

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
  ${response} =  Get Critical Events Summary By Driver ID And Parameters  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Driver ID With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Critical Events Summary By Driver ID ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST} With URI Ending With ${ending_character} And Parameters ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Driver ID Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Critical_Events}  ${XRS_WEBSERVICE_PERFORMANCE_GET_CRITICAL_EVENTS_SUMMARY_BY_DRIVER_ID}/${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

# Keywords For Get Critical Events Summaries By Vehicle ID
Verify Get Critical Events Summary By Vehicle ID Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Critical Events Summary By Vehicle ID And Parameters  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Vehicle ID With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Critical Events Summary By Vehicle ID ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST} With URI Ending With ${ending_character} And Parameters ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Critical Events Summary By Vehicle ID Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Critical_Events}  ${XRS_WEBSERVICE_PERFORMANCE_GET_CRITICAL_EVENTS_SUMMARY_BY_VEHICLE_ID}/${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
