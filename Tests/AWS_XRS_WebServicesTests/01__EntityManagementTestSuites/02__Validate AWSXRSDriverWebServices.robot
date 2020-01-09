*** Settings ***
Documentation   Fundamental suite to test XRS AWS Driver Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Driver.resource
Variables       ./EntityManagementTestData/TestDriverData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Driver Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsdriverrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Driver REST Web Services Returns 400 Error
  [Documentation]  Verifies that a driver with a specific number does not exist
  ${response} =  Get Driver By ID  ${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}
  Should Be Equal As Strings  ${response.status_code}  400

Validate AWS XRS Post Driver REST Web Services Returns Code 201
  [Documentation]  Posts a driver and expects a Code value of 201
  ${response} =  Post Drivers  @{XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Code]  201
  END

Validate AWS XRS Get Driver REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted driver now exists
  ${response} =  Get Driver By ID  ${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}
  Should Be Equal As Strings  ${response.status_code}  200
  ${json_response} =  To Json  ${response.content}
  ${XRS_WEB_SERVICES_TEST_DRIVER_1_SID} =  Set Variable  ${json_response}[SID]
  Set Global Variable  ${XRS_WEB_SERVICES_TEST_DRIVER_1_SID}

Validate AWS XRS Put Driver REST Web Services Modifies Driver Successfully
  [Documentation]  Posts a driver and expects a Code value of 201
  ${response} =  Put Drivers  @{XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Driver edited successfully.
  END

Validate AWS XRS Get Drivers REST Web Services Returns 200 OK
  [Documentation]  Get drivers with basic parameters
  ${wo_slash_response} =  Get Drivers Response Code With Forward Slash  &{XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS}
  ${w_slash_response} =  Get Drivers Response Code Without Forward Slash  &{XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Drivers REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get drivers with basic parameters using a raw URI string
  ${params_string} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS.AsOfDateTime}
  ${w_slash_question_response} =  Get Drivers Raw String URI Response Code With /? And Parameters ${params_string}
  ${w_question_response} =  Get Drivers Raw String URI Response Code With ? And Parameters ${params_string}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Delete Driver REST Web Services Returns 200 OK
  [Documentation]  Verifies that created driver is deleted
  ${response} =  Delete Driver By ID  ${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Drivers REST Web Services For All Drivers Returns 200 OK
  [Documentation]  Gets all the drivers
  [Tags]  xrsawsperftest
  ${response} =  Get All Drivers
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Delete Drivers REST Web Services Returns Error Message
  [Documentation]  Attempts to delete a previously deleted driver.
  ${response} =  Delete Drivers By IDs  ${XRS_WEB_SERVICES_TEST_DRIVER_1_SID}
  ${expected_error_message} =  Set Variable  Driver ${XRS_WEB_SERVICES_TEST_DRIVER_1_SID} doesn't exist.
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[ErrorMessage]  ${expected_error_message}

*** Keywords ***
Test Data Setup For XRS AWS Driver Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Driver Web Service Tests.
  # Create post test driver 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_1_DICT} =  Create Dictionary
  ...  CDLNumber=${XRS_WEB_SERVICES_TEST_DRIVER_1.CDLNumber}
  ...  DriverID=${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}
  ...  DefaultHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.DefaultHOSRule}
  ...  ELDExempt=${XRS_WEB_SERVICES_TEST_DRIVER_1.ELDExempt}
  ...  EnableBigDay=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableBigDay}
  ...  EnableDriverPortal=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableDriverPortal}
  ...  EnableHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableHOSRule}
  ...  EnablePersonalConveyance=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnablePersonalConveyance}
  ...  EnableTimeClock=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableTimeClock}
  ...  EnableYardMove=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableYardMove}
  ...  FirstName=${XRS_WEB_SERVICES_TEST_DRIVER_1.FirstName}
  ...  Language=${XRS_WEB_SERVICES_TEST_DRIVER_1.Language}
  ...  LastName=${XRS_WEB_SERVICES_TEST_DRIVER_1.LastName}
  ...  LicenseIssuingCountry=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingCountry}
  ...  LicenseIssuingStateProvince=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingStateProvince}
  ...  MiddleName=${XRS_WEB_SERVICES_TEST_DRIVER_1.MiddleName}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  OrganizationSID=${XRS_WEB_SERVICES_TEST_DRIVER_1.OrganizationSID}
  ...  Password=${XRS_WEB_SERVICES_TEST_DRIVER_1.Password}
  ...  SendInboundMessageTo=${XRS_WEB_SERVICES_TEST_DRIVER_1.SendInboundMessageTo}
  ...  SID=${XRS_WEB_SERVICES_TEST_DRIVER_1.SID}
  ...  Status=${XRS_WEB_SERVICES_TEST_DRIVER_1.Status}
  ...  UseHOSOrganizationSettings=${XRS_WEB_SERVICES_TEST_DRIVER_1.UseHOSOrganizationSettings}
  ...  UserName=${XRS_WEB_SERVICES_TEST_DRIVER_1.UserName}
  @{XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_LIST}
  # Create put test driver 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_1_DICT} =  Create Dictionary
  ...  DriverID=${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}
  ...  DefaultHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.DefaultHOSRule}
  ...  ELDExempt=${XRS_WEB_SERVICES_TEST_DRIVER_1.ELDExempt}
  ...  EnableBigDay=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableBigDay}
  ...  EnableDriverPortal=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableDriverPortal}
  ...  EnableHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableHOSRule}
  ...  EnablePersonalConveyance=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnablePersonalConveyance}
  ...  EnableTimeClock=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableTimeClock}
  ...  EnableYardMove=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableYardMove}
  ...  FirstName=${XRS_WEB_SERVICES_TEST_DRIVER_1.FirstName}
  ...  Language=${XRS_WEB_SERVICES_TEST_DRIVER_1.Language}
  ...  LastName=${XRS_WEB_SERVICES_TEST_DRIVER_1.LastName}
  ...  LicenseIssuingCountry=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingCountry}
  ...  LicenseIssuingStateProvince=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingStateProvince}
  ...  MiddleName=This has been changed.
  ...  OrganizationSID=${XRS_WEB_SERVICES_TEST_DRIVER_1.OrganizationSID}
  ...  SendInboundMessageTo=${XRS_WEB_SERVICES_TEST_DRIVER_1.SendInboundMessageTo}
  ...  SID=${XRS_WEB_SERVICES_TEST_DRIVER_1.SID}
  ...  Status=${XRS_WEB_SERVICES_TEST_DRIVER_1.Status}
  ...  UseHOSOrganizationSettings=${XRS_WEB_SERVICES_TEST_DRIVER_1.UseHOSOrganizationSettings}
  ...  UserName=${XRS_WEB_SERVICES_TEST_DRIVER_1.UserName}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_LIST}
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS}