*** Settings ***
Documentation  Keyword library for interacting with the Performance > Daily Detail Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL} =  /dailydetail
${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_DRIVER_ID} =  /dailydetail/drivers
${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_VEHICLE_ID} =  /dailydetail/vehicles

*** Keywords ***
Get Daily Detail
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Daily Detail.
  ...  This will get Daily Details that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # DateTime  [1900-01-01T00:00:00] DateTime  Default Value = Current Date
  ...    [Current Date] - Limits results to DailyDetail objects that have been added or edited today
  ...    [DateTime] - DailyDetail objects that were added or edited since the specified date and time will be returned.
  ...    Maximum Value = Current Date - 7 days
  ...    Time = All time values are ignored
  ...  StartDate  # DateTime  [1900-01-01T00:00:00]  Current DateTime – 182 days  Time = 12:00:00 AM if not provided
  ...    Limits results to all Daily Detail objects that span the time from this date to the date as defined in the EndDate argument.
  ...  EndDate  # DateTime  [1900-01-01T00:00:00]  StartDateTime + 7 days  Time = 11:59:59 PM if not provided
  ...    Limits results to all Daily Detail objects that span the time from the date as defined in the StartDate argument to this date.
  ...  GroupBy  # String  drtiver, Vehicle  Default: Driver
  ...    The GroupBy parameter can be used to specify whether to return data grouped by driver or vehicle.
  ...    If no GroupBy parameter is specified, the GroupBy parameter will use the default value of "Driver".
  ...    This parameter is intended for use with the /DailyDetail Web Service only.
  ...    The GroupBy parameter is not applicable to the /DailyDetail/Vehicles or /DailyDetail/Drivers Web Services.
  ...  IncludeHistory  # Boolean  True, False  Default: False
  ...    True - Limits the results to all Daily Detail objects within resourcegroupID within organizationID
  ...      including historical information for Drivers & Vehicles assigned to a different organization.
  ...    NOTE: The "Include History" option is not available when the report is sorted by Organization.
  ...    False - Limits the results to all Daily Detail objects within resourcegroupID within organizationID
  ...    NOTE: This field is required when making a GET call with this Web Service.
  ...  Limit  # Long  0-10000  Default Value 5000
  ...    Used in conjunction with the Offset parameter to implement paging.
  ...    Limits the number of results to a specified number.
  ...    System Limit: 10,000
  ...  Offset  # Long  Default Value 1
  ...    Used in conjunction with the Limit parameter to implement paging.
  ...    Represents a page number for the starting point of the return set.
  ...  OrganizationID  # String  [OrganizationID]  ***Required***
  ...    Limits results to Daily Detail objects that belong to the specified Organization.
  ...    NOTE: This field is REQUIRED when performing a GET call to this Web Service.
  ...  ResourceGroupID  # Long  Default: [No Filter]
  ...    Limits results to sites in one or more resource groups.
  ...    [No Filter] - Limits results to all Daily Detail objects within all resource groups within organizationIDs
  ...      (as specified by OrganizationID field).
  ...    [ResourceGroupID] - Limits results to all Daily Detail objects within OrganizationID
  ...      (as specified by OrganizationID field) and ResourceGroupID.
  ...  DriverID  # String  Alphanumeric  Max Length: 20 characters
  ...    Limits results to Daily Detail objects for the specified DriverID:
  ...    [No Filter] - Limits the results to all Daily Detail objects within resourcegroupID within organizationID
  ...    [DriverID] - Limits the results to all Daily Detail objects for DriverID within resourcegroupID within organizationID
  ...  VehicleID  # String  Alphanumeric  Max Length: 20 characters
  ...    Limits results to Daily Detail objects for the specified VehicleID:
  ...    [No Filter] - Limits the results to all Daily Detail objects within resourcegroupID within organizationID
  ...    [VehicleID] - Limits the results to all Daily Detail objects for VehicleID within resourcegroupID within organizationID
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Daily Details With Organization ID
  [Arguments]  ${organizationID}
  [Documentation]  Get all Daily Details
  ...  Organization ID Is a required parameter
  &{params} =  Create Dictionary  OrganizationID=${organizationID}
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Daily Detail With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get critical events summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Daily Detail" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

# Get Summaries by Driver ID
Get Daily Detail By Driver ID And Parameters
  [Arguments]  ${driver_id}  ${params}
  [Documentation]  Call the Get Method on Daily Detail By Driver ID.
  ...  This will get Daily Details that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Daily Detail" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_DRIVER_ID}/${driver_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Daily Details By Driver ID
  [Arguments]  ${driver_id}
  [Documentation]  Get all Daily Details by Driver ID
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_DRIVER_ID}/${driver_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Daily Detail By Driver ID ${driver_id} With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get critical events summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Daily Detail" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_DRIVER_ID}/${driver_id}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

# Get Summaries by Vehicle ID
Get Daily Detail By Vehicle ID And Parameters
  [Arguments]  ${vehicle_id}  ${params}
  [Documentation]  Call the Get Method on Daily Detail By Vehicle ID.
  ...  This will get Daily Details that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Daily Detail" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Daily Details By Vehicle ID
  [Arguments]  ${vehicle_id}
  [Documentation]  Get all Daily Details by Vehicle ID
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Daily Detail By Vehicle ID ${vehicle_id} With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get critical events summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Daily Detail" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Daily_Detail}${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_VEHICLE_ID}/${vehicle_id}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

  # Helper Keywords
Get Daily Detail Response Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Daily Detail  &{params}
  [Return]  ${response}

Get Daily Detail Response With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Daily Detail With URI Ending With / And Parameters &{params}
  [Return]  ${response}

Get Daily Detail Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With
  ...  ${XRS_Performance_Base_URI.Daily_Detail}
  ...  ${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL}
  ...  ${character_string}
  ...  ${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri_string}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Helper Keywords For Get Daily Detail Summaries By Driver ID
Get Daily Detail By Driver ID Response Without Forward Slash
  [Arguments]  ${driver_id}  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Daily Detail By Driver ID And Parameters  ${driver_id}  ${params}
  [Return]  ${response}

Get Daily Detail By Driver ID Response With Forward Slash
  [Arguments]  ${driver_id}  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Daily Detail By Driver ID ${driver_id} With URI Ending With / And Parameters ${params}
  [Return]  ${response}

Get Daily Detail By Driver ID ${driver_id} Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With
  ...  ${XRS_Performance_Base_URI.Daily_Detail}
  ...  ${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_DRIVER_ID}/${driver_id}
  ...  ${character_string}
  ...  ${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri_string}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Helper Keywords For Get Daily Detail Summaries By Vehicle ID
Get Daily Detail By Vehicle ID Response Without Forward Slash
  [Arguments]  ${vehicle_id}  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Daily Detail By Vehicle ID And Parameters  ${vehicle_id}  ${params}
  [Return]  ${response}

Get Daily Detail By Vehicle ID Response With Forward Slash
  [Arguments]  ${vehicle_id}  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Daily Detail By Vehicle ID ${vehicle_id} With URI Ending With / And Parameters ${params}
  [Return]  ${response}

Get Daily Detail By Vehicle ID ${vehicle_id} Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With
  ...  ${XRS_Performance_Base_URI.Daily_Detail}
  ...  ${XRS_WEBSERVICE_PERFORMANCE_GET_DAILY_DETAIL_BY_VEHICLE_ID}/${vehicle_id}
  ...  ${character_string}
  ...  ${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri_string}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}