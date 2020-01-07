*** Settings ***
Documentation   Fundamental suite to test XRS AWS User Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/User.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ./EntityManagementTestData/TestUserData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS User Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsuserrestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get User REST Web Services Returns Geographic "User does not exist." Error Message
  [Documentation]  Verifies that a User with a specific number does not exist
  ${response} =  Get User By ID  ${XRS_WEB_SERVICES_TEST_USER.UserName}
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[ErrorMessage]  User '${XRS_WEB_SERVICES_TEST_USER.UserName}' does not exist.

Validate AWS XRS Post User REST Web Services Returns Code 201
  [Documentation]  Posts a User and expects a Code value of 201
  ${response} =  Post Users  @{XRS_AWS_WEBSERVICE_POST_TEST_USER_LIST}
  ${json_response} =  To Json  ${response.content}  
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Code]  201
  END

Validate AWS XRS Get User REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted User now exists
  ${response} =  Get User By ID  ${XRS_WEB_SERVICES_TEST_USER.UserName}
  Should Be Equal As Strings  ${response.status_code}  200
  ${json_response} =  To Json  ${response.content}
  ${XRS_WEB_SERVICES_TEST_USER_SID} =  Set Variable  ${json_response}[UserName]
  Set Global Variable  ${XRS_WEB_SERVICES_TEST_USER_SID}

Validate AWS XRS Put User REST Web Services Modifies User Successfully
  [Documentation]  Posts a User and expects a Code value of 201
  ${response} =  Put Users  @{XRS_AWS_WEBSERVICE_PUT_TEST_USER_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Geographic User edited successfully.
  END

Validate AWS XRS Get Users REST Web Services Returns 200 OK
  [Documentation]  Get Users with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Users With Forward Slash Returns 200 OK  &{params}
  Verify Get Users Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Users REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Users with basic parameters using a raw URI string
  Verify Get Users Raw String URI With /? Returns 200 OK
  Verify Get Users Raw String URI With ? Returns 200 OK

Validate AWS XRS Delete User REST Web Services Returns 200 OK
  [Documentation]  Verifies that created User is deleted
  ${response} =  Delete User By ID  ${XRS_WEB_SERVICES_TEST_USER.UserName}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Users REST Web Services For All Users Returns 200 OK
  [Documentation]  Gets all the Users
  [Tags]  xrsawsperftest
  ${response} =  Get All Users
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Delete User REST Web Services Returns Description "User ID does not exist."
  [Documentation]  Attempts to delete a previously deleted User.
  ${response} =  Delete User By ID  ${XRS_WEB_SERVICES_TEST_USER_SID}
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[Description]  User ID does not exist.

*** Keywords ***
Test Data Setup For XRS AWS User Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS User Web Service Tests.
  # Create post test User 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_USER_1_DICT} =  Create Dictionary
  ...  AccountLocked=${XRS_WEB_SERVICES_TEST_USER.AccountLocked}
  ...  DashboardName=${XRS_WEB_SERVICES_TEST_USER.DashboardName}
  ...  Email=${XRS_WEB_SERVICES_TEST_USER.Email}
  ...  EncryptedPassword=${XRS_WEB_SERVICES_TEST_USER.EncryptedPassword}
  ...  FirstName=${XRS_WEB_SERVICES_TEST_USER.FirstName}
  ...  Language=${XRS_WEB_SERVICES_TEST_USER.Language}
  ...  LastName=${XRS_WEB_SERVICES_TEST_USER.LastName}
  ...  MiddleName=${XRS_WEB_SERVICES_TEST_USER.MiddleName}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  PasswordNeverExpires=${XRS_WEB_SERVICES_TEST_USER.PasswordNeverExpires}
  ...  Status=${XRS_WEB_SERVICES_TEST_USER.Status}
  ...  UserName=${XRS_WEB_SERVICES_TEST_USER.UserName}
  ...  UserRole=${XRS_WEB_SERVICES_TEST_USER.UserRole}
  @{XRS_AWS_WEBSERVICE_POST_TEST_USER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_USER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_USER_LIST}
  # Create put test User 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_USER_1_DICT} =  Create Dictionary
  ...  AccountLocked=${XRS_WEB_SERVICES_TEST_USER.AccountLocked}
  ...  DashboardName=${XRS_WEB_SERVICES_TEST_USER.DashboardName}
  ...  Email=${XRS_WEB_SERVICES_TEST_USER.Email}
  ...  EncryptedPassword=${XRS_WEB_SERVICES_TEST_USER.EncryptedPassword}
  ...  FirstName=${XRS_WEB_SERVICES_TEST_USER.FirstName}
  ...  Language=${XRS_WEB_SERVICES_TEST_USER.Language}
  ...  LastName=${XRS_WEB_SERVICES_TEST_USER.LastName}
  ...  MiddleName=${XRS_WEB_SERVICES_TEST_USER.MiddleName}modified
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  PasswordNeverExpires=${XRS_WEB_SERVICES_TEST_USER.PasswordNeverExpires}
  ...  Status=${XRS_WEB_SERVICES_TEST_USER.Status}
  ...  UserName=${XRS_WEB_SERVICES_TEST_USER.UserName}
  ...  UserRole=${XRS_WEB_SERVICES_TEST_USER.UserRole}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_USER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_USER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_USER_LIST}

Verify Get Users Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Users  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Users With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Users With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Users Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.User}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
