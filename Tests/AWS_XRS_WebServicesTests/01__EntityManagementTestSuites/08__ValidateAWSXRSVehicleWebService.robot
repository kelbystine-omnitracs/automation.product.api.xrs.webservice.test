*** Settings ***
Documentation   Fundamental suite to test XRS AWS Vehicle Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/ParseResponse.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/RandomVIN.resource
Variables       ./EntityManagementTestData/TestVehicleData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Vehicle Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsvehiclerestwebservicevalidation

*** Variables ***

*** Test Cases ***
Validate AWS XRS Get Vehicle REST Web Services Returns Geographic "Vehicle identity does not exist." Error Message
  [Documentation]  Verifies that a Vehicle with a specific number does not exist
  ${response} =  Get Vehicle By ID  ${XRS_WEB_SERVICES_TEST_VEHICLE.VehicleName}
  &{expected_values} =  Create Dictionary  key=ErrorMessage  value=Vehicle identity does not exist.
  ${actual_value} =  Get Value From Response With Key  ${expected_values.key}  ${response}
  Should Be Equal As Strings  ${actual_value}  ${expected_values.value}

Validate AWS XRS Post Vehicle REST Web Services Returns Code 201
  [Documentation]  Posts a Vehicle and expects a Code value of 201
  ${response} =  Post Vehicles  @{XRS_AWS_WEBSERVICE_POST_TEST_VEHICLE_LIST}
  &{expected_values} =  Create Dictionary  key=Code  value=201
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Vehicle REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted Vehicle now exists
  ${response} =  Get Vehicle By ID  ${XRS_WEB_SERVICES_TEST_VEHICLE.VehicleName}
  Should Be Equal As Strings  ${response.status_code}  200
  # Create a Global variable for use later
  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID} =  Get Value From Response With Key  SID  ${response}
  Set Global Variable  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID}

Validate AWS XRS Get Vehicle By SID REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted Vehicle can be retrieved by vehicle SID
  ${response} =  Get Vehicle By SID  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Vehicle REST Web Services Modifies Vehicle Successfully
  [Documentation]  Posts a Vehicle and expects a Code value of 201
  ${response} =  Put Vehicles  @{XRS_AWS_WEBSERVICE_PUT_TEST_VEHICLE_LIST}
  &{expected_values} =  Create Dictionary  key=Description  value=Vehicle edited successfully.
  Verify Response List ${response} Has Key ${expected_values.key} And Contains Value ${expected_values.value}

Validate AWS XRS Get Vehicles REST Web Services Returns 200 OK
  [Documentation]  Get Vehicles with basic parameters
  ${wo_slash_response} =  Get Vehicles Response With Forward Slash  &{XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS}
  ${w_slash_response} =  Get Vehicles Response Without Forward Slash  &{XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS}
  Should Be Equal As Strings  ${wo_slash_response}  200
  Should Be Equal As Strings  ${w_slash_response}  200

Validate AWS XRS Get Vehicles REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Vehicles with basic parameters using a raw URI string
  ${w_slash_question_response} =  Get Vehicles Raw String URI Response With /? And Parameters ${XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS_STRING}
  ${w_question_response} =  Get Vehicles Raw String URI Response With ? And Parameters ${XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS_STRING}
  Should Be Equal As Strings  ${w_slash_question_response}  200
  Should Be Equal As Strings  ${w_question_response}  200

Validate AWS XRS Delete Vehicle REST Web Services Returns 200 OK
  [Documentation]  Verifies that created Vehicle is deleted
  ${response} =  Delete Vehicle By ID  ${XRS_WEB_SERVICES_TEST_VEHICLE.VehicleName}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Get Vehicles REST Web Services For All Vehicles Returns 200 OK
  [Documentation]  Gets all the Vehicles
  [Tags]  xrsawsperftest
  ${response} =  Get All Vehicles
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Delete Vehicle By SID REST Web Services Returns ErrorMessage "Vehicle identity 'xxxx' does not exist."
  [Documentation]  Attempts to delete a previously deleted Vehicle.
  ${response} =  Delete Vehicle By SID  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID}
  &{expected_values} =  Create Dictionary  key=ErrorMessage  value=Vehicle with identity '${XRS_WEB_SERVICES_TEST_VEHICLE_SID}' does not exist.
  ${actual_value} =  Get Value From Response With Key  ${expected_values.key}  ${response}
  Should Be Equal As Strings  ${actual_value}  ${expected_values.value}

*** Keywords ***
Test Data Setup For XRS AWS Vehicle Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Vehicle Web Service Tests.
  # Create post test Vehicle 1 data.
  ${random_vin} =  Get Random Valid VIN From randomvin.com
  &{XRS_AWS_WEBSERVICE_POST_TEST_VEHICLE_1_DICT} =  Create Dictionary
  ...  CompanyName=${XRS_GENERAL_INFORMATION.Company.Company_Name}
  ...  CompanySID=${XRS_GENERAL_INFORMATION.Company.Company_SID}
  ...  LicensePlate=${XRS_WEB_SERVICES_TEST_VEHICLE.LicensePlate}
  ...  OBCType=${XRS_WEB_SERVICES_TEST_VEHICLE.OBCType}
  ...  Odometer=${XRS_WEB_SERVICES_TEST_VEHICLE.Odometer}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  OrganizationName=${XRS_GENERAL_INFORMATION.Company.Company_Name}
  ...  OrganizationSID=${XRS_GENERAL_INFORMATION.Company.ParentOrganizationSid}
  ...  Status=${XRS_WEB_SERVICES_TEST_VEHICLE.Status}
  ...  TGTNumber=${XRS_WEB_SERVICES_TEST_VEHICLE.TGTNumber}
  ...  Type=${XRS_WEB_SERVICES_TEST_VEHICLE.Type}
  ...  VIN=${random_vin}
  ...  VehicleName=${XRS_WEB_SERVICES_TEST_VEHICLE.VehicleName}
  ...  Year=${XRS_WEB_SERVICES_TEST_VEHICLE.Year}
  @{XRS_AWS_WEBSERVICE_POST_TEST_VEHICLE_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_VEHICLE_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_VEHICLE_LIST}
  # Create put test Vehicle 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_VEHICLE_1_DICT} =  Create Dictionary
  ...  OrganizationSID=${XRS_GENERAL_INFORMATION.Company.Company_SID}
  ...  VIN=${random_vin}
  ...  VehicleName=${XRS_WEB_SERVICES_TEST_VEHICLE.VehicleName}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_VEHICLE_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_VEHICLE_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_VEHICLE_LIST}
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS}
  # Create test params string
  ${XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${XRS_AWS_WEBSERVICE_VEHICLE_TEST_PARAMS_STRING}