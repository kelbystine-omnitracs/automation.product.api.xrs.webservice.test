*** Settings ***
Documentation   Fundamental suite to test XRS AWS Trailer Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Trailer.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ./EntityManagementTestData/TestTrailerData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Trailer Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrstrailerrestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Trailer REST Web Services Returns 400 Error
  [Documentation]  Verifies that a trailer with a specific number does not exist
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  400

Validate AWS XRS Post Trailer REST Web Services Returns Code 201
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Post Trailers  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Code]  201
  END

Validate AWS XRS Get Trailer REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted trailer now exists
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Trailer REST Web Services Modifies Driver Successfully
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Put Trailers  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Trailer edited successfully.
  END

Validate AWS XRS Get Trailers REST Web Services Returns 200 OK
  [Documentation]  Get trailers with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Trailers With Forward Slash Returns 200 OK  &{params}
  Verify Get Trailers Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Trailers REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get trailers with basic parameters using a raw URI string
  Verify Get Trailers Raw String URI With /? Returns 200 OK
  Verify Get Trailers Raw String URI With ? Returns 200 OK

Validate AWS XRS Delete Trailer REST Web Services Returns 200 OK
  [Documentation]  Verifies that created trailer is deleted
  ${response} =  Delete Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Trailers REST Web Services For All Trailers Returns 200 OK
  [Documentation]  Gets all the trailers
  [Tags]  xrsawsperftest
  ${response} =  Get All Trailers
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Delete Trailers REST Web Services Returns Error Message
  [Documentation]  Attempts to delete a previously deleted trailer.
  ${response} =  Delete Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  ${expected_error_message} =  Set Variable  Trailer not exist.
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[Description]  ${expected_error_message}

# V2 Trailer Web servicesValidate AWS XRS Get Trailer REST Web Services Returns 400 Error
Validate AWS XRS Get Trailer V2 REST Web Services Returns 400 Error
  [Documentation]  Verifies that a trailer with a specific number does not exist
  ${response} =  Get Trailer V2 By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  400

Validate AWS XRS Post Trailer V2 REST Web Services Returns Code 201
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Post Trailers V2  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST_V2}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Code]  201
  END

Validate AWS XRS Get Trailer V2 REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted trailer now exists
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Trailer V2 REST Web Services Modifies Driver Successfully
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Put Trailers V2  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST_V2}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Trailer edited successfully.
  END

Validate AWS XRS Get Trailers V2 REST Web Services Returns 200 OK
  [Documentation]  Get trailers with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Trailers V2 With Forward Slash Returns 200 OK  &{params}
  Verify Get Trailers V2 Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Trailers V2 REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get trailers with basic parameters using a raw URI string
  Verify Get Trailers V2 Raw String URI With /? Returns 200 OK
  Verify Get Trailers V2 Raw String URI With ? Returns 200 OK

Validate AWS XRS Delete Trailer V2 REST Web Services Returns 200 OK
  [Documentation]  Verifies that created trailer is deleted
  ${response} =  Delete Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Trailers V2 REST Web Services For All Trailers Returns 200 OK
  [Documentation]  Gets all the trailers
  [Tags]  xrsawsperftest
  ${response} =  Get All Trailers V2
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Test Data Setup For XRS AWS Trailer Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Trailer Web Service Tests.
  # Create post test Site 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_1_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST}
  # Create put test Site 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_1_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST}
  # Create post test V2 Site 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_1_V2_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER_V2.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  ...  Country=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Country}
  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST_V2} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_1_V2_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST_V2}
  # Create put test V2 Site 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_1_V2_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER_V2.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  ...  Country=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Country}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST_V2} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_1_V2_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST_V2}

Verify Get Trailers Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Trailers  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Trailers With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Trailers With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Trailers Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Trailer}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Trailers V2 Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Trailers V2  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Trailers V2 With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Trailers With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Trailers V2 Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Trailer}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS_V2}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200