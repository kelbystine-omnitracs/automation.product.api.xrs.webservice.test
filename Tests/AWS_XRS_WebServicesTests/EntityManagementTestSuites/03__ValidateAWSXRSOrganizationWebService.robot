*** Settings ***
Documentation   Fundamental suite to test XRS AWS Organization Entity Management Web Services
Library         FakerLibrary
Library         JSONLibrary
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Organization.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ./EntityManagementTestData/TestOrganizationData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Organization Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsorganizationrestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Organization By SID REST Web Services Returns 200 OK With Parent Organization SID
  [Documentation]  Verifies that a Organization with a specific number does not exist
  ${response} =  Get Organization By OrganizationSID  ${XRS_GENERAL_INFORMATION.Company.ParentOrganizationSid}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Post Organization REST Web Services Returns Caption "Request succeeded."
  [Documentation]  Posts a Organization and expects a Caption value "Request succeeded."
  ${response} =  Post Organizations  @{XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Caption]  Request succeeded.
    ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_SID} =  Set Variable  ${r}[SID]
  END
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}

Validate AWS XRS Get Organization By SID REST Web Services Returns 200 OK With New Organization
  [Documentation]  Verifies that a posted Organization now exists
  ${response} =  Get Organization By OrganizationSID  ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Organization REST Web Services Modifies Description Successfully
  [Documentation]  Posts a Organization and expects a Code value of 201
  ${response} =  Put Organizations  @{XRS_AWS_WEBSERVICE_PUT_TEST_ORGANIZATION_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Organization Edited Successfully.
  END

Validate AWS XRS Get Organizations By Parameters REST Web Services Returns 200 OK
  [Documentation]  Get Organizations with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationSid=${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Organizations With Forward Slash Returns 200 OK  &{params}
  Verify Get Organizations Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Organizations By Parameters REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Organizations with basic parameters using a raw URI string
  Verify Get Organizations Raw String URI With /? Returns 200 OK
  Verify Get Organizations Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Organizations By ID REST Web Services Returns 200 OK
  [Documentation]  Get organization by ID returns 200 OK
  ${response} =  Get Organizations By ID  ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT.OrganizationId}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Organizations REST Web Services For All Organizations Returns 200 OK
  [Documentation]  Gets all the Organizations
  [Tags]  xrsawsperftest
  ${response} =  Get All Organizations
  Should Be Equal As Strings  ${response.status_code}  200

# Organizations Performance (settings) Data Tests
Validate AWS XRS Get Organizations Performance (settings) Data By SID REST Web Services Returns 200 OK
  [Documentation]  Get organization performance endpoint by ID returns 200 OK
  ${response} =  Get Organizations Performance Data By ID  ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT.OrganizationId}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Organization Performance (settings) Data By SID REST Web Services Update Return 200 OK
  [Documentation]  Sends an performance settings update request from a json file, expects a 200 response
  ${json_data} =  Load JSON From File  ${CURDIR}/EntityManagementTestData/organization_performance_minimum_setting.json
  # @{jsdon_data_as_list} =  Create List  ${json_data}
  ${response} =  Put Organizations Performance Data By ID  ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT.OrganizationId}  ${json_data}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Organizations Performance (settings) Data By Parameters REST Web Services Returns 200 OK
  [Documentation]  Get Organizations with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary
  ...  OrganizationId=${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT.OrganizationId}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Organizations Performance (settings) Data With Forward Slash Returns 200 OK  &{params}
  Verify Get Organizations Performance (settings) Data Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Organizations Performance (settings) Data By Parameters REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Organizations with basic parameters using a raw URI string
  Verify Get Organizations Performance (settings) Data Raw String URI With /? Returns 200 OK
  Verify Get Organizations Performance (settings) Data Raw String URI With ? Returns 200 OK

*** Keywords ***
Test Data Setup For XRS AWS Organization Web Service Test Suite
  [Documentation]  Keyword for setting up a random organization for the organization test suite
  ${FAKE_WORD1} =  FakerLibrary.Word
  ${FAKE_WORD2} =  FakerLibrary.Word
  ${FAKE_TEST_ORGANIZATION_ID_1} =  Set Variable  ${FAKE_WORD1}${FAKE_WORD2}
  ${FAKE_TEST_ORGANIZATION_NAME_1} =  Set Variable  ${FAKE_WORD1}${SPACE}${FAKE_WORD2}
  # Create post test organization 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT} =  Create Dictionary
  ...  CarrierName=${XRS_GENERAL_INFORMATION.Address.Carrier_Name}
  ...  Country=${XRS_GENERAL_INFORMATION.Address.Country}
  ...  DotNumber=${XRS_GENERAL_INFORMATION.Address.DOT_Number}
  ...  Language=${XRS_GENERAL_INFORMATION.Localization.Language}
  ...  OrganizationId=${FAKE_TEST_ORGANIZATION_ID_1}
  ...  OrganizationName=${FAKE_TEST_ORGANIZATION_NAME_1}
  ...  ParentOrganizationId=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  ParentOrganizationSid=${XRS_GENERAL_INFORMATION.Company.ParentOrganizationSid}
  ...  TimeZone=CST
  @{XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_LIST}
  # Create put test organization 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_ORGANIZATION_1_DICT} =  Create Dictionary
  ...  Language=${XRS_GENERAL_INFORMATION.Localization.Language}
  ...  OrganizationId=${FAKE_TEST_ORGANIZATION_ID_1}
  ...  OrganizationName=${FAKE_TEST_ORGANIZATION_NAME_1}Modified
  ...  ParentOrganizationId=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_ORGANIZATION_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_ORGANIZATION_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_ORGANIZATION_LIST}

Verify Get Organizations Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Organizations  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Organizations With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Organizations With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Organizations Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationSid=${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Organization}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationSid=${params.OrganizationSid}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

# Keywords for Organizations Performance (settings) Data
Verify Get Organizations Performance (settings) Data Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Organizations Performance Data  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Organizations Performance (settings) Data With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Organizations Performance Data With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Organizations Performance (settings) Data Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationSid=${XRS_AWS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Organization}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_PUT_ORGANIZATIONS_PERFORMANCE}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationSid=${params.OrganizationSid}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
