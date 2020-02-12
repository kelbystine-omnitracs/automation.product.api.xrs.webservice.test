*** Settings ***
Documentation   Fundamental suite to test XRS AWS Driver Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/DriverVerification.resource
Resource        ./EntityManagementTestData/TestDriverSuiteSetup.resource

# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Driver Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsdriverrestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Driver REST Web Services Response Returns 400 Error
  [Documentation]  Verifies that a driver with a specific number does not exist
  Verify 400 Is Returned From Get Driver By ID ${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}

Validate AWS XRS Post Driver REST Web Services Response Returns Code 201
  [Documentation]  Posts a driver and expects a Code value of 201
  Verify Post Driver Method Returns Code 201 ${XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_LIST}

Validate AWS XRS Get Driver REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that a posted driver now exists
  ${get_response} =  Verify Get Driver By ID ${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID} Is successful
  Get SID Value From ${get_response} And Set Test Suite Variable

Validate AWS XRS Put Driver REST Web Services Response Description Returns "Driver edited successfully."
  [Documentation]  Posts a driver and expects a Code value of 201
  Verify Put Driver ${XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_LIST} Description Returns "Driver edited successfully."

Validate AWS XRS Get Drivers With Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get drivers with basic parameters
  Verify Get Drivers With Parameters ${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS} Method Is Successful With Forward Slash

Validate AWS XRS Get Drivers Without Forward Slash REST Web Services Response Returns 200 OK
  [Documentation]  Get drivers with basic parameters
  Verify Get Drivers With Parameters ${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS} Method Is Successful Without Forward Slash

Validate AWS XRS Get Devices With Raw String URI And /? REST Web Services Response Returns 200 OK
  [Documentation]  Get drivers with basic parameters using a raw URI string
  Verify Get Drivers Raw String ${GET_DRIVERS_PARAMS_STRING} With /? Is Successful

Validate AWS XRS Get Devices With Raw String URI And ? REST Web Services Response Returns 200 OK
  [Documentation]  Get drivers with basic parameters using a raw URI string
  Verify Get Drivers Raw String ${GET_DRIVERS_PARAMS_STRING} With ? Is Successful

Validate AWS XRS Delete Driver REST Web Services Response Returns 200 OK
  [Documentation]  Verifies that created driver is deleted
  Verify Delete Driver By ID ${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID} Is Successful

Validate AWS XRS Get Drivers REST Web Services For All Drivers Response Returns 200 OK
  [Documentation]  Gets all the drivers
  [Tags]  xrsawsperftest
  Verify Get All Drivers Is Successful

Validate AWS XRS Delete Drivers REST Web Services Response ErrorMessage Returns "Driver <driver_sid> doesn't exist."
  [Documentation]  Attempts to delete a previously deleted driver.
  Verify Delete Drivers By IDs ${XRS_WEB_SERVICES_TEST_DRIVER_1_SID} Is Response ErrorMessage Returns "Driver <driver_sid> doesn't exist."