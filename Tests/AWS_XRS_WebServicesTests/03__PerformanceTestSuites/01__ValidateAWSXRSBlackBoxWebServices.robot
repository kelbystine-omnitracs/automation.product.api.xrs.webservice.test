*** Settings ***
Documentation   Fundamental suite to test XRS AWS Black Box Summary Performance Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/Performance/BlackBox.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Driver.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Black Box Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsblackboxrestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Black Box Summary REST Web Services Returns 200 OK
  [Documentation]  Get Black Box Events with basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  Verify Get Black Box Summary With Forward Slash Returns 200 OK  &{params}
  Verify Get Black Box Summary Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Black Box Summary REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Black Box Events with basic parameters using a raw URI string
  Verify Get Black Box Summary Raw String URI With /? Returns 200 OK
  Verify Get Black Box Summary Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Black Box Summary REST Web Services For All Black Box Summaries Returns 200 OK
  [Documentation]  Gets all the Black Box Events
  [Tags]  xrsawsperftest
  ${response} =  Get All Black Box Summaries
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Black Box Summaries By Driver ID
Validate AWS XRS Get Black Box Summaries By Driver ID REST Web Services Returns 200 OK
  [Documentation]  Get Black Box Events By Driver IDwith basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  Verify Get Black Box Summary By Driver ID With Forward Slash Returns 200 OK  &{params}
  Verify Get Black Box Summary By Driver ID Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Black Box Summary By Driver ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Black Box Events By Driver IDwith basic parameters using a raw URI string
  Verify Get Black Box Summary By Driver ID Raw String URI With /? Returns 200 OK
  Verify Get Black Box Summary By Driver ID Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Black Box Summary By Driver ID REST Web Services For All Black Box Summaries Returns 200 OK
  [Documentation]  Gets all the Black Box Events By Driver ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Black Box Summaries By Driver ID  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Black Box Summaries By Vehicle ID
Validate AWS XRS Get Black Box Summaries By Vehicle ID REST Web Services Returns 200 OK
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  Verify Get Black Box Summary By Vehicle ID With Forward Slash Returns 200 OK  &{params}
  Verify Get Black Box Summary By Vehicle ID Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Black Box Summary By Vehicle ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Black Box Events By Vehicle ID with basic parameters using a raw URI string
  Verify Get Black Box Summary By Vehicle ID Raw String URI With /? Returns 200 OK
  Verify Get Black Box Summary By Vehicle ID Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Black Box Summary By Vehicle ID REST Web Services For All Black Box Summaries Returns 200 OK
  [Documentation]  Gets all the Black Box Events By Vehicle ID
  [Tags]  xrsawsperftest
  ${response} =  Get All Black Box Summaries By Vehicle ID  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Test Data Setup For XRS AWS Black Box Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Black Box Web Service Tests.
  ${driver_response} =  Get Drivers  IsActive=True
  ${driver_response_json} =  To Json  ${driver_response.content}
  &{get_first_active_driver} =  Set Variable  @{driver_response_json}[0]
  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST} =  Set Variable  ${get_first_active_driver.DriverID}
  Set Suite Variable  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}
  ${vehicle_response} =  Get Vehicles  IsActive=True
  ${vehicle_response_json} =  To Json  ${vehicle_response.content}
  &{get_first_active_vehicle} =  Set Variable  @{vehicle_response_json}[0]
  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST} =  Set Variable  ${get_first_active_vehicle.VehicleName}
  Set Suite Variable  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}

Verify Get Black Box Summary Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Black Box Summary  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Black Box Summary With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Black Box Summary With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Black Box Summary Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Black_Box}  ${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

# Keywords For Get Black Box Summaries By Driver ID
Verify Get Black Box Summary By Driver ID Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Black Box Summary By Driver ID And Parameters  ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}  ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Black Box Summary By Driver ID With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Black Box Summary By Driver ID ${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST} With URI Ending With ${ending_character} And Parameters ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Black Box Summary By Driver ID Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Black_Box}  ${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_DRIVER_ID}/${SAMPLE_DRIVER_ID_FOR_BLACKBOX_TEST}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

# Keywords For Get Black Box Summaries By Vehicle ID
Verify Get Black Box Summary By Vehicle ID Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Black Box Summary By Vehicle ID And Parameters  ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}  ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Black Box Summary By Vehicle ID With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Black Box Summary By Vehicle ID ${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST} With URI Ending With ${ending_character} And Parameters ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Black Box Summary By Vehicle ID Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IncludeHistory=True  OrderDirection=Ascending
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Black_Box}  ${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_VEHICLE_ID}/${SAMPLE_VEHICLE_ID_FOR_BLACKBOX_TEST}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
