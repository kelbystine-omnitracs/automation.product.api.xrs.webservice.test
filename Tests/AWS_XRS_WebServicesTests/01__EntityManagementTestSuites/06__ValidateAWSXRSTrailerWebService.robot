*** Settings ***
Documentation   Fundamental suite to test XRS AWS Trailer Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Trailer.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Variables       ./EntityManagementTestData/TestTrailerData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Trailer Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrstrailerrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Trailer REST Web Services Returns 400 Error
  [Documentation]  Verifies that a trailer with a specific number does not exist
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  400

Validate AWS XRS Post Trailer REST Web Services Returns Code 201
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Post Trailers  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Trailer REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted trailer now exists
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Trailer REST Web Services Modifies Driver Successfully
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Put Trailers  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Trailer edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Trailers REST Web Services Returns 200 OK
  [Documentation]  Get trailers with basic parameters
  ${wo_slash_response} =  Get Trailers Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS}
  ${w_slash_response} =  Get Trailers Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Trailers REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get trailers with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Trailers Raw String URI Response Code With /? And Parameters ${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Trailers Raw String URI Response Code With ? And Parameters ${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

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
  &{expected_values} =  Create Dictionary  key=Description  value=Trailer not exist.
  ${actual_value} =  Get Value From Response With Key  ${expected_values.key}  ${response}
  Should Be Equal As Strings  ${actual_value}  ${expected_values.value}

# V2 Trailer Web servicesValidate AWS XRS Get Trailer REST Web Services Returns 400 Error
Validate AWS XRS Get Trailer V2 REST Web Services Returns 400 Error
  [Documentation]  Verifies that a trailer with a specific number does not exist
  ${response} =  Get Trailer V2 By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  400

Validate AWS XRS Post Trailer V2 REST Web Services Returns Code 201
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Post Trailers V2  @{XRS_AWS_WEBSERVICE_POST_TEST_TRAILER_LIST_V2}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Trailer V2 REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted trailer now exists
  ${response} =  Get Trailer By ID  ${XRS_WEB_SERVICES_TEST_TRAILER_V2.TrailerIdentity}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Trailer V2 REST Web Services Modifies Driver Successfully
  [Documentation]  Posts a trailer and expects a Code value of 201
  ${response} =  Put Trailers V2  @{XRS_AWS_WEBSERVICE_PUT_TEST_TRAILER_LIST_V2}
  &{expected_values} =  Create Dictionary  key=Description  value=Trailer edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Trailers V2 REST Web Services Returns 200 OK
  [Documentation]  Get trailers with basic parameters
  ${wo_slash_response} =  Get Trailers V2 Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS}
  ${w_slash_response} =  Get Trailers V2 Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Trailers V2 REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get trailers with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Trailers V2 Raw String URI Response Code With /? And Parameters ${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Trailers V2 Raw String URI Response Code With ? And Parameters ${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

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
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_TRAILER_TEST_PARAMS_STRING}