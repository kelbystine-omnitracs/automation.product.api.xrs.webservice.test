*** Settings ***
Documentation   Fundamental suite to test XRS AWS Resource Group Entity Management Web Services
Resource        ../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../Resources/XRS_WebServices/EntityManagement/ResourceGroup.resource
Resource        ../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
Variables       ../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/ResourceGroupsDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Create AWS XRS Web Services Session
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsresourcegrouprestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Resource Groups REST Web Services Returns 200 OK
  [Documentation]  Get Resource Groups with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Resource Groups With Forward Slash Returns 200 OK  &{params}
  Verify Get Resource Groups Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Resource Groups REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Resource Groups with basic parameters using a raw URI string
  Verify Get Resource Groups Raw String URI With /? Returns 200 OK
  Verify Get Resource Groups Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Resource Groups REST Web Services For All Resource Groups Returns 200 OK
  [Documentation]  Gets all the Organizations
  [Tags]  xrsawsperftest
  ${response} =  Get All Resource Groups
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Device REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted device now exists
  ${response} =  Get Resource Group By Resource Group Id  ${DEFAULT_RESOURCE_GROUP.RESOURCE_GROUP_NAME}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Verify Get Resource Groups Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Resource Groups  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Resource Groups With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Resource Groups With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Resource Groups Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Resource_Group}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUPS}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200