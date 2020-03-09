*** Settings ***
Documentation   Fundamental suite to test XRS Site Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Site.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Variables       ./EntityManagementTestData/TestSiteData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create REST API Session
                ...  AND  Test Data Setup For XRS Site Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      xrsrestwebservicevalidation  xrssiterestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate XRS Get Site REST Web Services Response ErrorMessage Returns "Geographic Site identity does not exist."
  [Documentation]  Verifies that a Site with a specific number does not exist
  ${response} =  Get Sites By Site Id  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  &{expected_value} =  Create Dictionary  key=ErrorMessage  value=Geographic Site identity does not exist.
  ${actual_value} =  Get Value From Response With Key  ${expected_value.key}  ${response}
  Should Be Equal As Strings  ${actual_value}  ${expected_value.value}

Validate XRS Post Site REST Web Services Response Returns Description "Geographic Site added successfully."
  [Documentation]  Posts a Site and expects decription return value
  ${response} =  Post Sites  @{XRS_WEBSERVICE_POST_TEST_SITE_LIST}
  &{expected_value} =  Create Dictionary  key=Description  value=Geographic Site added successfully.
  Verify Response List ${response} Has Key ${expected_value.key} And Contains Value ${expected_value.value}

Validate XRS Get Site REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that a posted Site now exists
  ${response} =  Get Sites By Site Id  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  Request Should Be Successful  ${response}
  # Set a global veriable for delete site test
  ${XRS_WEB_SERVICES_TEST_SITE_SID} =  Get Value From Response With Key  SiteID  ${response}
  Set Suite Variable  ${XRS_WEB_SERVICES_TEST_SITE_SID}

Validate XRS Put Site REST Web Services Response Description Returns "Geographic Site edited successfully."
  [Documentation]  Posts a Site and expects a Code value of 201
  ${response} =  Put Sites  @{XRS_WEBSERVICE_PUT_TEST_SITE_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Geographic Site edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate XRS Get Sites REST Web Services Response Returns 200 OK
  [Documentation]  Get Sites with basic parameters
  ${w_slash_response} =  Get Sites Response With Forward Slash  &{XRS_WEBSERVICE_SITE_TEST_PARAMS}
  ${wo_slash_response} =  Get Sites Response Without Forward Slash  &{XRS_WEBSERVICE_SITE_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}
  Request Should Be Successful  ${wo_slash_response}

Validate XRS Get Sites REST Web Services Response Returns 200 OK With Raw String URI
  [Documentation]  Get Sites with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Sites Raw String URI Response With /? And Parameters ${XRS_WEBSERVICE_SITE_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Sites Raw String URI Response With ? And Parameters ${XRS_WEBSERVICE_SITE_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}
  Request Should Be Successful  ${w_question_response}

Validate XRS Delete Site REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that created Site is deleted
  ${response} =  Delete Sites By Site ID  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  Request Should Be Successful  ${response}

Validate XRS Get Sites REST Web Services For All Sites Response Returns 200 OK
  [Documentation]  Gets all the Sites
  [Tags]  xrsawsperftest
  ${response} =  Get All Sites
  Request Should Be Successful  ${response}

Validate XRS Delete Sites REST Web Services Response Returns Code 401
  [Documentation]  Attempts to delete a previously deleted Site.
  ${response} =  Delete Sites By Site ID  ${XRS_WEB_SERVICES_TEST_SITE_SID}
  &{expected_value} =  Create Dictionary  key=Code  value=401
  ${actual_value} =  Get Value From Response With Key  ${expected_value.key}  ${response}
  Should Be Equal As Strings  ${actual_value}  ${expected_value.value}

*** Keywords ***
Test Data Setup For XRS Site Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for Site Web Service Tests.
  # Create post test Site 1 data.
  &{XRS_WEBSERVICE_POST_TEST_SITE_1_DICT} =  Create Dictionary
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
  @{XRS_WEBSERVICE_POST_TEST_SITE_LIST} =  Create List  ${XRS_WEBSERVICE_POST_TEST_SITE_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_POST_TEST_Site_LIST}
  # Create put test Site 1 data.
  &{XRS_WEBSERVICE_PUT_TEST_Site_1_DICT} =  Create Dictionary
  ...  ArrivalRadius=${XRS_WEB_SERVICES_TEST_SITE.ArrivalRadius}
  ...  City=${XRS_WEB_SERVICES_TEST_SITE.City}
  ...  Country=${XRS_WEB_SERVICES_TEST_SITE.Country}
  ...  DepartureRadius=${XRS_WEB_SERVICES_TEST_SITE.DepartureRadius}
  ...  Name=${XRS_WEB_SERVICES_TEST_SITE.Name}Modified
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  SiteID=${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  ...  StateName=${XRS_WEB_SERVICES_TEST_SITE.StateName}
  ...  TimeZone=${XRS_WEB_SERVICES_TEST_SITE.TimeZone}
  @{XRS_WEBSERVICE_PUT_TEST_SITE_LIST} =  Create List  ${XRS_WEBSERVICE_PUT_TEST_SITE_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_PUT_TEST_SITE_LIST}
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_WEBSERVICE_SITE_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_WEBSERVICE_SITE_TEST_PARAMS}
  # Create test params string
  ${XRS_WEBSERVICE_SITE_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_WEBSERVICE_SITE_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_WEBSERVICE_SITE_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_WEBSERVICE_SITE_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_WEBSERVICE_SITE_TEST_PARAMS_STRING}
