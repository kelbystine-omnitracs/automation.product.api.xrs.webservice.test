*** Settings ***
Documentation  Keywords for setting up suite test data.
Variables       ./TestDeviceData.yaml
Variables       ../../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml

*** Keywords ***
Test Data Setup For XRS Device Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for Device Web Service Tests.
  # Create post test device 1 data.
  &{XRS_WEBSERVICE_POST_TEST_DEVICE_1_DICT} =  Create Dictionary
  ...  CarrierDisplayName=${XRS_WEB_SERVICES_TEST_DEVICE_1.CarrierDisplayName}
  ...  Description=${XRS_WEB_SERVICES_TEST_DEVICE_1.Description}
  ...  DeviceType=${XRS_WEB_SERVICES_TEST_DEVICE_1.DeviceType}
  ...  FixedDisplay=${XRS_WEB_SERVICES_TEST_DEVICE_1.FixedDisplay}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  PhoneNumber=${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  ...  SendInstallLink=${XRS_WEB_SERVICES_TEST_DEVICE_1.SendInstallLink}
  ...  Status=${XRS_WEB_SERVICES_TEST_DEVICE_1.Status}
  @{XRS_WEBSERVICE_POST_TEST_DEVICE_LIST} =  Create List  ${XRS_WEBSERVICE_POST_TEST_DEVICE_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_POST_TEST_DEVICE_LIST}
  # Create put test device 1 data.
  &{XRS_WEBSERVICE_PUT_TEST_DEVICE_1_DICT} =  Create Dictionary
  ...  CarrierDisplayName=${XRS_WEB_SERVICES_TEST_DEVICE_1.CarrierDisplayName}
  ...  Description=This has changed.
  ...  DeviceType=${XRS_WEB_SERVICES_TEST_DEVICE_1.DeviceType}
  ...  FixedDisplay=${XRS_WEB_SERVICES_TEST_DEVICE_1.FixedDisplay}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  PhoneNumber=${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}
  ...  SendInstallLink=${XRS_WEB_SERVICES_TEST_DEVICE_1.SendInstallLink}
  ...  Status=${XRS_WEB_SERVICES_TEST_DEVICE_1.Status}
  @{XRS_WEBSERVICE_PUT_TEST_DEVICE_LIST} =  Create List  ${XRS_WEBSERVICE_PUT_TEST_DEVICE_1_DICT}
  Set Suite Variable  @{XRS_WEBSERVICE_PUT_TEST_DEVICE_LIST}
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_WEBSERVICE_DEVICE_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_WEBSERVICE_DEVICE_TEST_PARAMS}
  # Create test params string
  ${XRS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_WEBSERVICE_DEVICE_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_WEBSERVICE_DEVICE_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_WEBSERVICE_DEVICE_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING}