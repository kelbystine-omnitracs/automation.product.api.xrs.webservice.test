*** Settings ***
Documentation  Keyword library for interacting with the Entity > Driver Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_DRIVER_BY_DRIVERID} =  /driver
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS} =  /drivers

*** Keywords ***
Get Driver By ID
    [Arguments]  ${driver_id}
    [Documentation]  Get attributes for a specific driver by specifying a DriverSID value.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_DRIVER_BY_DRIVERID}/${driver_id}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Delete Driver By ID
    [Arguments]  ${driver_id}
    [Documentation]  Delete a single driver record in Omnitracs XRS by specifying the DriverSID.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_DRIVER_BY_DRIVERID}/${driver_id}
    ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Post Drivers
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Drivers.
    ...  Accepts a list of json objects
    ...  Json field definitions:
    ...  CDLExpiration  # DateTime DateTime  ***Not Required***
    ...      The date at which the current CDL expires.
    ...  CDLNumber  # String  Max length=20 characters  ***Required***
    ...      The Commercial Driver's License held by the driver. 
    ...      This field supports a maximum of 20 characters.
    ...  CellPhone  # String  10 digit phone number with no dashes, parenthesis, or other symbols.  Example: 5551239876  ***Not Required***
    ...      The Mobile phone number of the driver.
    ...      NOTE: This phone number is not required to be the same as the phone number of the device being used for Omnitracs XRS.
    ...  CompanyName  # String  Example: Eastern Fast Trucking Co.  ***Not Required***
    ...      The name of the Company.
    ...  CompanySID  # Long  Positive Numeric Value  ***Not Required***
    ...      The Omnitracs XRS unique System ID of the company.
    ...      This value is generated automatically by Omnitracs XRS and can be retrieved using the GET method.
    ...  CreateDate  # DateTime  DateTime  ***Read Only***
    ...      The date and time the account was created.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  DefaultHOSRule  # String  null  ***Required***
    ...      The DefaultHOSRule value of the appropriate HOS rule set.
    ...  DriverID  # String  example: 4243  Max Length = 20 characters  ***Required***
    ...      The user-defined driver ID.
    ...  ELDExempt  # Boolean  True, False  Default: False  ***Required***
    ...      This field indicates if the driver is exempt from the ELD mandate.
    ...      This field is required for POST and PUT calls.
    ...  ELDExemptExplanation  # String  Maximum of 60 characters  ***Required If ELDExempt is True*** 
    ...      If the ELDExempt field is set to True, this field is required and must contain an explanation as to why this driver is exempt from the ELD mandate.
    ...      This field is required if <ELDExempt> is True.
    ...  EnableBigDay  # Boolean  True, False  Default: False  ***Not Required***
    ...      Indicates if the driver is allowed to declare a 16-Hour Big Day exemption
    ...  EnableDriverPortal  # Boolean  True, False  ***Required***
    ...      Indicates if the driver is allowed to login to the driver portal
    ...  EnableHOSRule  # String  Semicolon separated list of HOSRuleSID values. See the HOSRuleSID table  for a list of valid HOSRuleSID values.  Valid Values = 1 - 37
    ...      # ***Required If UseHOSOrganizationSettings is False***  ***Not Required If UseHOSOrganizationSettings is True***
    ...      The HOSRuleSID value of the appropriate HOS rule set.
    ...      NOTE: The RuleSet value is the SID of the appropriate rule set, NOT the name of the rule set.
    ...      NOTE: When “UseHOSOrganizationSettings” field is set to true, the “EnableHOSRule” value should be "".
    ...  EnablePersonalConveyance  # Boolean  True, False  Default: False  ***Not Required***
    ...      Indicates if the driver is allowed to take Personal Conveyance
    ...  EnableTimeClock  # Boolean  True, False  Default: False  ***Not Required***
    ...      Indicates if the driver is using Omnitracs XRS time clock features
    ...  EnableYardMove  # Boolean  True, False  Default: False  ***Required***
    ...      Indicates if yard moves are allowable for this driver.
    ...      This field is required for both PUT and POST calls.
    ...  Endorsements   # String  Max length= 50 characters  ***Not Required***
    ...      Indicates if there are any endorsements on the Driver's CDL
    ...  FirstName  # String  Example: Bill  Max length= 50 characters  ***Required***
    ...      The first name of the driver.
    ...  HomeTelephone  # String  10 digit phone number with no dashes, parenthesis, or other symbols.  Example: 5551239876  ***Not Required***
    ...      The primary telephone number of the driver.
    ...  Language  # String  English French Spanish  Default: English  ***Required***
    ...      The language used by the driver.
    ...  LastLogin  # DateTime  DateTime  ***Not Required***
    ...      The Date and time of the Last Login request.
    ...  LastName  # String  Example: Smith  ***Required***
    ...      The last name of the driver.
    ...  LicenseIssuingCountry  # String  USA Canada  ***Required***
    ...      The country that issued the CDL license. Valid values include:
    ...      USA
    ...      Canada
    ...      This field is required for both POST and PUT calls.
    ...  LicenseIssuingStateProvince  # String  This web service accepts either the full state or province name, or the abbreviation.  ***Required***
    ...      The state or province that issued the CDL license.
    ...      This field is required for both POST and PUT calls.
    ...  MaxConveyanceDistance  # Integer  0-99  ***Not Required***
    ...      The maximum distance this driver is allowed to drive on Personal Conveyance.
    ...  MedicalExp  # DateTime  DateTime  ***Not Required***
    ...      The date at which the current medical exam expires
    ...  MiddleName  # String  Example: Tim  ***Not Required***
    ...      The middle name of the driver.
    ...  ModifiedBy  # Long  Psitive Numeric Value  ***Read Only***
    ...      The SID of the last person to modify the driver record.
    ...  ModifiedDate  # DateTime  DateTime  ***Read Only***
    ...      The date the driver record was last modified.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  OrganizationID  # String  Alphanumeric Value  ***Required***
    ...      The user-defined ID of the organization to which the driver belongs.
    ...      Note: Either this field or the OrganizationSID field is required for a post method call, but neither is required for a put method call.
    ...  OrganizationName  # String  Default: [null]  Example: Southeast Transportation Division.  ***Not Required***
    ...      The Organization name.
    ...  OrganizationSID  # Long  Positive Numeric Value  ***Required***
    ...      The XRS-defined System ID of the organization.
    ...      This value is generated automatically by XRS and can be retrieved using the GET method.
    ...      Note: Either this field or the OrganizationSID field is required for a post method call, but neither is required for a put method call.
    ...      Must be assigned a value of 0.
    ...  Password  # String  <password>  ***Required***
    ...      The drivers password.
    ...  PayrollOrganizationSID  # Long  Positive Numeric Value  ***Not Required***
    ...      The SID of the organizations associated with the driver in the integrated payroll system.
    ...      This field will be used for future payroll related web services.
    ...  PayrollSID  # Long  Positive Numeric Value  ***Not Required***
    ...      The SID of the payroll record when using the integrated payroll system
    ...      This value is generated automatically by Omnitracs XRS and can be retrieved using the GET method.
    ...  ResourceGroupIDList  # String  ResourceGroupIDCollection  ***Not Required***
    ...      Indicates the set of ResourceGroupIDs to which the driver belongs.
    ...      NOTE: If a resource group is not provided in a Put call,
    ...      the new Driver is to be placed in the default resource group for the organization to which the new Driver is being added.
    ...  SID  # Long  Positive Numeric Value  ***Required***
    ...      The internal ID (primary key) of the Driver in Omnitracs XRS.
    ...      While this field is required for posts and puts, if the user wishes to specify only a DriverID,
    ...      a value of “0” must be provided in this SID field.
    ...      However, this SID value of 0 will be replaced by an internally generated SID value
    ...      - which can be retrieved by the Driver Get method and used in future posts/puts, if desired.
    ...  SendInboundMessageTo  # String  Positive numeric value   ***Required***
    ...      Must be set to at least 0
    ...      The SID of the resource group to which this driver’s inbound messages are sent.
    ...      NOTE: This field is not required for a post or put method call.
    ...      If not provide in a Post method call, this field will be set to the default resource group for the organization to which the driver belongs
    ...      – if one exists.
    ...  SendInboundMessageToID  # String  Positive numeric value  <ResourceGroupSID>  ***Not Required***
    ...      The ResourceGroupID of which group the message was sent to.
    ...  Status  # String  This field must contain either of the following values: Active, Inactive  Default: Active  ***Required***
    ...      The current status of the driver in the Omnitracs XRS. The value of this field must be Active or Inactive.
    ...  UseHOSOrganizationSettings  # Boolean  True, False  Default: False  ***Required***
    ...      Indicates if the Organization Settings are being used for this driver.
    ...  UserDefinedField1  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #1
    ...  UserDefinedField2  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #2
    ...  UserDefinedField3  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #3
    ...  UserDefinedField4  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #4
    ...  UserDefinedField5  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #5
    ...  UserName  # String  3-12 characters  ***Required***
    ...      The username of the driver used to log into Omnitracs XRS.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS}
    ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Put Drivers
    [Arguments]  @{list_data}
    [Documentation]  Calls the Put Method for Drivers.
    ...  Accepts a list of json objects
    ...  Json field definitions:
    ...  CDLExpiration  # DateTime DateTime  ***Not Required***
    ...      The date at which the current CDL expires.
    ...  CDLNumber  # String  Max length=20 characters  ***Not Required***
    ...      The Commercial Driver's License held by the driver. 
    ...      This field supports a maximum of 20 characters.
    ...      Omnitracs XRS 4.60 will prevent the creation of more than one driver record with the same driver’s license number <CDLNumber>.
    ...      To support this change, the Driver Web Service will return an error message if a PUT or 
    ...      POST call is made that attempts to assign a driver’s license number <CDLNumber> to a driver
    ...      when that same number is already assigned to a different driver.
    ...  CellPhone  # String  10 digit phone number with no dashes, parenthesis, or other symbols.  Example: 5551239876  ***Not Required***
    ...      The Mobile phone number of the driver.
    ...      NOTE: This phone number is not required to be the same as the phone number of the device being used for Omnitracs XRS.
    ...  CompanyName  # String  Example: Eastern Fast Trucking Co.  ***Not Required***
    ...      The name of the Company.
    ...  CompanySID  # Long  Positive Numeric Value  ***Not Required***
    ...      The Omnitracs XRS unique System ID of the company.
    ...      This value is generated automatically by Omnitracs XRS and can be retrieved using the GET method.
    ...  CreateDate  # DateTime  DateTime  ***Read Only***
    ...      The date and time the account was created.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  DriverID  # String  example: 4243  Max Length = 20 characters  ***Required***
    ...      The user-defined driver ID.
    ...  ELDExempt  # Boolean  True, False  Default: False  ***Required***
    ...      This field indicates if the driver is exempt from the ELD mandate.
    ...      This field is required for POST and PUT calls.
    ...  ELDExemptExplanation  # String  Maximum of 60 characters  ***Required If ELDExempt is True*** 
    ...      If the ELDExempt field is set to True, this field is required and must contain an explanation as to why this driver is exempt from the ELD mandate.
    ...      This field is required if <ELDExempt> is True.
    ...  EnableBigDay  # Boolean  True, False  Default: False  ***Required***
    ...      Indicates if the driver is allowed to declare a 16-Hour Big Day exemption
    ...  EnableDriverPortal  # Boolean  True, False  ***Required***
    ...      Indicates if the driver is allowed to login to the driver portal
    ...  EnableHOSRule  # String  Semicolon separated list of HOSRuleSID values. See the HOSRuleSID table  for a list of valid HOSRuleSID values.  Valid Values = 1 - 37
    ...      # ***Required***
    ...      The HOSRuleSID value of the appropriate HOS rule set.
    ...      NOTE: The RuleSet value is the SID of the appropriate rule set, NOT the name of the rule set.
    ...      NOTE: When “UseHOSOrganizationSettings” field is set to true, the “EnableHOSRule” value should be blank
    ...  EnablePersonalConveyance  # Boolean  True, False  Default: False  ***Required***
    ...      Indicates if the driver is allowed to take Personal Conveyance
    ...  EnableTimeClock  # Boolean  True, False  Default: False  ***Required***
    ...      Indicates if the driver is using Omnitracs XRS time clock features
    ...  EnableYardMove  # Boolean  True, False  Default: False  ***Required***
    ...      Indicates if yard moves are allowable for this driver.
    ...      This field is required for both PUT and POST calls.
    ...  Endorsements   # String  Max length= 50 characters  ***Not Required***
    ...      Indicates if there are any endorsements on the Driver's CDL
    ...  FirstName  # String  Example: Bill  Max length= 50 characters  ***Required***
    ...      The first name of the driver.
    ...  HomeTelephone  # String  10 digit phone number with no dashes, parenthesis, or other symbols.  Example: 5551239876  ***Not Required***
    ...      The primary telephone number of the driver.
    ...  Language  # String  English French Spanish  Default: English  ***Required***
    ...      The language used by the driver.
    ...  LastLogin  # DateTime  DateTime  ***Not Required***
    ...      The Date and time of the Last Login request.
    ...  LastName  # String  Example: Smith  ***Required***
    ...      The last name of the driver.
    ...  LicenseIssuingCountry  # String  USA Canada  ***Required***
    ...      The country that issued the CDL license. Valid values include:
    ...      USA
    ...      Canada
    ...      This field is required for both POST and PUT calls.
    ...  LicenseIssuingStateProvince  # String  This web service accepts either the full state or province name, or the abbreviation.  ***Required***
    ...      The state or province that issued the CDL license.
    ...      This field is required for both POST and PUT calls.
    ...  MaxConveyanceDistance  # Integer  0-99  ***Not Required***
    ...      The maximum distance this driver is allowed to drive on Personal Conveyance.
    ...  MedicalExp  # DateTime  DateTime  ***Not Required***
    ...      The date at which the current medical exam expires
    ...  MiddleName  # String  Example: Tim  ***Not Required***
    ...      The middle name of the driver.
    ...  ModifiedBy  # Long  Psitive Numeric Value  ***Read Only***
    ...      The SID of the last person to modify the driver record.
    ...  ModifiedDate  # DateTime  DateTime  ***Read Only***
    ...      The date the driver record was last modified.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  OrganizationID  # String  Alphanumeric Value  ***Not Required***
    ...      The user-defined ID of the organization to which the driver belongs.
    ...      Note: Either this field or the OrganizationSID field is required for a post method call, but neither is required for a put method call.
    ...  OrganizationName  # String  Default: [null]  Example: Southeast Transportation Division.  ***Not Required***
    ...      The Organization name.
    ...  OrganizationSID  # Long  Positive Numeric Value  ***Required***
    ...      The XRS-defined System ID of the organization.
    ...      This value is generated automatically by XRS and can be retrieved using the GET method.
    ...      Note: Either this field or the OrganizationSID field is required for a post method call, but neither is required for a put method call.
    ...  Password  # String  <password>  ***Not Required***
    ...      The drivers password.
    ...  PayrollOrganizationSID  # Long  Positive Numeric Value  ***Not Required***
    ...      The SID of the organizations associated with the driver in the integrated payroll system.
    ...      This field will be used for future payroll related web services.
    ...  PayrollSID  # Long  Positive Numeric Value  ***Not Required***
    ...      The SID of the payroll record when using the integrated payroll system
    ...      This value is generated automatically by Omnitracs XRS and can be retrieved using the GET method.
    ...  ResourceGroupIDList  # String  ResourceGroupIDCollection  ***Not Required***
    ...      Indicates the set of ResourceGroupIDs to which the driver belongs.
    ...      NOTE: If a resource group is not provided in a Put call,
    ...      the new Driver is to be placed in the default resource group for the organization to which the new Driver is being added.
    ...  SID  # Long  Positive Numeric Value  ***Required***
    ...      The internal ID (primary key) of the Driver in Omnitracs XRS.
    ...      While this field is required for posts and puts, if the user wishes to specify only a DriverID,
    ...      a value of “0” must be provided in this SID field.
    ...      However, this SID value of 0 will be replaced by an internally generated SID value
    ...      - which can be retrieved by the Driver Get method and used in future posts/puts, if desired.
    ...  SendInboundMessageTo  # String  Alphanumeric value   ***Required***
    ...      The SID of the resource group to which this driver’s inbound messages are sent.
    ...      NOTE: This field is not required for a post or put method call.
    ...      If not provide in a Post method call, this field will be set to the default resource group for the organization to which the driver belongs
    ...      – if one exists.
    ...  SendInboundMessageToID  # String  Positive numeric value  <ResourceGroupSID>  ***Not Required***
    ...      The ResourceGroupID of which group the message was sent to.
    ...  Status  # String  This field must contain either of the following values: Active, Inactive  Default: Active  ***Required***
    ...      The current status of the driver in the Omnitracs XRS. The value of this field must be Active or Inactive.
    ...  UseHOSOrganizationSettings  # Boolean  True, False  Default: False  ***Required***
    ...      Indicates if the Organization Settings are being used for this driver.
    ...  UserDefinedField1  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #1
    ...  UserDefinedField2  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #2
    ...  UserDefinedField3  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #3
    ...  UserDefinedField4  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #4
    ...  UserDefinedField5  # String  Max length=100 characters  ***Not Required***
    ...      User-defined field #5
    ...  UserName  # String  3-12 characters  ***Required***
    ...      The username of the driver used to log into Omnitracs XRS.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS}
    ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Get Drivers
    [Arguments]  &{params}
    [Documentation]  Call the Get Method on Drivers.
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
    ...  ResourceGroupID  # Default Value [No Filter]
    ...     Limits results to devices in one or more resource groups.
    ...  ResourceGroupSID  # Default Value [No Filter]
    ...     Limits results to devices in one or more resource groups.
    ...  ResourceGroupSID  # Default Value [No Filter]
    ...     Limits results to drivers in one or more resource groups.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Drivers With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get devices that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Devices Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Drivers By ID
    [Arguments]  @{drivers_sid}
    [Documentation]  Get attributes for a specific driver by specifying a DriverSID value.
    ...  The DriverSID is the json attribue SID that is autogenerated by XRS.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS}/@{drivers_sid}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Get All Drivers
    [Documentation]  Get attributes for all drivers.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Delete Drivers By IDs
    [Arguments]  ${drivers_sid}
    [Documentation]  Delete a single driver record in Omnitracs XRS by specifying the DriverSID.
    ...  The Delete method supports the deletion of one driver record per call only.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Driver}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_DRIVERS}/${drivers_sid}
    ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Get The nth Active Driver ID
    [Arguments]  ${nth_driver}
    [Documentation]  This keyword pulls a 0 index list of driver json objects and returns the nth driver ID.
    ...  The argument ${nth_driver} must be an integer.
    ${driver_response} =  Get Drivers  IsActive=True
    ${driver_response_json} =  To Json  ${driver_response.content}
    &{get_first_active_driver} =  Set Variable  @{driver_response_json}[${nth_driver}]
    [Return]  ${get_first_active_driver.DriverID}