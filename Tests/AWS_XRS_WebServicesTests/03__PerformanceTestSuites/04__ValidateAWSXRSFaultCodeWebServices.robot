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
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Fault Code REST Web Services Returns 200 OK
  [Documentation]  Get Fault Code Events with basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  
  Verify Get Fault Code With Forward Slash Returns 200 OK  &{params}
  Verify Get Fault Code Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Fault Code REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Fault Code Events with basic parameters using a raw URI string
  Verify Get Fault Code Raw String URI With /? Returns 200 OK
  Verify Get Fault Code Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Fault Code REST Web Services For All Fault Codes Returns 200 OK
  [Documentation]  Gets all the Fault Code Events
  [Tags]  xrsawsperftest
  ${response} =  Get All Fault Codes
  Should Be Equal As Strings  ${response.status_code}  200

# Validate Get Fault Codes By Vehicle ID
Validate AWS XRS Get Fault Codes By Vehicle ID REST Web Services Returns 200 OK
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  Verify Get Fault Code By Vehicle ID With Forward Slash Returns 200 OK  &{params}
  Verify Get Fault Code By Vehicle ID Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Fault Code By Vehicle ID REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Fault Code Events By Vehicle ID with basic parameters using a raw URI string
  Verify Get Fault Code By Vehicle ID Raw String URI With /? Returns 200 OK
  Verify Get Fault Code By Vehicle ID Raw String URI With ? Returns 200 OK

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

Verify Get Fault Code Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Fault Codes  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Fault Code With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Fault Codes With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Fault Code Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Fault_Code}  ${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

# Keywords For Get Fault Codes By Vehicle ID
Verify Get Fault Code By Vehicle ID Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Fault Codes By Vehicle ID And Parameters  ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}  ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Fault Code By Vehicle ID With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Fault Codes By Vehicle ID ${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST} With URI Ending With ${ending_character} And Parameters ${params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Fault Code By Vehicle ID Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ${uri_string} =  Create URI String With  ${XRS_Performance_Base_URI.Fault_Code}  ${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES_BY_VEHICLE_ID}/${SAMPLE_VEHICLE_ID_FOR_FAULT_CODE_TEST}   ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IncludeHistory=${params.IncludeHistory}&OrderDirection=${params.OrderDirection}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
