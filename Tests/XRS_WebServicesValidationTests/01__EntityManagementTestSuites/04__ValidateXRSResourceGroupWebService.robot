*** Settings ***
Documentation   Fundamental suite to test XRS Resource Group Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/ResourceGroup.resource
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/ResourceGroupsDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create REST API Session
                ...  AND Test Data Setup For XRS Resource Group Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      xrsrestwebservicevalidation  xrsresourcegrouprestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate XRS Get Resource Groups With Forward Slash REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Resource Groups with basic parameters
  ${w_slash_response} =  Get Resource Groups Response With Forward Slash  &{XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Resource Groups Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get Resource Groups with basic parameters
  ${wo_slash_response} =  Get Resource Groups Response Without Forward Slash  &{XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Resource Groups With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Tags]  aws_only
  [Documentation]  Get Resource Groups with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Resource Groups Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Resource Groups With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get Resource Groups with basic parameters using a raw URI string
  ${w_question_response} =  Get Resource Groups Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_question_response}

Validate XRS Get Resource Groups REST Web Services For All Resource Groups Response Returns 200 OK
  [Documentation]  Gets all the Organizations
  [Tags]  xrsperftest
  ${response} =  Get All Resource Groups
  Request Should Be Successful  ${response}

Validate XRS Get Resource Group REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that a posted device now exists
  ${response} =  Get Resource Group By Resource Group Id  ${DEFAULT_RESOURCE_GROUP.RESOURCE_GROUP_NAME}
  Request Should Be Successful  ${response}

*** Keywords ***
Test Data Setup For XRS Resource Group Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for Resource Group Web Service Tests.
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS}
  # Create test params string
  ${XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_WEBSERVICE_RESOURCE_GROUP_TEST_PARAMS_STRING}
