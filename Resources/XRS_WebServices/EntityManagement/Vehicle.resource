** Settings ***
Documentation  Keyword library for interacting with the Entity > Vehicle Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_VEHICLE} =  /vehicle
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES} =  /vehicles

*** Keywords ***
Get Vehicle By ID
  [Arguments]  ${vehicle_id}
  [Documentation]  Get vehicle information for a particular vehicle using the vehicle id
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_VEHICLE}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Delete Vehicle By ID
  [Arguments]  ${vehicle_id}
  [Documentation]  Delete vehicle information for a particular vehicle using the vehicle id
  ...  The Delete method supports the deletion of one vehicle per call only
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_VEHICLE}/${vehicle_id}
  ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Vehicle By SID
  [Arguments]  ${vehicle_sid}
  [Documentation]  Get vehicle information for a particular vehicle using the vehicle sid
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}/${vehicle_sid}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Delete Vehicle By SID
  [Arguments]  ${vehicle_sid}
  [Documentation]  Delete vehicle information for a particular vehicle using the vehicle sid
  ...  The Delete method supports the deletion of one vehicle per call only
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}/${vehicle_sid}
  ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Post Vehicles
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Users.
    ...  Accepts a list of json objects
    ...  Json field definitions:
	...  AllowTrailerInspection  # Boolean  True False  Default: True  ***Read Only***
    ...    This is read-only field that is auto-populated according to the selection in the Vehicle Type field as follows:
    ...    Vehicle Type AllowTrailerInspection
    ...    ------------ ----------------------
    ...    Tractor      True
    ...    Bus/Coach    True
    ...    Flatbed      True
    ...    Tanker       True
    ...    Straight     True
    ...    If false, drivers associated to this vehicle will not be prompted to perform a trailer inspection.
    ...    The Trailer inspection on the mobile will be disabled while associated to this vehicle.
    ...    Note also that the AllowTrailerInspection values for the vehicle type can only be changed on the Omnitracs XRS website in the company settings page.
	...  Auxiliary  # String  None, APU, BunkHeater, Hybrid  Default: None  ***Not Required***
    ...    Type of Auxiliary Power Unit (APU).
	...  CompanyName  # String  Alpha-numeric  ***Not Required***
    ...    The user defined name of the company.
	...  CompanySID  # Long  Positive Numeric Value  ***Not Required***
    ...    The XRS unique System ID of the company.
    ...    This value is generated automatically by XRS and can be retrieved using the GET method.
	...  Country  # Country  Alpha-numeric  ***Not Required***
    ...    The name of the country where the vehicle is based.
	...  EldVehicle  # String  True False  ***See Description***
    ...    Indicates if this vehicle is an ELD vehicle or not.
    ...    When the company setting Default Host Mode = AOBRD, the following rules govern the default values:
    ...    1. If the vehicle is added before Dec 18th 2017, "false" will be the default setting
    ...    2. If the vehicle is added on or after Dec 18th 2017, "true" will be the default setting
    ...      and the user may not change the field value to "false" after saving the vehicle.
    ...    When the company setting Default Host Mode = Mixed, the following rules govern the default values:
    ...    1. If the vehicle is added before Dec 18,  2017, "true" will be the default setting
    ...    2. If the vehicle is added on or after Dec 18 2017, "true" will be the default setting
    ...     and Web Service users may not change the field value to "false" after saving the vehicle.
    ...    3. When the field is set to "true" for a vehicle, it can only be set back to "false" via XRS Master
    ...    4. If the vehicle is being added to a company that was created after Dec 18, 2017, the ELD Vehicle default will be "true",
    ...      and Web Service users may not change the field value to "false" before or after saving the vehicle.
    ...    When the company setting Default Host Mode = ELD, the following rules govern the default values:
    ...    1. The default will always be Yes and cannot be changed to “false”.
	...  FuelDrawCapacity  # Integer  0-2147483647  Default: 0  ***Not Required***
    ...    The amount of fuel the vehicle can store in a single filling.
	...  GrossVehicleWeight  # Integer  0-2147483647  Default: 0  ***Not Required***
    ...    The total gross vehicle weight including tonnage.
	...  HasBerth  # Boolean  True False  Default: False  ***Not Required***
    ...    Identifies if the vehicle has a qualifying sleeper berth.
	...  HasElectronicEngine  # Boolean  True False  Default: False  ***Not Required***
    ...    Identifies if the vehicle has an electronic engine.
    ...    This value is True for most vehicles.
	...  HosExempt  # Boolean  True False  Default: False  ***Not Required***
    ...    Indicates if the vehicle is subject to HOS rules or is exempt from them (True = Exempt).
	...  HP  # Integer  0-2147483647  Default: 0  ***Not Required***
    ...    The horsepower rating of the engine.
	...  HUT  # Boolean  True False  Default: False  ***Not Required***
    ...    Identifies if the vehicle qualifies for Highway Use Tax
	...  IFTA  # Boolean  True False  Default: False  ***Not Required***
    ...    Identifies if the vehicle qualifies for IFTA Fuel Taxes
	...  InstallDate  # DateTime  DateTime  ***Not Required***
    ...    The date the Relay was associated with the vehicle.
	...  LicensePlate  # String  Alpha-numeric  ***Not Required***
    ...    The license plate of the vehicle.
	...  Manufacture  # String  Alpha-numeric value:  ***Not Required***
    ...  The name of the manufacturer of the vehicle.
    ...    DAF              Fiat-Iveco          Foden           GMC             Chevrolet
    ...    Ford             Freightliner        Hino            International   Isuzu
    ...    Kenworth         Mitsubishi Fuso     Oshkosh         Other           Peterbilt
    ...    Scania           Sterling            Thomas Built    Unimog          Volvo
    ...    Western Star     Mack                Dodge
	...  ManufactureDate  # DateTime  DateTime  ***Not Required***
    ...    The date the vehicle was manufactured.
    ...    The default value for this field is:
    ...    1900-01-01T00:00:00
	...  Model  # String Alpha-numeric  ***Not Required***
    ...    The name of the vehicle model.
	...  ModifiedBy  # Long  Positive Numeric Value  ***Read Only***
    ...    The SID of the last person to modify the driver record.
	...  ModifiedDate  # DateTime  DateTime  ***Read Only***
    ...    The date the driver record was last modified.
    ...    The value of this field is Read Only and cannot be modified using PUT or POST commands.
	...  ManualVIN  # String  Yes or No, Default: No  ***Not Required***
    ...    No actual decription of what this is...
	...  OBCType  # String  None, XRSRelay, AMG-C  ***Read Only***
    ...    The type of OBC (On Board Computer) installed ("XRS Relay").
    ...    This field is read-only.
    ...    If OBCType = XRSRelay, then either of the following TGTNumber values must be provided:
    ...    A valid TGT Number
    ...    0 - to unassign the Relay from the vehicle
	...  Odometer  # Integer  Positive Numeric value  ***Not Required***
    ...    The last Odometer reading from the vehicle.
	...  OdometerDate  # DateTime  DateTime ***Not Required***
    ...    The date at which the Odometer was captured from the vehicle.
	...  OrganizationName  # String  Alpha-numeric  ***Not Required***
    ...    The user defined name of the organization that owns the vehicle.
	...  OrganizationID  # String  Max = 20 characters  ***Not Required***
    ...    The user-defined ID of the Organization.
	...  OrganizationSID  # Long  Positive Numeric Value  ***Required***
    ...    The XRS unique System ID of the organization that owns the vehicle.
    ...    This value is generated automatically by XRS and can be retrieved using the GET method.
	...  OwnerOperator  # Boolean  True False  Default: False  ***Not Required***
    ...    A flag that determines if the vehicle is owned by an owner-operator.
	...  PowerAxles  # Integer  1-4  ***Not Required***
    ...    The number of axles on the power-unit.
	...  ResourceGroupIdList  # Resource Group Collection  ResourceGroupID  ***Not Required***
    ...    Indicates the set of ResourceGroupIDs to which the vehicle should belong
    ...    NOTE: If a resource group is not provided in a Put call,
    ...    the new Vehicle is to be placed in the default resource group for the organization to which the new Vehicle is being added.
	...  SID  # Long  Positive Numeric Value  ***Not Required***
    ...    The XRS System ID of the vehicle.
    ...    This value is generated automatically by XRS and can be retrieved using the GET method.
	...  StateProvince  # String  State or Prvince Name  ***Not Required***
    ...    This field contains the state, province, or territory name where the vehicle is based.
	...  Status  # String  This field must contain either of the following values: Active Inactive  ***Not Required***
    ...    Identifies if a vehicle is active or inactive in XRS.
    ...    The value of this field must be Active or Inactive.
	...  StraightTruck  # Boolean  True False  Default: False  ***Not Required***
    ...    Identifies if the vehicle is classified as a straight-truck.
	...  TGTNumber  # Long  Positive Numeric Value  ***Not Required*** Unless OBCType=XRSRelay or AMG-C
    ...    The unique serial number (TGT Number) of the Omnitracs XRS Relay that is installed in the vehicle
    ...    If OBCType = XRSRelay, then either of the following TGTNumber values must be provided:
    ...      A valid TGT Number
    ...      0 - to unassign the Omnitracs XRS Relay from the vehicle
    ...    Web Service Integrators can perform the following:
    ...      To assign an Omnitracs XRS Relay to a vehicle, set the OBCType data field to ‘XRSRelay’
    ...        and set the TGTNumber field to the Omnitracs XRS Relay TGT Number.
    ...      To unassign an Omnitracs XRS Relay from a vehicle so that the Omnitracs XRS Relay can be assigned to another vehicle
    ...        or so that another Omnitracs XRS Relay can be assigned to this vehicle, set the OBCType data field to ‘None’
    ...        and set the TGTNumber data field to ‘0’ or ‘-1’.
    ...      To assign an Omnitracs XRS Relay that is not currently assigned to a vehicle to a vehicle that currently
    ...        has an Omnitracs XRS Relay assigned to it, set the OBCType data field to ‘XRSRelay’ and set the TGTNumber field to the new,
    ...        currently unassigned TGT Number of the Omnitracs XRS Relay.
    ...        This will unassign the current Omnitracs XRS Relay from the vehicle and assign the new Omnitracs XRS Relay to the vehicle
	...  TransmissionMfg  # String  Alpha-numeric  ***Not Required***
    ...    The manufacturer of the transmission.
	...  TransmissionType  # String  Alpha-numeric  ***Not Required***
    ...    The type of transmission.
	...  Type  # String  Default: Tractor  ***Not Required***
    ...    The type of vehicle.
    ...      Tractor, Van, Straight, IFTAExemptMailCarrier, Bulk, Tech, PickUp
	...  UserDefinedField1  # String  Text entry  Field Max Length=50 characters  ***Not Required***
    ...    User-Defined Field #1
	...  UserDefinedField2  # String  Text entry  Field Max Length=50 characters  ***Not Required***
    ...    User-Defined Field #2
	...  UserDefinedField3  # String  Text entry  Field Max Length=50 characters  ***Not Required***
    ...    User-Defined Field #3
	...  UserDefinedField4  # String  Text entry  Field Max Length=50 characters  ***Not Required***
    ...    User-Defined Field #4
	...  UserDefinedField5  # String  Text entry  Field Max Length=50 characters  ***Not Required***
    ...    User-Defined Field #5
	...  VehicleName  # String  Alpha-numeric  ***Required***
    ...    The user-defined ID of the vehicle. This is the same as Vehicle ID in the XRS Host.
    ...    3-20 Characters
	...  VIN  # String  Length=17-19 characters  Default: Null  ***Required***
    ...    The registered Vehicle Identification Number (VIN) of the vehicle.
	...  Year  # String  1970-2020  Field length=4 characters  ***Not Required***
    ...    The year the vehicle was manufactured.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}
    ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Put Vehicles
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Vehicles.
    ...  Accepts a list of json objects
    ...  See Json field definitions in the "Post Vehicles" Keyword 
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}
    ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Get Vehicles
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on vehicles.
  ...  This will get vehicles that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [No Filter]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...  IsActive  # Default Value [No Filter]
  ...      Filters results to active vehicles only.
  ...      True, False, Both
  ...  Limit  # Default Value 100
  ...      Used in conjunction with the Offset parameter to implement paging.
  ...      Limits the number of results to a specified number.
  ...      System Limit: 10,000
  ...  Offset  # Default Value 1
  ...      Used in conjunction with the Limit parameter to implement paging.
  ...      Represents a page number for the starting point of the return set.
  ...  OrganizationID  # Default Value [No Filter]
  ...      Limits results to vehicles in one or more organizations.
  ...      Maximum of 20 characters.
  ...  OrganizationSID  # Default Value [No Filter]
  ...      Limits results to vehicles in one or more organizations.
  ...      Maximum of 20 characters.
  ...  ResourceGroupID  # Default Value [No Filter]
  ...      Limits results to vehicles in one or more resource groups.
  ...  ResourceGroupSID  # Default Value [No Filter]
  ...      Limits results to vehicles in one or more resource groups.
  ...  VehicleSID  # Default Long - Positive Numeric Value
  ...      Limits the results to vehicle object with VehicleSID in OrganizationSID and ResourceGroupSID.
  ...      Maximum of 20 characters?
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Vehicles With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get vehicles that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Users Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Vehicles
  [Documentation]  Get attributes for all vehicles.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Vehicle}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get The nth Active Vehicle ID
    [Arguments]  ${nth_vehicle}
    [Documentation]  This keyword pulls a 0 index list of vehicle json objects and returns the nth vehicle ID.
    ...  The argument ${nth_vehicle} must be an integer.
    ${vehicle_response} =  Get Vehicles  IsActive=True
    ${vehicle_response_json} =  To Json  ${vehicle_response.content}
    &{get_first_active_vehicle} =  Set Variable  @{vehicle_response_json}[${nth_vehicle}]
    [Return]  ${get_first_active_vehicle.VehicleName}

# Helper Keywords
Get Vehicles Response Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Vehicles  &{params}
  [Return]  ${response}

Get vehicles Response With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Vehicles With URI Ending With / And Parameters &{params}
  [Return]  ${response}

Get Vehicles Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With
  ...  ${XRS_Entity_Management_Base_URI.Vehicle}
  ...  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_VEHICLES}
  ...  ${character_string}
  ...  ${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri_string}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}