*** Settings ***
Documentation   Fundamental suite to test XRS Organization Entity Management Web Services
Library         FakerLibrary
Library         JSONLibrary
Library         Collections
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Organization.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Variables       ./EntityManagementTestData/TestOrganizationData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords
                ...  Create XRS Web Services Session
                ...  AND  Test Data Setup For XRS Organization Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      xrsrestwebservicevalidation  xrsorganizationrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate XRS Get Organization By SID REST Web Services Response Returns 200 OK With Parent Organization SID
  [Documentation]  Verifies that a Organization with a specific number does not exist
  ${response} =  Get Organization By OrganizationSID  ${XRS_GENERAL_INFORMATION.Company.ParentOrganizationSid}
  Request Should Be Successful  ${response}

Validate XRS Post Organization REST Web Services Response Returns Caption "Request succeeded."
  [Documentation]  Posts a Organization and expects a Caption value "Request succeeded."
  ${response} =  Post Organizations  @{XRS_WEBSERVICE_POST_TEST_ORGANIZATION_LIST}
  &{expected_values} =  Create Dictionary  key=Caption  value=Request succeeded.
  Parse ${response} And Verify ${expected_values.key} With ${expected_values.value} And Get Organization SID Test Data
  Create Organization Paramters From Post Organization Test

Validate XRS Get Organization By SID REST Web Services Returns 200 OK With New Organization
  [Documentation]  Verifies that a posted Organization now exists
  ${response} =  Get Organization By OrganizationSID  ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}
  Request Should Be Successful  ${response}

Validate XRS Put Organization REST Web Services Response Description Returns "Organization Edited Successfully."
  [Documentation]  Posts a Organization and expects a Code value of 201
  ${response} =  Put Organizations  @{XRS_WEBSERVICE_PUT_TEST_ORGANIZATION_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Organization Edited Successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate XRS Get Organizations By Parameters REST Web Services Response Returns 200 OK
  [Documentation]  Get Organizations with basic parameters
  ${wo_slash_response} =  Get Organizations Response With Forward Slash  &{XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS}
  ${w_slash_response} =  Get Organizations Response Without Forward Slash  &{XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Organizations By Parameters REST Web Services Reponse Returns 200 OK With Raw String URI
  [Documentation]  Get Organizations with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Organizations Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Organizations Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}
  Request Should Be Successful  ${w_question_response}

Validate XRS Get Organizations By ID REST Web Services Reponse Returns 200 OK
  [Documentation]  Get organization by ID returns 200 OK
  ${response} =  Get Organizations By ID  ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT.OrganizationId}
  Request Should Be Successful  ${response}

Validate XRS Get Organizations REST Web Services For All Organizations Response Returns 200 OK
  [Documentation]  Gets all the Organizations
  [Tags]  xrsawsperftest
  ${response} =  Get All Organizations
  Request Should Be Successful  ${response}

# Organizations Performance (settings) Data Tests
Validate XRS Get Organizations Performance (settings) Data By SID REST Web Services Response Returns 200 OK
  [Documentation]  Get organization performance endpoint by ID returns 200 OK
  ${response} =  Get Organizations Performance Data By ID  ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT.OrganizationId}
  Request Should Be Successful  ${response}

Validate XRS Put Organization Performance (settings) Data By SID REST Web Services Update Response Return 200 OK
  [Documentation]  Sends an performance settings update request from a json file, expects a 200 response
  ${json_data} =  Load JSON From File  ${CURDIR}/EntityManagementTestData/organization_performance_minimum_setting.json
  ${response} =  Put Organizations Performance Data By ID  ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT.OrganizationId}  ${json_data}
  Request Should Be Successful  ${response}

Validate XRS Get Organizations Performance (settings) Data By Parameters REST Web Services Response Returns 200 OK
  [Documentation]  Get Organizations with basic parameters
  ${wo_slash_response} =  Get Organizations Performance (settings) Data Response With Forward Slash  &{XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS}
  ${w_slash_response} =  Get Organizations Performance (settings) Data Response Without Forward Slash  &{XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Organizations Performance (settings) Data By Parameters REST Web Services Response Returns 200 OK With Raw String URI
  [Documentation]  Get Organizations with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Organizations Performance (settings) Data Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Organizations Performance (settings) Data Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}
  Request Should Be Successful  ${w_question_response}

*** Keywords ***
Test Data Setup For XRS Organization Web Service Test Suite
  [Documentation]  Keyword for setting up a random organization for the organization test suite
  ${FAKE_WORD1} =  FakerLibrary.Word
  ${FAKE_WORD2} =  FakerLibrary.Word
  ${FAKE_TEST_ORGANIZATION_ID_1} =  Set Variable  ${FAKE_WORD1}${FAKE_WORD2}
  ${FAKE_TEST_ORGANIZATION_NAME_1} =  Set Variable  ${FAKE_WORD1}${SPACE}${FAKE_WORD2}
  # Create post test organization 1 data.
  &{XRS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT} =  Create Dictionary
  ...  CarrierName=${XRS_GENERAL_INFORMATION.Address.Carrier_Name}
  ...  Country=${XRS_GENERAL_INFORMATION.Address.Country}
  ...  DotNumber=${XRS_GENERAL_INFORMATION.Address.DOT_Number}
  ...  Language=${XRS_GENERAL_INFORMATION.Localization.Language}
  ...  OrganizationId=${FAKE_TEST_ORGANIZATION_ID_1}
  ...  OrganizationName=${FAKE_TEST_ORGANIZATION_NAME_1}
  ...  ParentOrganizationId=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  ParentOrganizationSid=${XRS_GENERAL_INFORMATION.Company.ParentOrganizationSid}
  ...  TimeZone=CST
  @{XRS_WEBSERVICE_POST_TEST_ORGANIZATION_LIST} =  Create List  ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT}
  Set Suite Variable  ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_POST_TEST_ORGANIZATION_LIST}
  # Create put test organization 1 data.
  &{XRS_WEBSERVICE_PUT_TEST_ORGANIZATION_1_DICT} =  Create Dictionary
  ...  Language=${XRS_GENERAL_INFORMATION.Localization.Language}
  ...  OrganizationId=${FAKE_TEST_ORGANIZATION_ID_1}
  ...  OrganizationName=${FAKE_TEST_ORGANIZATION_NAME_1}Modified
  ...  ParentOrganizationId=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  @{XRS_WEBSERVICE_PUT_TEST_ORGANIZATION_LIST} =  Create List  ${XRS_WEBSERVICE_PUT_TEST_ORGANIZATION_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_PUT_TEST_ORGANIZATION_LIST}

Create Organization Paramters From Post Organization Test
  [Documentation]  Uses the ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_SID} Variable to create test params
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationSid=${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS}
  # Create test params string
  ${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationSid=${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}
  ...  IsActive=${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_WEBSERVICE_ORGANIZATION_TEST_PARAMS_STRING}

Parse ${response} And Verify ${key} With ${value} And Get Organization SID Test Data
  [Documentation]  Takes a reponse and expects to find the expected key and value
  ...  It also gets the value of the Organization SID and stores it for later tests
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    ${get_caption_value} =  Get From Dictionary  ${r}  ${key}
    Should Be Equal As Strings  ${get_caption_value}  ${value}
    ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_SID} =  Get From Dictionary  ${r}  SID
  END
  Set Suite Variable  ${XRS_WEBSERVICE_POST_TEST_ORGANIZATION_SID}
