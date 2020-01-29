*** Settings ***
Documentation   Fundamental suite to test XRS AWS User Entity Management Web Services
Library  Collections
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/User.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Variables       ./EntityManagementTestData/TestUserData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS User Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsuserrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get User REST Web Services Returns Geographic "User does not exist." Error Message
  [Documentation]  Verifies that a User with a specific number does not exist
  ${response} =  Get User By ID  ${XRS_WEB_SERVICES_TEST_USER.UserName}
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[ErrorMessage]  User '${XRS_WEB_SERVICES_TEST_USER.UserName}' does not exist.

Validate AWS XRS Post User REST Web Services Returns Code 201
  [Documentation]  Posts a User and expects a Code value of 201
  ${response} =  Post Users  @{XRS_AWS_WEBSERVICE_POST_TEST_USER_LIST}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get User REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted User now exists
  ${response} =  Get User By ID  ${XRS_WEB_SERVICES_TEST_USER.UserName}
  Should Be Equal As Strings  ${response.status_code}  200
  # Set a global veriable for delete user test
  ${XRS_WEB_SERVICES_TEST_USER_SID} =  Get Value From Response With Key  UserName  ${response}
  Set Global Variable  ${XRS_WEB_SERVICES_TEST_USER_SID}

Validate AWS XRS Put User REST Web Services Modifies User Successfully
  [Documentation]  Posts a User and expects a Code value of 201
  ${response} =  Put Users  @{XRS_AWS_WEBSERVICE_PUT_TEST_USER_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Geographic User edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Users REST Web Services Returns 200 OK
  [Documentation]  Get Users with basic parameters
  ${wo_slash_response} =  Get Users Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_USER_TEST_PARAMS}
  ${w_slash_response} =  Get Users Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_USER_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Users REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Users with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Users Raw String URI Response Code With /? And Parameters ${XRS_AWS_WEBSERVICE_USER_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Users Raw String URI Response Code With ? And Parameters ${XRS_AWS_WEBSERVICE_USER_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

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
  &{expected_values} =  Create Dictionary  key=Description  value=User ID does not exist.
  ${actual_value} =  Get Value From Response With Key  ${expected_values.key}  ${response}
  Should Be Equal As Strings  ${actual_value}  ${expected_values.value}

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
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_USER_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_USER_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_USER_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_USER_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_USER_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_USER_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_USER_TEST_PARAMS_STRING}
