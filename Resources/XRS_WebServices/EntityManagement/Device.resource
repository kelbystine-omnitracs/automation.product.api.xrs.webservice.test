*** Settings ***
Documentation  Keyword library for interacting with the Entity > Device Webservices
Library   RequestsLibrary
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_DEVICE_BY_NUMBER} =  /device
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES} =  /devices

*** Keywords ***
Get Device By Phone Number
  [Arguments]  ${phone_number}
  [Documentation]  Get device information for a particular device using the phone number
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_DEVICE_BY_NUMBER}/${phone_number}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Delete Device By Phone Number
  [Arguments]  ${phone_number}
  [Documentation]  Delete device information for a particular device using the phone number
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_DEVICE_BY_NUMBER}/${phone_number}
  ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Post Devices
  [Arguments]  @{list_data}
  [Documentation]  Calls the Post Method on Devices.
  ...  Accepts a list of json objects
  ...  Json field definitions:
  ...  BelongsToResourceGroups  # ResourceGroupID Collection  ResourceGroupID String values  ***Not Required***
  ...      Indicates the set of ResourceGroupIDs to which the device belongs.
  ...      If a resource group is not provided in a Post call, 
  ...      the new Device is to be placed in the default resource group for the organization to which the new Device is being added.
  ...  BluetoothAddress  # String  02:00:00:00:00:00  ***Read Only***
  ...      Read only field indicating the Bluetooth address of the device.
  ...      For Windows Mobile devices and devices using Android 5.0 or earlier, this field displays the device's unique Bluetooth address.
  ...      For devices using Android 6.0 or later, this field displays a static value of "02:00:00:00:00:00."
  ...  CarrierDisplayName  # String  Max 20 Character  ***Required***
  ...      The name of the Carrier.
  ...  CompanyName  # String  Alpha-numeric  ***Read Only***
  ...      A read only field that indicates the date and time the device was created.
  ...  CreateDate  # String  [1900-01-01T00:00:00]  DateTime  ***Read Only***
  ...      A read only field that indicates the date and time the device was created.
  ...  Description  # String  Max 20 Character  ***Not Required***
  ...      A description of the device.
  ...  DeviceType  # String  3-50 characters  ***Required***
  ...      Indicates the manufacturer and model of the device.
  ...  FixedDisplay  # String  [Boolean]  [False]  True  ***Not Required***
  ...      Indicates if this device will always be associated to a particular vehicle.
  ...      If set to true this will change the mobile behavior such that it remembers the last vehicle it was associated to.
  ...  IsChanged  # String  [Boolean]  [False]  True  ***Read Only***
  ...      A read only field indicating if there were any changes to the device since the value in the AsOfDateTime query parameter.
  ...  LastCommunication  # String  1999-05-31T11:20:00  DateTime  ***Read Only***
  ...      A read only field indicating the date and time the device last communicated with the host.
  ...  LastDriverID  # String  Max 20 Character  ***Read Only***
  ...      A read only field indicating the ID of the last driver which logged into the device.
  ...  LastDriverName  # String Max 20 Character ***Read Only***
  ...      A read only field indicating the name of the last driver which logged into the device.
  ...  LastVehicleID  # String Max 20 Character  ***Read Only***
  ...      A read only field indicating the ID of the last vehicle to which the device was associated via Bluetooth.
  ...  ModifiedBy  # String 3-50 characters  ***Read Only***
  ...      A read only field indicating the ID of the last person to modify the driver record.
  ...      From AC: CreateDate, ModifiedDate and ModifiedBy data fields will be initialized by system.
  ...  ModifiedDate  # String  1999-05-31T11:20:00  DateTime  ***Read Only***
  ...      A read only field indicating the date and time the device was last modified.
  ...  OrganizationID   # String  Max 20 Character  ***Required***
  ...      The user-defined ID of the organization.
  ...  OrganizationName  # String 3-50 characters  ***Read Only***
  ...      A read-only field containing the name of the organization to which the device is assigned.
  ...  PhoneNumber  # String  10 digits  ***Required***
  ...      The 10 digit phone number of the device
  ...  SendInstallLink  # String  [Boolean]  [Yes]  No  ***Not Required***
  ...      Indicates if an installation link will be sent to the device.
  ...  Status  # String  [Active]  Inactive  ***Required***
  ...      Identifies if a device is active or inactive in Omnitracs XRS. The value of this field must be Active or Inactive.
  ...  StoreGNISFileOnMobile  # String  [Boolean]  Yes  No  ***Read Only***
  ...      A read only field indicating whether the GNIS file will be stored on the mobile.
  ...  UserDefinedField1  # String  [Null]  Max 100 characters  ***Not Required***
  ...      User-defined field #1
  ...  UserDefinedField2  # String  [Null]  Max 100 characters  ***Not Required***
  ...      User-defined field #2
  ...  UserDefinedField3  # String  [Null]  Max 100 characters  ***Not Required***
  ...      User-defined field #3
  ...  UserDefinedField4  # String  [Null]  Max 100 characters  ***Not Required***
  ...      User-defined field #4
  ...  UserDefinedField5  # String  [Null]  Max 100 characters  ***Not Required***
  ...      User-defined field #5
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES}
  ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Put Devices
  [Arguments]  @{list_data}
  [Documentation]  Calls the Put Method on Devices.
  ...  Accepts a list of json objects
  ...  See Json field definitions in the "Post Devices" Keyword
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES}
  ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Devices
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Devices.
  ...  This will get devices that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [No Filter]
  ...     Tells the service to return only the data that changed since the specified date and time.
  ...  IsActive  # Default Value [No Filter]
  ...     Filters results to active drivers only.
  ...     Valid Values: True False Both
  ...  Limit  # Default Value 100
  ...     Used in conjunction with the Offset parameter to implement paging.
  ...     Limits the number of results to a specified number.
  ...     System Limit: 10,000
  ...  Offset  # Default Value 1
  ...     Used in conjunction with the Limit parameter to implement paging.
  ...     Represents a page number for the starting point of the return set.
  ...  OrganizationID  # Default Value [No Filter]
  ...     Limits results to devices in one or more organizations.
  ...  PhoneNumber  # Default Value [No Filter]
  ...     The following values can be specified:
  ...     [No Filter] - Limits results to all device records within the Web Service users' OrganizationID and ResourceGroupID.
  ...     10 character phone number - Limits results to the device record within the Web Service users' OrganizationID and ResourceGroupID
  ...     Example value: 1234567890
  ...  ResourceGroupID  # Default Value [No Filter]
  ...     Limits results to devices in one or more resource groups.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Devices
    [Documentation]  Get attributes for all Devices.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Get Devices With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get devices that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Devices Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

# Helper Keywords
Get Devices Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Verify that not using a '/' in the URI returns 200 OK
  ${response} =  Get Devices  &{params}
  [Return]  ${response.status_code}

Get Devices With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Verify that using a '/' in the URI returns 200 OK
  ${ending_character} =  Set Variable  /
  ${response} =  Get Devices With URI Ending With ${ending_character} And Parameters &{params}
  [Return]  ${response.status_code}

Get Devices Raw String URI With ${character_string} And Parameters ${params}
  [Documentation]  Verify that using the given character string in the raw URI string returns 200 OK
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Device}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DEVICES}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}OrganizationID=${params.OrganizationID}&IsActive=${params.IsActive}&AsOfDateTime=${params.AsOfDateTime}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response.status_code}