*** Settings ***
Documentation   Fundamental suite to test XRS AWS Site Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Site.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Variables       ./EntityManagementTestData/TestSiteData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Site Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrssiterestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Site REST Web Services Returns Geographic "Site identity does not exist." Error Message
  [Documentation]  Verifies that a Site with a specific number does not exist
  ${response} =  Get Sites By Site Id  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[ErrorMessage]  Geographic Site identity does not exist.

Validate AWS XRS Post Site REST Web Services Returns Description "Geographic Site added successfully."
  [Documentation]  Posts a Site and expects a Code value of 201
  ${response} =  Post Sites  @{XRS_AWS_WEBSERVICE_POST_TEST_SITE_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Geographic Site added successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Site REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted Site now exists
  ${response} =  Get Sites By Site Id  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  Should Be Equal As Strings  ${response.status_code}  200
  # Set a global veriable for delete site test
  ${XRS_WEB_SERVICES_TEST_SITE_SID} =  Get Value From Response With Key  ${response}  SiteID
  Set Global Variable  ${XRS_WEB_SERVICES_TEST_SITE_SID}

Validate AWS XRS Put Site REST Web Services Modifies Site Successfully
  [Documentation]  Posts a Site and expects a Code value of 201
  ${response} =  Put Sites  @{XRS_AWS_WEBSERVICE_PUT_TEST_SITE_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Geographic Site edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Sites REST Web Services Returns 200 OK
  [Documentation]  Get Sites with basic parameters
  ${wo_slash_response} =  Get Sites Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS}
  ${w_slash_response} =  Get Sites Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Sites REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Sites with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Sites Raw String URI Response Code With /? And Parameters ${XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Sites Raw String URI Response Code With ? And Parameters ${XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Delete Site REST Web Services Returns 200 OK
  [Documentation]  Verifies that created Site is deleted
  ${response} =  Delete Sites By Site ID  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Sites REST Web Services For All Sites Returns 200 OK
  [Documentation]  Gets all the Sites
  [Tags]  xrsawsperftest
  ${response} =  Get All Sites
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Delete Sites REST Web Services Returns Code 401
  [Documentation]  Attempts to delete a previously deleted Site.
  ${response} =  Delete Sites By Site ID  ${XRS_WEB_SERVICES_TEST_SITE_SID}
  ${expected_error_message} =  Set Variable  Site ${XRS_WEB_SERVICES_TEST_SITE_SID} doesn't exist.
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[Code]  401

*** Keywords ***
Test Data Setup For XRS AWS Site Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Site Web Service Tests.
  # Create post test Site 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_SITE_1_DICT} =  Create Dictionary
  ...  ArrivalGeoCodeType=${XRS_WEB_SERVICES_TEST_SITE.ArrivalGeoCodeType}
  ...  ArrivalRadius=${XRS_WEB_SERVICES_TEST_SITE.ArrivalRadius}
  ...  City=${XRS_WEB_SERVICES_TEST_SITE.City}
  ...  Country=${XRS_WEB_SERVICES_TEST_SITE.Country}
  ...  DepartureGeoCodeType=${XRS_WEB_SERVICES_TEST_SITE.DepartureGeoCodeType}
  ...  DepartureRadius=${XRS_WEB_SERVICES_TEST_SITE.DepartureRadius}
  ...  DepartureSameAsArrival=${XRS_WEB_SERVICES_TEST_SITE.DepartureSameAsArrival}
  ...  Measure=${XRS_WEB_SERVICES_TEST_SITE.Measure}
  ...  Name=${XRS_WEB_SERVICES_TEST_SITE.Name}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  OrganizationName=${XRS_GENERAL_INFORMATION.Company.Company_Name}
  ...  SiteID=${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  ...  SiteType=${XRS_WEB_SERVICES_TEST_SITE.SiteType}
  ...  StateName=${XRS_WEB_SERVICES_TEST_SITE.StateName}
  ...  TimeZone=${XRS_WEB_SERVICES_TEST_SITE.TimeZone}
  @{XRS_AWS_WEBSERVICE_POST_TEST_SITE_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_SITE_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_Site_LIST}
  # Create put test Site 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_Site_1_DICT} =  Create Dictionary
  ...  ArrivalRadius=${XRS_WEB_SERVICES_TEST_SITE.ArrivalRadius}
  ...  City=${XRS_WEB_SERVICES_TEST_SITE.City}
  ...  Country=${XRS_WEB_SERVICES_TEST_SITE.Country}
  ...  DepartureRadius=${XRS_WEB_SERVICES_TEST_SITE.DepartureRadius}
  ...  Name=${XRS_WEB_SERVICES_TEST_SITE.Name}Modified
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  SiteID=${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_SITE.StateName}
  ...  TimeZone=${XRS_WEB_SERVICES_TEST_SITE.TimeZone}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_SITE_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_SITE_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_SITE_LIST}
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_SITE_TEST_PARAMS_STRING}
