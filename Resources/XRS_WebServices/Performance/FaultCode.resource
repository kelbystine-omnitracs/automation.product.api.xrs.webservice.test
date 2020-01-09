*** Settings ***
Documentation  Keyword library for interacting with the Performance > Fault Code Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES} =  /FaultCodes
${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES_BY_VEHICLE_ID} =  /FaultCodes/vehicle

*** Keywords ***
Get Fault Codes
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Fault Codes.
  ...  This will get Fault Codes that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  StartDate  # DateTime  [1900-01-01T00:00:00]  Current DateTime – 6 months  Time = 12:00:00 AM if not provided
  ...    Limits results to all Fault Code objects within all resource groups within organizationIDs (as specified by OrganizationID field).
  ...    This value must be 6 months or less from the current date and time.
  ...  EndDate  # DateTime  [1900-01-01T00:00:00]  FromDateTime + 90 days  Time = 11:59:59 PM if not provided
  ...    Limits results to all Fault Code objects that span the time from the date as defined in the FromDateTime argument to this date.
  ...  AsOfDateTime  # DateTime?  7-90 days  Default: 7 days
  ...    Limits results to all Fault Code objects that span the time from this date to the date as defined in the ToDateTime argument.
  ...    This time span must be limited to 90 days.
  ...    The maximum value allowed is a function of the Canadian regulations governing records availability.
  ...  VehicleID  # String  Alphanumeric  Max Length: 20 characters  [none]
  ...    Limits results to all Fault Code objects that span the time from the date as defined in the FromDateTime argument to this date.
  ...    # Limits results to Fault Codes records for one or more vehicles.
  ...    # [No Filter] - Limits results to all Fault Codes records within resource groups that are associated with the Web Service User ID.
  ...    # [VehicleID] - Limits results to the specified VehicleID.
  ...  Limit  # Long  0-10000  Default Value 5000
  ...    Used in conjunction with the Offset parameter to implement paging.
  ...    Limits the number of results to a specified number.
  ...    System Limit: 10,000
  ...  Offset  # Long  Default Value 0
  ...    Used in conjunction with the Limit parameter to implement paging.
  ...    Represents a page number for the starting point of the return set.
  ...  OrganizationID  # String  Default Value [No Filter]
  ...    Limits results to all Fault Code objects within the company.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Fault_Code}${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Fault Codes
  [Documentation]  Get all Fault Codes
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Fault_Code}${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Fault Codes With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get fault codes that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Fault Codes" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Fault_Code}${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

# Get Fault Codes by Vehicle ID
Get Fault Codes By Vehicle ID And Parameters
  [Arguments]  ${vehicle_id}  ${params}
  [Documentation]  Call the Get Method on Fault Code By Vehicle ID.
  ...  This will get Fault Codes that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Fault Code" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Fault_Code}${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Fault Codes By Vehicle ID
  [Arguments]  ${vehicle_id}
  [Documentation]  Get all Fault Codes by Vehicle ID
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Fault_Code}${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Fault Codes By Vehicle ID ${vehicle_id} With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get fault codes that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Fault Code" Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Fault_Code}${XRS_WEBSERVICE_PERFORMANCE_GET_FAULT_CODES_BY_VEHICLE_ID}/${vehicle_id}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}