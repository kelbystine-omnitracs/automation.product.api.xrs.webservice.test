*** Settings ***
Documentation  Keyword library for interacting with the Performance > Black Box Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY} =  /blackboxsummary
${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_DRIVER_ID} =  /blackboxsummary/driver
${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_VEHICLE_ID} =  /blackboxsummary/vehicle

*** Keywords ***
Get Black Box Summary
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Black Box Summary.
  ...  This will get Black Box Events that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # DateTime  [1900-01-01T00:00:00] DateTime  Default Value [No Filter]
  ...    Tells the service to return only the data that changed since the specified date and time.
  ...    This time span is limited to 1 hour.
  ...    System Limit: 1 hour
  ...  DriverID  # String  Alphanumeric  Max Length: 20 characters
  ...    Limits results to Black Box event records for one or more vehicles.
  ...    [No Filter] - Limits results to all Black Box event records within resource groups that are associated with the Web Service User ID.
  ...    [DriverID] - Limits results to the specified DriverID.
  ...  Limit  # Long  0-10000  Default Value 5000
  ...    Used in conjunction with the Offset parameter to implement paging.
  ...    Limits the number of results to a specified number.
  ...    System Limit: 10,000
  ...  Offset  # Long  Default Value 0
  ...    Used in conjunction with the Limit parameter to implement paging.
  ...    Represents a page number for the starting point of the return set.
  ...  VehicleID  # String  Alphanumeric  Max Length: 20 characters
  ...    Limits results to Black Box event records for one or more vehicles.
  ...    [No Filter] - Limits results to all Black Box event records within resource groups that are associated with the Web Service User ID.
  ...    [VehicleID] - Limits results to the specified VehicleID.
  ...  StartDate  # DateTime  Format = yyyy-dd-mmT:hh:mm:ss  Max Date = Current DateTime – 92 days  Max Time = -1 hour prior to  EndDateTime
  ...    Limits results to all Black Box Event objects that span the time from the StartDateTime to EndDateTime arguments.
  ...    This time span is limited to 1 hour but the StartDateTime can be 92 days earlier than the current date.
  ...  EndDate  # DateTime  [1900-01-01T00:00:00]  Time = 11:59:59 PM if not provided
  ...    Limits results to all Black Box Event objects that span the time from the date as defined in the StartDateTime argument to this date.
  ...    This time span is limited to 1 hour but the StartDateTime can be 92 days earlier than the current date.
  ...  IncludeHistory  # Boolean  True, False  Default: False
  ...    True - Limits the results to all Operation Summary objects within the resourcegroupID and organizationID,
  ...      including historical information for Drivers and Vehicles assigned to a different organization.
  ...    The "Include History" option is not available when the report is sorted by Organization.
  ...    False - Limits the results to all Operation Summary objects within the  resourcegroupID and organizationID.
  ...  OrderDirection  # String  Ascending, Descending  Default: Descending
  ...    Determines the order results are returned. Valid values are:
  ...      Descending - Results returned with most recently arrived first.
  ...      Ascending - Results returned with most recently arrived last.
  ...    The default value is Descending.
  ...  OrganizationID  # String  Default Value [No Filter]
  ...    Limits results to events in one or more organizations.
  ...  OnlyShowEventsWithVideo  # Boolean  Default Value [No Filter]
  ...    Limits results to events with or without video.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Black Box Summaries
  [Documentation]  Get all Black Box summaries
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Black Box Summary With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get black box summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Black Box Summary" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

# Get Summaries by Driver ID
Get Black Box Summary By Driver ID And Parameters
  [Arguments]  ${driver_id}  ${params}
  [Documentation]  Call the Get Method on Black Box Summary By Driver ID.
  ...  This will get Black Box Events that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Black Box Summary" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_DRIVER_ID}/${driver_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Black Box Summaries By Driver ID
  [Arguments]  ${driver_id}
  [Documentation]  Get all Black Box summaries by Driver ID
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_DRIVER_ID}/${driver_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Black Box Summary By Driver ID ${driver_id} With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get black box summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Black Box Summary" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_DRIVER_ID}/${driver_id}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

# Get Summaries by Vehicle ID
Get Black Box Summary By Vehicle ID And Parameters
  [Arguments]  ${vehicle_id}  ${params}
  [Documentation]  Call the Get Method on Black Box Summary By Vehicle ID.
  ...  This will get Black Box Events that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Black Box Summary" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Black Box Summaries By Vehicle ID
  [Arguments]  ${vehicle_id}
  [Documentation]  Get all Black Box summaries by Vehicle ID
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Black Box Summary By Vehicle ID ${vehicle_id} With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get black box summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Black Box Summary" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Black_Box}${XRS_WEBSERVICE_PERFORMANCE_GET_BLACK_BOX_SUMMARY_BY_VEHICLE_ID}/${vehicle_id}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}