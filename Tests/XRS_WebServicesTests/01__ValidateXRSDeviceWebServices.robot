*** Settings ***
Documentation   Fundamental suite to test XRS AWS Device Entity Management Web Services
Resource        ../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../Resources/XRS_WebServices/EntityManagement/Device.resource
Variables       ./TestDeviceData.yaml
Variables       ../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml

Suite Setup     Create XRS Web Services Session
Suite Teardown  Delete All Sessions
Force Tags      xrsdevicerestwebservicevalidation

*** Variables ***
${XRS_HOST_ENVIRONMENT} =  d3
&{XRS_WEBSERVICE_POST_TEST_DEVICE_1_DICT} =
...  CarrierDisplayName=${XRS_WEB_SERVICES_TEST_DEVICE_1.CarrierDisplayName}
...  Description=${XRS_WEB_SERVICES_TEST_DEVICE_1.Description}
...  DeviceType=${XRS_WEB_SERVICES_TEST_DEVICE_1.DeviceType}
...  FixedDisplay=${XRS_WEB_SERVICES_TEST_DEVICE_1.FixedDisplay}
...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
...  PhoneNumber=${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
...  SendInstallLink=${XRS_WEB_SERVICES_TEST_DEVICE_1.SendInstallLink}
...  Status=${XRS_WEB_SERVICES_TEST_DEVICE_1.Status}
@{XRS_WEBSERVICE_POST_TEST_DEVICE_LIST} =  ${XRS_WEBSERVICE_POST_TEST_DEVICE_1_DICT}

*** Test Cases ***
Validate XRS Get Device REST Web Services Returns 400 Error
  [Documentation]  Verifies that a device with a specific number does not exist
  ${response} =  Get Device With Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Should Be Equal As Strings  ${response.status_code}  400

Validate XRS Post Device REST Web Services Returns Code 201
  [Documentation]  Posts a device and expects a Code value of 201
  [Tags]  postdevice
  ${response} =  Post Devices  @{XRS_WEBSERVICE_POST_TEST_DEVICE_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Code]  201
  END

Validate XRS Get Device REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted device now exists
  ${response} =  Get Device With Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Should Be Equal As Strings  ${response.status_code}  200

Validate XRS Put Device REST Web Services Modifies Description Successfully
  [Documentation]  Posts a device and expects a Code value of 201
  ${response} =  Put Devices  @{XRS_WEBSERVICE_POST_TEST_DEVICE_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Device edited successfully.
  END

Validate XRS Get Devices REST Web Services Returns 200 OK
  [Documentation]  Initial test to verify that all AWS XRS Web Services are available
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=11/01/2019
  Verify Get Devices With Forward Slash Returns 200 OK  &{params}
  Verify Get Devices Without Forward Slash Returns 200 OK  &{params}

Validate XRS Delete Device REST Web Services Returns 200 OK
  [Documentation]  Verifies that created device is deleted
  ${response} =  Delete Device With Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
Verify Get Devices With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${response} =  Get Devices With URI Ending With Forward Slash  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Devices Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Devices With URI Ending Without Forward Slash  &{params}
  Should Be Equal As Strings  ${response.status_code}  200
