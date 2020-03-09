*** Settings ***
Documentation   Fundamental suite to test XRS Trailer Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Trailer.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Variables       ./EntityManagementTestData/TestTrailerData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create REST API Session
                ...  AND  Test Data Setup For XRS Trailer Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      xrsrestwebservicevalidation  xrstrailerrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate XRS Get Trailer REST Web Services Response Returns 400 Error
  [Documentation]  Verifies that a trailer with a specific number does not exist
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Status Should Be  400  ${response}

Validate XRS Post Trailer REST Web Services Response Returns Code 201
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Post Trailers  @{XRS_WEBSERVICE_POST_TEST_TRAILER_LIST}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate XRS Get Trailer REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that a posted trailer now exists
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Request Should Be Successful  ${response}

Validate XRS Put Trailer REST Web Services Response Description Returns "Trailer edited successfully."
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Put Trailers  @{XRS_WEBSERVICE_PUT_TEST_TRAILER_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Trailer edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate XRS Get Trailers With Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get trailers with basic parameters
  ${w_slash_response} =  Get Trailers Response With Forward Slash  &{XRS_WEBSERVICE_TRAILER_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Trailers Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get trailers with basic parameters
  ${wo_slash_response} =  Get Trailers Response Without Forward Slash  &{XRS_WEBSERVICE_TRAILER_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Trailers With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Documentation]  Get trailers with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Trailers Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Trailers With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get trailers with basic parameters using a raw URI string
  ${w_question_response} =  Get Trailers Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_question_response}

Validate XRS Delete Trailer REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that created trailer is deleted
  ${response} =  Delete Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Request Should Be Successful  ${response}

Validate XRS Get Trailers REST Web Services For All Trailers Response Returns 200 OK
  [Documentation]  Gets all the trailers
  [Tags]  xrsawsperftest
  ${response} =  Get All Trailers
  Request Should Be Successful  ${response}

Validate XRS Delete Trailers REST Web Services Response Description Returns "Trailer not exist."
  [Documentation]  Attempts to delete a previously deleted trailer.
  ${response} =  Delete Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  &{expected_values} =  Create Dictionary  key=Description  value=Trailer not exist.
  ${actual_value} =  Get Value From Response With Key  ${expected_values.key}  ${response}
  Should Be Equal As Strings  ${actual_value}  ${expected_values.value}

# V2 Trailer Web servicesValidate XRS Get Trailer REST Web Services Returns 400 Error
Validate XRS Get Trailer V2 REST Web Services Response Returns 400 Error
  [Documentation]  Verifies that a trailer v2 with a specific number does not exist
  ${response} =  Get Trailer V2 By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Status Should Be  400  ${response}

Validate XRS Post Trailer V2 REST Web Services Response Returns Code 201
  [Documentation]  Posts a trailer v2 and expects a Code value of 201
  ${response} =  Post Trailers V2  @{XRS_WEBSERVICE_POST_TEST_TRAILER_LIST_V2}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate XRS Get Trailer V2 REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted trailer v2 now exists
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Request Should Be Successful  ${response}

Validate XRS Put Trailer V2 REST Web Services Response Description Returns "Trailer edited successfully."
  [Documentation]  Posts a trailer v2 and expects a Code value of 201
  ${response} =  Put Trailers V2  @{XRS_WEBSERVICE_PUT_TEST_TRAILER_LIST_V2}
  &{expected_values} =  Create Dictionary  key=Description  value=Trailer edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate XRS Get Trailers V2 With Forward Slash REST Web Services Returns 200 OK
  [Documentation]  Get trailers v2 with basic parameters
  ${w_slash_response} =  Get Trailers V2 Response With Forward Slash  &{XRS_WEBSERVICE_TRAILER_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}

Validate XRS Get Trailers V2 Without Forward Slash REST Web Services Returns 200 OK
  [Documentation]  Get trailers v2 with basic parameters
  ${wo_slash_response} =  Get Trailers V2 Response Without Forward Slash  &{XRS_WEBSERVICE_TRAILER_TEST_PARAMS}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Trailers V2 With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Documentation]  Get trailers v2 with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Trailers V2 Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}

Validate XRS Get Trailers V2 With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get trailers v2 with basic parameters using a raw URI string
  ${w_question_response} =  Get Trailers V2 Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_question_response}

Validate XRS Delete Trailer V2 REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that created trailer v2 is deleted
  ${response} =  Delete Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Request Should Be Successful  ${response}

Validate XRS Get Trailers V2 REST Web Services For All Trailers Response Returns 200 OK
  [Documentation]  Gets all the trailers v2
  [Tags]  xrsawsperftest
  ${response} =  Get All Trailers V2
  Request Should Be Successful  ${response}

*** Keywords ***
Test Data Setup For XRS Trailer Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for Trailer Web Service Tests.
  # Create post test Site 1 data.
  &{XRS_WEBSERVICE_POST_TEST_TRAILER_1_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  @{XRS_WEBSERVICE_POST_TEST_TRAILER_LIST} =  Create List  ${XRS_WEBSERVICE_POST_TEST_TRAILER_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_POST_TEST_TRAILER_LIST}
  # Create put test Site 1 data.
  &{XRS_WEBSERVICE_PUT_TEST_TRAILER_1_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  @{XRS_WEBSERVICE_PUT_TEST_TRAILER_LIST} =  Create List  ${XRS_WEBSERVICE_PUT_TEST_TRAILER_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_PUT_TEST_TRAILER_LIST}
  # Create post test V2 Site 1 data.
  &{XRS_WEBSERVICE_POST_TEST_TRAILER_1_V2_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER_V2.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  ...  Country=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Country}
  @{XRS_WEBSERVICE_POST_TEST_TRAILER_LIST_V2} =  Create List  ${XRS_WEBSERVICE_POST_TEST_TRAILER_1_V2_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_POST_TEST_TRAILER_LIST_V2}
  # Create put test V2 Site 1 data.
  &{XRS_WEBSERVICE_PUT_TEST_TRAILER_1_V2_DICT} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_TRAILER_V2.StateName}
  ...  Status=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Status}
  ...  TrailerIdentity=${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  ...  Country=${XRS_WEB_SERVICES_TEST_TRAILER_V2.Country}
  @{XRS_WEBSERVICE_PUT_TEST_TRAILER_LIST_V2} =  Create List  ${XRS_WEBSERVICE_PUT_TEST_TRAILER_1_V2_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_PUT_TEST_TRAILER_LIST_V2}
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_WEBSERVICE_TRAILER_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_WEBSERVICE_TRAILER_TEST_PARAMS}
  # Create test params string
  ${XRS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_WEBSERVICE_TRAILER_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_WEBSERVICE_TRAILER_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_WEBSERVICE_TRAILER_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}