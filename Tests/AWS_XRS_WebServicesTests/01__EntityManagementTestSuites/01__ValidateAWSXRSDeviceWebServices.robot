*** Settings ***
Documentation   Smoke suite to test XRS AWS Device Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Device.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Variables       ./EntityManagementTestData/TestDeviceData.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run keywords
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Device Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsdevicerestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Device REST Web Services Response Returns 400 Error
  [Documentation]  Verifies that a device with a specific number does not exist
  ${response} =  Get Device By Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Status Should Be  400  ${response}

Validate AWS XRS Post Device REST Web Services Response Returns Code 201
  [Documentation]  Posts a device and expects a Code value of 201
  ${response} =  Post Devices  @{XRS_AWS_WEBSERVICE_POST_TEST_DEVICE_LIST}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Device REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that a posted device now exists
  ${response} =  Get Device By Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Request Should Be Successful  ${response}

Validate AWS XRS Put Device REST Web Services Response Description Returns "Device edited successfully."
  [Documentation]  Posts a device and expects a Code value of 201
  ${response} =  Put Devices  @{XRS_AWS_WEBSERVICE_PUT_TEST_DEVICE_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Device edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Devices REST Web Services Response Returns 200 OK
  [Documentation]  Get devices with basic parameters
  ${w_slash_response} =  Get Devices Response With Forward Slash  &{XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS}
  ${wo_slash_response} =  Get Devices Response Without Forward Slash  &{XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS}
  Request Should Be Successful  ${w_slash_response}
  Request Should Be Successful  ${wo_slash_response}

Validate AWS XRS Get Devices REST Web Services Response Returns 200 OK With Raw String URI
  [Documentation]  Get devices with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Devices Raw String URI Response With /? And Parameters ${XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Devices Raw String URI Response With ? And Parameters ${XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING}
  Request Should Be Successful  ${w_slash_question_response}
  Request Should Be Successful  ${w_question_response}

Validate AWS XRS Get Devices REST Web Services For All Devices Response Returns 200 OK
  [Documentation]  Gets all the Devices
  [Tags]  xrsawsperftest
  ${response} =  Get All Devices
  Request Should Be Successful  ${response}

Validate AWS XRS Delete Device REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that created device is deleted
  ${response} =  Delete Device By Phone Number  ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  Request Should Be Successful  ${response}

*** Keywords ***
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
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING}