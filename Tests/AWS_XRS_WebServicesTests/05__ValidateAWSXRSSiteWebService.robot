*** Settings ***
Documentation   Fundamental suite to test XRS AWS Site Entity Management Web Services
Resource        ../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../Resources/XRS_WebServices/EntityManagement/Site.resource
Resource        ../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ./TestSiteData.yaml
Variables       ../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Site Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrssiterestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Site REST Web Services Returns Geographic "Site identity does not exist." Error Message
  [Documentation]  Verifies that a Site with a specific number does not exist
  ${response} =  Get Sites By Site Id  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[ErrorMessage]  Geographic Site identity does not exist.

Validate AWS XRS Post Site REST Web Services Returns Description "Geographic Site added successfully."
  [Documentation]  Posts a Site and expects a Code value of 201
  ${response} =  Post Sites  @{XRS_AWS_WEBSERVICE_POST_TEST_SITE_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Geographic Site added successfully.
  END

Validate AWS XRS Get Site REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted Site now exists
  ${response} =  Get Sites By Site Id  ${XRS_WEB_SERVICES_TEST_SITE.SiteID}
  Should Be Equal As Strings  ${response.status_code}  200
  ${json_response} =  To Json  ${response.content}
  ${XRS_WEB_SERVICES_TEST_SITE_SID} =  Set Variable  ${json_response}[SiteID]
  Set Global Variable  ${XRS_WEB_SERVICES_TEST_SITE_SID}

Validate AWS XRS Put Site REST Web Services Modifies Site Successfully
  [Documentation]  Posts a Site and expects a Code value of 201
  ${response} =  Put Sites  @{XRS_AWS_WEBSERVICE_PUT_TEST_SITE_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Geographic Site edited successfully.
  END

Validate AWS XRS Get Sites REST Web Services Returns 200 OK
  [Documentation]  Get Sites with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Sites With Forward Slash Returns 200 OK  &{params}
  Verify Get Sites Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Sites REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Sites with basic parameters using a raw URI string
  Verify Get Sites Raw String URI With /? Returns 200 OK
  Verify Get Sites Raw String URI With ? Returns 200 OK

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

Verify Get Sites Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Sites  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Sites With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Sites With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Sites Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Site}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
