*** Settings ***
Documentation  Keyword library for interacting with the Performance > Operation Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_PERFORMANCE_GET_PROFILE} =  /Profile
${XRS_WEBSERVICE_PERFORMANCE_GET_PROFILE_BY_DRIVER_ID} =  /Profile/driver
${XRS_WEBSERVICE_PERFORMANCE_GET_PROFILE_BY_VEHICLE_ID} =  /Profile/vehicle
${XRS_WEBSERVICE_PERFORMANCE_GET_SUMMARY} =  /Summary
${XRS_WEBSERVICE_PERFORMANCE_GET_SUMMARY_BY_DRIVER_ID} =  /Summary/driver
${XRS_WEBSERVICE_PERFORMANCE_GET_SUMMARY_BY_VEHICLE_ID} =  /Summary/vehicle

*** Keywords ***
Get Profile
  [Arguments]  &{params}
  [Documentation]  Params:
  ...  AsOfDateTime  # DateTime  [1900-01-01T00:00:00]
  ...    Max = CurrentDateTime – 184 days
  ...    Default value is current day - 30 days.
  ...    Limits results to Operation Profile objects that have been added or edited today.
  ...  StartDate or FromDateTime  # DateTime [1900-01-01T00:00:00]
  ...    Current DateTime – 184 days
  ...    Time = 12:00:00 AM if not provided
  ...    Limits results to all Operation Profile objects that span the time from this date to the date as defined in the ToDateTime argument.
  ...  EndDate or ToDateTime  # DateTime [1900-01-01T00:00:00]
  ...    FromDateTime + 180 days
  ...    Time = 11:59:59 PM if not provided
  ...    Limits results to all Operation Profile objects that span the time from the date as defined in the FromDateTime argument to this date.
  ...  IncludeHistory  # Boolean  True, False  Default: False
  ...    True - Limits the results to all Operation Profile objects within the resourcegroupID and organizationID,
  ...      including historical information for Drivers and Vehicles assigned to a different organization.
  ...    NOTE: The "Include History" option is not available when the report is sorted by Organization.
  ...    False - Limits the results to all Operation Profile objects within resourcegroupID within organizationID
  ...  IsActive  # Boolean True, False, both  Default: True
  ...    both - Limits results to all Operation Profile objects for active & inactive vehicle or driver objects in OrganizationID and ResourceGroupID.
  ...    True - Limits results to all Operation Profile  objects for active vehicle or driver objects in OrganizationID and ResourceGroupID.
  ...    False - Limits results to all site objects within the specified OrganizationID.
  ...  Limit  # Long  0-10000  Default: 5000
  ...    Used in conjunction with the Offset parameter to implement paging.
  ...    Limits the number of results to a specified number.
  ...    System Limit: 10,000
  ...  Offset  # Long  Default: 0
  ...    Used in conjunction with the Limit parameter to implement paging.
  ...    Represents a page number for the starting point of the return set.
  ...  OrganizationID  # String  [OrganizationID]
  ...    Limits results to Operation Profile objects in one or more organizations.
  ...    [No Filter] - Limits results to all Operation Profile objects within organizations that are associated with the Web Service User ID.
  ...    [OrganizationID] - Limits results to Operation Profile objects that belong to the specified Organization.
  ...  Recurse  # Boolean  True, False  Default: False
  ...    True - Limits results to all Operation Profile objects in the hierarchy of organizations within the specified OrganizationID.
  ...    False - Limits results to all Operation Profile objects within specified OrganizationID.
  ...  ResourceGroupID  # Long  Default: [No Filter]
  ...    Limits results to sites in one or more resource groups.
  ...    [No Filter] - Limits results to all Operation Profile details within resource groups that are associated with the Web Service User ID.
  ...    [ResourceGroupID] - Limits results to the specified Resource Group ID.
  ...  DriverID  # String  [DriverID]
  ...    Limits results to Operation Profile objects for the specified DriverID:
  ...    [No Filter] - Limits results to all driver details within resource groups that are associated with the Web Service User ID. 
  ...    [DriverID] - Limits results to the specified DriverID.
  ...  VehicleID  # String  [VehicleID]
  ...    Limits results to Operation Profile objects for the specified VehicleID:
  ...    [No Filter] - Limits results to all vehicle details within resource groups that are associated with the Web Service User ID.
  ...    [DriverID] - Limits results to the specified VehicleID.
  ...  GroupBy  # String  Default: [No Filter]
  ...    Organization, Driver, Vehicle
  ...    If Orgnaization is chosen, Resource Groups should not be indicated. (?)
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Operation}${XRS_WEBSERVICE_PERFORMANCE_GET_PROFILE}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Profile By Driver ID
  [Arguments]  ${driver_id}  &{params}
  [Documentation]  Call the Get Method on Profile By Driver ID.
  ...  This will get Profiles that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Profile" Keyword for param definitions.
  ...  Params:
  ...  StartDate={STARTDATE}
  ...  EndDate={ENDDATE}
  ...  AsOfDateTime={ASOFDATETIME}
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Operation}${XRS_WEBSERVICE_PERFORMANCE_GET_PROFILE_BY_DRIVER_ID}/${driver_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}
  

Get Profile By Vehicle ID
  [Arguments]  ${vehicle_id}  &{params}
  [Documentation]  Call the Get Method on Profile By Vehicle ID.
  ...  This will get Profiles that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Profile" Keyword for param definitions.
  ...  Params:
  ...  StartDate={STARTDATE}
  ...  EndDate={ENDDATE}
  ...  AsOfDateTime={ASOFDATETIME}
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Operation}${XRS_WEBSERVICE_PERFORMANCE_GET_PROFILE_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Summary
  [Arguments]  &{params}
  [Documentation]  Params:
  ...  AsOfDateTime  # DateTime  [1900-01-01T00:00:00]
  ...    Default: Current day - 30 days
  ...    Max = 30 days
  ...    All time values are ignored
  ...    Limits results to Operation Profile objects that have been added or edited today.
  ...  StartDate  # DateTime [1900-01-01T00:00:00]
  ...    Current DateTime – 184 days
  ...    Time = 12:00:00 AM if not provided
  ...    Limits results to all Operation Summaryobjects that span the time from this date to the date as defined in the ToDateTime argument.
  ...  EndDate  # DateTime [1900-01-01T00:00:00]
  ...    FromDateTime + 180 days
  ...    Time = 11:59:59 PM if not provided
  ...    Limits results to all Operation Summaryobjects that span the time from the date as defined in the FromDateTime argument to the EndDate value.
  ...  IncludeHistory  # Boolean  True, False  Default: False
  ...    True - Limits the results to all Operation Summary objects within the resourcegroupID and organizationID,
  ...      including historical information for Drivers and Vehicles assigned to a different organization.
  ...    NOTE: The "Include History" option is not available when the report is sorted by Organization.
  ...    False - Limits the results to all Operation Summary objects within the resourcegroupID and organizationID.
  ...  IsActive  # Boolean True, False, both  Default: True
  ...    both - Limits results to all Operation Summary objects for active & inactive vehicle or driver objects in OrganizationID and ResourceGroupID.
  ...    True - Limits results to all Operation Summary objects for active vehicle or driver objects in OrganizationID and ResourceGroupID.
  ...    False - Limits results to all site objects within the specified OrganizationID.
  ...  Limit  # Long  0-10000  Default: 5000
  ...    Used in conjunction with the Offset parameter to implement paging.
  ...    Limits the number of results to a specified number.
  ...    System Limit: 10,000
  ...  Offset  # Long  Default: 0
  ...    Used in conjunction with the Limit parameter to implement paging.
  ...    Represents a page number for the starting point of the return set.
  ...  OrganizationID  # String  [OrganizationID]
  ...    Limits results to Operation Summary objects in one or more organizations.
  ...    [No Filter] - Limits results to all Operation Summary objects within organizations that are associated with the Web Service User ID. 
  ...    [OrganizationID] - Limits results to Operation Summary objects that belong to the specified Organization.
  ...  Recurse  # Boolean  True, False  Default: False
  ...    True - Limits results to all Operation Summary objects in the hierarchy of organizations within the specified OrganizationID.
  ...    False - Limits results to all Operation Summary objects within specified OrganizationID.
  ...  ResourceGroupID  # Long  Default: [No Filter]
  ...    Limits results to sites in one or more resource groups.
  ...    [No Filter] - Limits results to all Operation Summary details within resource groups that are associated with the Web Service User ID.
  ...    [ResourceGroupID] - Limits results to the specified Resource Group ID.
  ...  DriverID  # String  [DriverID]
  ...    Limits results to Operation Summary objects for the specified DriverID:
  ...    [No Filter] - Limits results to all driver details within resource groups that are associated with the Web Service User ID. 
  ...    [DriverID] - Limits results to the specified DriverID.
  ...  VehicleID  # String  [VehicleID]
  ...    Limits results to Operation Summary objects for the specified VehicleID:
  ...    [No Filter] - Limits results to all vehicle details within resource groups that are associated with the Web Service User ID.
  ...    [DriverID] - Limits results to the specified VehicleID.
  ...  GroupBy  # String  Default: [No Filter]
  ...    Organization, Driver, Vehicle
  ...    If Orgnaization is chosen, Resource Groups should not be indicated. (?)
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Operation}${XRS_WEBSERVICE_PERFORMANCE_GET_SUMMARY}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Summary By Driver ID
  [Arguments]  ${driver_id}  &{params}
  [Documentation]  Call the Get Method on Summary By Driver ID.
  ...  This will get Summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Summary" Keyword for param definitions.
  ...  Params:
  ...  StartDate={STARTDATE}
  ...  EndDate={ENDDATE}
  ...  AsOfDateTime={ASOFDATETIME}
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Operation}${XRS_WEBSERVICE_PERFORMANCE_GET_SUMMARY_BY_DRIVER_ID}/${driver_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Summary By Vehicle ID
  [Arguments]  ${vehicle_id}  &{params}
  [Documentation]  Call the Get Method on Summary By Vehicle ID.
  ...  This will get Summaries that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the "Get Summary" Keyword for param definitions.
  ...  Params:
  ...  StartDate={STARTDATE}
  ...  EndDate={ENDDATE}
  ...  AsOfDateTime={ASOFDATETIME}
  ${uri} =  Set Variable  ${XRS_Performance_Base_URI.Operation}${XRS_WEBSERVICE_PERFORMANCE_GET_SUMMARY_BY_VEHICLE_ID}/${vehicle_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}