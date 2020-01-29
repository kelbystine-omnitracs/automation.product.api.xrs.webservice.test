*** Settings ***
Documentation   Fundamental suite to test XRS AWS Resource Group Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/ResourceGroup.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/ResourceGroupsDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND Test Data Setup For XRS AWS Resource Group Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsresourcegrouprestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Resource Groups REST Web Services Returns 200 OK
  [Documentation]  Get Resource Groups with basic parameters
  ${wo_slash_response} =  Get Resource Groups Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS}
  ${w_slash_response} =  Get Resource Groups Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Resource Groups REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Resource Groups with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Resource Groups Raw String URI Response Code With /? And Parameters ${XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Resource Groups Raw String URI Response Code With ? And Parameters ${XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Get Resource Groups REST Web Services For All Resource Groups Returns 200 OK
  [Documentation]  Gets all the Organizations
  [Tags]  xrsawsperftest
  ${response} =  Get All Resource Groups
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Resource Group REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted device now exists
  ${response} =  Get Resource Group By Resource Group Id  ${DEFAULT_RESOURCE_GROUP.RESOURCE_GROUP_NAME}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Test Data Setup For XRS AWS Resource Group Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Device Web Service Tests.
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING}
