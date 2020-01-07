*** Settings ***
Documentation   Fundamental suite to test XRS AWS Vehicle Entity Management Web Services
Resource        ../../../Resources/XRS_WebServices/XRSCommonWebService.resource
Resource        ../../../Resources/XRS_WebServices/EntityManagement/Vehicle.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Resource        ../../../Resources/XRS_WebServices/Toolbox/RandomVIN.resource
Variables       ./EntityManagementTestData/TestVehicleData.yaml
Variables       ../../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables       ../../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml
# Suite Setup and Teardown
Suite Setup     Run Keywords  
                ...  Create AWS XRS Web Services Session
                ...  AND  Test Data Setup For XRS AWS Vehicle Web Service Test Suite
Suite Teardown  Delete All Sessions
Force Tags      awsxrsrestwebservicevalidation  awsxrsvehiclerestwebservicevalidation

*** Variables ***
# Setting a default environment
${XRS_HOST_ENVIRONMENT} =  d3  # TODO: remove this when pulled into larger suite

*** Test Cases ***
Validate AWS XRS Get Vehicle REST Web Services Returns Geographic "Vehicle identity does not exist." Error Message
  [Documentation]  Verifies that a Vehicle with a specific number does not exist
  ${response} =  Get Vehicle By ID  ${XRS_WEB_SERVICES_TEST_VEHICLE.VehicleName}
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[ErrorMessage]  Vehicle identity does not exist.

Validate AWS XRS Post Vehicle REST Web Services Returns Code 201
  [Documentation]  Posts a Vehicle and expects a Code value of 201
  ${response} =  Post Vehicles  @{XRS_AWS_WEBSERVICE_POST_TEST_VEHICLE_LIST}
  ${json_response} =  To Json  ${response.content}  
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Code]  201
  END

Validate AWS XRS Get Vehicle REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted Vehicle now exists
  ${response} =  Get Vehicle By ID  ${XRS_WEB_SERVICES_TEST_VEHICLE.VehicleName}
  Should Be Equal As Strings  ${response.status_code}  200
  ${json_response} =  To Json  ${response.content}
  # Create a Global variable for use later
  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID} =  Set Variable  ${json_response}[SID]
  Set Global Variable  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID}

Validate AWS XRS Get Vehicle By SID REST Web Services Returns 200 OK
  [Documentation]  Verifies that a posted Vehicle can be retrieved by vehicle SID
  ${response} =  Get Vehicle By SID  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID}
  Should Be Equal As Strings  ${response.status_code}  200

Validate AWS XRS Put Vehicle REST Web Services Modifies Vehicle Successfully
  [Documentation]  Posts a Vehicle and expects a Code value of 201
  ${response} =  Put Vehicles  @{XRS_AWS_WEBSERVICE_PUT_TEST_VEHICLE_LIST}
  ${json_response} =  To Json  ${response.content}
  FOR  ${r}  IN  @{json_response}
    Should Be Equal As Strings  ${r}[Description]  Vehicle edited successfully.
  END

Validate AWS XRS Get Vehicles REST Web Services Returns 200 OK
  [Documentation]  Get Vehicles with basic parameters
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  Verify Get Vehicles With Forward Slash Returns 200 OK  &{params}
  Verify Get Vehicles Without Forward Slash Returns 200 OK  &{params}

Validate AWS XRS Get Vehicles REST Web Services Returns 200 OK With Raw String URI
  [Documentation]  Get Vehicles with basic parameters using a raw URI string
  Verify Get Vehicles Raw String URI With /? Returns 200 OK
  Verify Get Vehicles Raw String URI With ? Returns 200 OK

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
  ${expected_error_message} =  Set Variable  Vehicle with identity '${XRS_WEB_SERVICES_TEST_VEHICLE_SID}' does not exist.
  ${response} =  Delete Vehicle By SID  ${XRS_WEB_SERVICES_TEST_VEHICLE_SID}
  ${json_response} =  To Json  ${response.content}
  Should Be Equal As Strings  ${json_response}[ErrorMessage]  ${expected_error_message}

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

Verify Get Vehicles Without Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Vehicles  &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Vehicles With Forward Slash Returns 200 OK
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Vehicles With URI Ending With ${ending_character} And Parameters &{params}
  Should Be Equal As Strings  ${response.status_code}  200

Verify Get Vehicles Raw String URI With ${character_string} Returns 200 OK
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{params} =  Create Dictionary  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}  IsActive=True  AsOfDateTime=${mm}/${dd}/${yyyy}
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Vehicle}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  Should Be Equal As Strings  ${response.status_code}  200
