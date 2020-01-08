*** Settings ***
Documentation   Fundamental suite to test XRS AWS Device Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Device.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables       ./EntityManagementTestData/TestDeviceData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Device Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsdevicerestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Device REST Web Services Returns 400 Error
  [Documentation]  Verifies that a device with a specific number does not exist
  ${response} =  Get Device By Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Should Be Equal As Strings  ${response.status_code}  400

Validate AWS XRS Post Device REST Web Services Returns Code 201
  [Documentation]  Posts a device and expects a Code value of 201
  ${response} =  Post Devices  @{XRS_AWS_WEBSERVICE_POST_TEST_DEVICE_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Code]  201
  END

Validate AWS XRS Get Device REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted device now exists
  ${response} =  Get Device By Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Device REST Web Services Modifies Description Successfully
  [Documentation]  Posts a device and expects a Code value of 201
  ${response} =  Put Devices  @{XRS_AWS_WEBSERVICE_PUT_TEST_DEVICE_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Device edited successfully.
  END

Validate AWS XRS Get Devices REST Web Services Returns 200 OK
  [Documentation]  Get devices with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Devices With Forward Slash Returns 200 OK  &{params}
  Verify Get Devices Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Devices REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get devices with basic parameters using a raw URI string
  Verify Get Devices Raw String URI With /? Returns 200 OK
  Verify Get Devices Raw String URI With ? Returns 200 OK

Validate AWS XRS Get Devices REST Web Services For All Devices Returns 200 OK
  [Documentation]  Gets all the Devices
  [Tags]  xrsawsperftest
  ${response} =  Get All Devices
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Delete Device REST Web Services Returns 200 OK
  [Documentation]  Verifies that created device is deleted
  ${response} =  Delete Device By Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Verify Get Devices Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Devices  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Devices With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Devices With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Devices Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Device}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200

Test Data Setup For XRS AWS Device Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Device Web Service Tests.
  # Create post test device 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_DEVICE_1_DICT} =  Create Dictionary
  ...  CarrierDisplayName=${XRS_WEB_SERVICES_TEST_DEVICE_1.CarrierDisplayName}
  ...  Description=${XRS_WEB_SERVICES_TEST_DEVICE_1.Description}
  ...  DeviceType=${XRS_WEB_SERVICES_TEST_DEVICE_1.DeviceType}
  ...  FixedDisplay=${XRS_WEB_SERVICES_TEST_DEVICE_1.FixedDisplay}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  PhoneNumber=${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  ...  SendInstallLink=${XRS_WEB_SERVICES_TEST_DEVICE_1.SendInstallLink}
  ...  Status=${XRS_WEB_SERVICES_TEST_DEVICE_1.Status}
  @{XRS_AWS_WEBSERVICE_POST_TEST_DEVICE_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_DEVICE_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_DEVICE_LIST}
  # Create put test device 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_DEVICE_1_DICT} =  Create Dictionary
  ...  CarrierDisplayName=${XRS_WEB_SERVICES_TEST_DEVICE_1.CarrierDisplayName}
  ...  Description=This has changed.
  ...  DeviceType=${XRS_WEB_SERVICES_TEST_DEVICE_1.DeviceType}
  ...  FixedDisplay=${XRS_WEB_SERVICES_TEST_DEVICE_1.FixedDisplay}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  PhoneNumber=${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  ...  SendInstallLink=${XRS_WEB_SERVICES_TEST_DEVICE_1.SendInstallLink}
  ...  Status=${XRS_WEB_SERVICES_TEST_DEVICE_1.Status}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_DEVICE_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_DEVICE_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_DEVICE_LIST}