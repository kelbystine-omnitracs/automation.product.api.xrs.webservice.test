*** Settings ***
Documentation  Keyword library for interacting with the Entity > Trailer Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_TRAILER} =  /trailer
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS} =  /trailers
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_TRAILER_V2} =  /v2/trailer
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS_V2} =  /v2/trailers

*** Keywords ***
Get Trailer By ID
    [Arguments]  ${trailer_id}
    [Documentation]  Get attributes for a specific trailer by specifying a TrailerSID value.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_TRAILER}/${trailer_id}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Delete Trailer By ID
    [Arguments]  ${trailer_id}
    [Documentation]  Delete a single trailer record in Omnitracs XRS by specifying the TrailerSID.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_DELETE_TRAILER}/${trailer_id}
    ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Post Trailers
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Trailers.
    ...  Accepts a list of json objects
    ...  Json field definitions:
    ...  CompanyName  # String  Alpha-numeric  ***Not Required***
    ...      The user defined name of the company.
    ...  CreateDate  # DateTime  [1900-01-01T00:00:00] DateTime  ***Read Only***
    ...      The date and time the trailer object was created.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  ModifiedBy  # Long  Positive Numeric Value  ***Read Only***
    ...      The ID of the last person to modify the driver record.
    ...  ModifiedDate  # DateTime  DateTime  ***Read Only***
    ...      Date driver record was last modified.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  OrganizationID  # String  Alphanumeric Value  ***Required***
    ...      The user-defined ID of the Organization in Omnitracs XRS  in which the trailer is located.
    ...  OrganizationName  # String  Alpha Numeric Value  ***Not Required***
    ...      The user-defined name of the organization in which the trailer is located.
    ...  StateName  # String  [State/Province Name]  ***Required***
    ...      The state, province or territory for the trailer.
    ...  Status  # String  [Active] Inactive  ***Required***  ***Not Required***
    ...      The current status of the trailer in the Omnitracs XRS. The value of this field must be Active or Inactive.
    ...  TrailerIdentity  # String  Max 20 characters  ***Required***
    ...      The user-defined ID of the trailer.
    ...  TrailerResourceGroupIDs  # String  ResourceGrouID  ***Not Required***
    ...      Indicates the set of ResourceGroupIDs to which the trailers should belong.
    ...  TrailerType  # String General, Chassis, Dolly  ***Not Required***
    ...      The type of trailer.
    ...  VIN  # String  [null]  Length 17-19 characters  ***Not Required***
    ...      The registered Vehicle Identification Number (VIN) of the trailer.
    ...      NOTE: This non-required field is reserved for future use.
    ...      Web Service calls made to retrieve the value of this field will return a null value at this time.   
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}
    ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Put Trailers
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Trailers.
    ...  Accepts a list of json objects
    ...  See Json field definitions in the "Post Trailers" Keyword 
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}
    ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}


Get Trailers
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on trailers.
  ...  This will get trailers that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [No Filter]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...  IsActive  # Default Value [No Filter]
  ...      Filters results to active trailers only.
  ...      True, False, Both
  ...  Limit  # Default Value 100
  ...      Used in conjunction with the Offset parameter to implement paging.
  ...      Limits the number of results to a specified number.
  ...      System Limit: 10,000
  ...  Offset  # Default Value 1
  ...      Used in conjunction with the Limit parameter to implement paging.
  ...      Represents a page number for the starting point of the return set.
  ...  OrganizationID  # Default Value [No Filter]
  ...      Limits results to trailers in one or more organizations.
  ...      Maximum of 20 characters.
  ...  Recurse  # Default Value True
  ...      When True, limits results to all trailer objects in all OrganizationIDs and ResourceGroupIDs in OrganizationID & ResourceGroupID.
  ...  ResourceGroupID  # Default Value [No Filter]
  ...      Limits results to trailers in one or more resource groups.
  ...  ResourceGroupSID  # Default Value [No Filter]
  ...      Limits results to Organizations in one or more resource groups.
  ...      Maximum of 50 characters.
  ...  Status  # Default Value [No Filter]
  ...      Limits results to trailers with the selected status. Valid values include:
  ...      IsActive - Limits results to all active trailer objects in OrganizationID & ResourceGroupID.
  ...      IsInActive - Limits results to all inactive trailer objects within all OrganizationID and ResourceGroupID.
  ...  TrailerID  # Default Long - Positive Numeric Value
  ...      Limits the results to trailer objects with TrailerID in OrganizationID and ResourceGroupID.
  ...      Maximum of 20 characters.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Trailers With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get trailers that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Trailers Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Trailers
  [Documentation]  Get attributes for all trailers.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Trailer V2 Web Service Keywords
Get Trailer V2 By ID
    [Arguments]  ${trailer_id}
    [Documentation]  Get attributes for a specific trailer by specifying a TrailerSID value.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_TRAILER_V2}/${trailer_id}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Post Trailers V2
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Trailers.
    ...  Accepts a list of json objects
    ...  Json field definitions:
    ...  CompanyName  # String  Alpha-numeric  ***Not Required***
    ...      The user defined name of the company.
    ...  CreateDate  # DateTime  [1900-01-01T00:00:00] DateTime  ***Read Only***
    ...      The date and time the trailer object was created.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  ModifiedBy  # Long  Positive Numeric Value  ***Read Only***
    ...      The ID of the last person to modify the driver record.
    ...  ModifiedDate  # DateTime  DateTime  ***Read Only***
    ...      Date driver record was last modified.
    ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
    ...  OrganizationID  # String  Alphanumeric Value  ***Required***
    ...      The user-defined ID of the Organization in Omnitracs XRS  in which the trailer is located.
    ...  OrganizationName  # String  Alpha Numeric Value  ***Not Required***
    ...      The user-defined name of the organization in which the trailer is located.
    ...  StateName  # String  [State/Province Name]  ***Required***
    ...      The state, province or territory for the trailer.
    ...  Status  # String  [Active] Inactive  ***Required***  ***Not Required***
    ...      The current status of the trailer in the Omnitracs XRS. The value of this field must be Active or Inactive.
    ...  TrailerIdentity  # String  Max 20 characters  ***Required***
    ...      The user-defined ID of the trailer.
    ...  TrailerResourceGroupIDs  # String  ResourceGrouID  ***Not Required***
    ...      Indicates the set of ResourceGroupIDs to which the trailers should belong.
    ...  TrailerType  # String General, Chassis, Dolly  ***Not Required***
    ...      The type of trailer.
    ...  VIN  # String  [null]  Length 17-19 characters  ***Not Required***
    ...      The registered Vehicle Identification Number (VIN) of the trailer.
    ...      NOTE: This non-required field is reserved for future use.
    ...      Web Service calls made to retrieve the value of this field will return a null value at this time.
    ...  Country  # String  [None]  USA, Canada  ***Required***
    ...      The country where the trailer is based.
    ...      NOTE: This field is used only with Version 2 of this Web Service.
    ...  LicensePlate  # String  [null]  Alpha-numeric  ***Not Required***
    ...      The LicensePlate of the vehicle attached to the trailer.
    ...      NOTE: This field is used only with Version 2 of this Web Service.
    ...  Odomoter  # Integer  [null]  Positive Numeric Value  ***Not Required***
    ...      The last Odometer reading from the trailer.
    ...      NOTE: This field is used only with Version 2 of this Web Service.
    ...  SerialNumber  # String  Length = Maximum of 20 characters.  ***Not Required***
    ...      The serial number of the trailer, if available.
    ...      NOTE: This field is used only with Version 2 of this Web Service.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}
    ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Put Trailers V2
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Trailers.
    ...  Accepts a list of json objects
    ...  See Json field definitions in the "Post Trailers" Keyword 
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}
    ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Get Trailers V2
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on trailers v2.
  ...  This will get trailers that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [No Filter]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...  IsActive  # Default Value [No Filter]
  ...      Filters results to active trailers only.
  ...      True, False, Both
  ...  Limit  # Default Value 100
  ...      Used in conjunction with the Offset parameter to implement paging.
  ...      Limits the number of results to a specified number.
  ...      System Limit: 10,000
  ...  Offset  # Default Value 1
  ...      Used in conjunction with the Limit parameter to implement paging.
  ...      Represents a page number for the starting point of the return set.
  ...  OrganizationID  # Default Value [No Filter]
  ...      Limits results to trailers in one or more organizations.
  ...      Maximum of 20 characters.
  ...  Recurse  # Default Value True
  ...      When True, limits results to all trailer objects in all OrganizationIDs and ResourceGroupIDs in OrganizationID & ResourceGroupID.
  ...  ResourceGroupID  # Default Value [No Filter]
  ...      Limits results to trailers in one or more resource groups.
  ...  ResourceGroupSID  # Default Value [No Filter]
  ...      Limits results to Organizations in one or more resource groups.
  ...      Maximum of 50 characters.
  ...  Status  # Default Value [No Filter]
  ...      Limits results to trailers with the selected status. Valid values include:
  ...      IsActive - Limits results to all active trailer objects in OrganizationID & ResourceGroupID.
  ...      IsInActive - Limits results to all inactive trailer objects within all OrganizationID and ResourceGroupID.
  ...  TrailerID  # Default Long - Positive Numeric Value
  ...      Limits the results to trailer objects with TrailerID in OrganizationID and ResourceGroupID.
  ...      Maximum of 20 characters.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS_V2}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Trailers V2 With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get trailers that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Trailers V2 Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS_V2}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Trailers V2
  [Documentation]  Get attributes for all trailers v2.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Trailer}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS_V2}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Helper Keywords
Get Trailers Response Code Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Trailers  &{params}
  [Return]  ${response.status_code}

Get Trailers Response Code With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Trailers With URI Ending With / And Parameters &{params}
  [Return]  ${response.status_code}

Get Trailers Raw String URI Response Code With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Trailer}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_TRAILERS}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response.status_code}