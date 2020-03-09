*** Settings ***
Documentation   Smoke suite to test XRS Device Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/DeviceVerification.resource
Resource        ./EntityManagementTestData/TestDeviceSuiteSetup.resource
# Suite Setup and Teardown
Suite Setup     Run keywords
                ...  Create REST API Session
                ...  AND  Test Data Setup For XRS Device Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      xrsrestwebservicevalidation  xrsdevicerestwebservicevalidation

*** Test Cases ***
Validate XRS Get Device REST Web Services Response Returns 400 Error
  [Documentation]  Verifies that a device with a specific number does not exist
  Verify 400 Is Returned From Get Device By Phone Number ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber}

Validate XRS Post Device REST Web Services Response Returns Code 201
  [Documentation]  Posts a device and expects a Code value of 201
  Verify Post Device Method Returns Code 201 @{XRS_WEBSERVICE_POST_TEST_DEVICE_LIST}

Validate XRS Get Device REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that a posted device now exists
  Verify Get Device By Phone Number ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber} Is successful

Validate XRS Put Device REST Web Services Response Description Returns "Device edited successfully."
  [Documentation]  Posts a device and expects a Code value of 201
  Verify Put Device @{XRS_WEBSERVICE_PUT_TEST_DEVICE_LIST} Description Returns "Device edited successfully."

Validate XRS Get Devices With Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get devices with basic parameters and URI ends with a forward slash before parameters
  Verify Get Devices With Parameters &{XRS_WEBSERVICE_DEVICE_TEST_PARAMS} Method Is Successful With Forward Slash

Validate XRS Get Devices Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get devices with basic parameters and URI ends without a forward slash before parameters
  Verify Get Devices With Parameters &{XRS_WEBSERVICE_DEVICE_TEST_PARAMS} Method Is Successful Without Forward Slash

Validate XRS Get Devices With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Documentation]  Get devices with basic parameters using a raw URI string
  Verify Get Devices Raw String ${XRS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING} With /? Is Successful

Validate XRS Get Devices With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get devices with basic parameters using a raw URI string
  Verify Get Devices Raw String ${XRS_WEBSERVICE_DEVICE_TEST_PARAMS_STRING} With ? Is Successful

Validate XRS Get Devices REST Web Services For All Devices Response Returns 200 OK
  [Documentation]  Gets all the Devices
  [Tags]  xrsawsperftest
  Verify Get All Devices is Successful

Validate XRS Delete Device REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that created device is deleted
  Verify Delete Device ${XRS_WEB_SERVICES_TEST_DEVICE_1.PhoneNumber} Is Successful
