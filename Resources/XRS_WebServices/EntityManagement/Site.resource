*** Settings ***
Documentation  Keyword library for interacting with the Entity > Site Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE} =  /sites

*** Keywords ***
Post Sites
  [Arguments]  @{list_data}
  [Documentation]  Calls the Post Method on Organizations.
  ...  Accepts a list of json objects
  ...  Json field definitions (POST/PUT requirements):
  ...  Address  # String  Alpha Numeric Value  ***Not Required***
  ...    The address of the site.
  ...  ArrivalGeoCodeType  # String  Circle Polygon  Default: Circle  ***Required***  ***Not Required***
  ...    Indicates whether the site area is defined as a circle or a polygon
  ...  ArrivalPolygonPoints  # String  Alphanumeric string of latitude and longitude coordinates.​​  ***Not Required***
  ...    The collection of lat/long pairs for each point that defines the boundaries of the polygon.
  ...  ArrivalRadius  # Double  x.xxxx  Default: 500  ***Required***
  ...    Arrival perimeter of CIRCLE GeoCode site.
  ...    The arrival circle characteristics are also used in site lookups throughout the system.​
  ...  City  # String  AlphaNumeric Value  ***Required***
  ...    The name of the city where the site is located.
  ...  Country  # String  AlphaNumeric Value  ***Required***
  ...    The name of the country where the site is located.
  ...  CreateDate  # DateTime  [1900-01-01T00:00:00] DateTime  ***Read Only***
  ...    The date and time the site object was created.  
  ...    The value of this field is Read Only and cannot be modified using PUT or POST commands.
  ...  DeliveryWindows  # [Collection]  ***Not Required***
  ...    Delivery Windows Collection Field Definitions:
  ...      BeginTime  # Time  Hour and half-hour times in 24-hour format  ***Not Required***
  ...        The beginning time of the delivery window.
  ...      DayOfWeek  # String  Comma Separated List of Days Of The Week  ***Not Required***
  ...        The day to which the delivery window applies.
  ...        When multiple days are provided using a comma separated list,
  ...        the values provided in the BeginTime and EndTime fields will apply to all days provided in the list.
  ...      EndTime  # Time  Hour and half-hour times in 24-hour format  ***Not Required***
  ...        The ending time of the delivery window.
  ...      IsAllowDelivery  # String [Boolean]  [True]  False  ***Not Required***
  ...        The type of delivery window.
  ...        A value of true indicates that deliveries are allowed during this window.
  ...        A value of false indicates deliveries are not allowed during this window.
  ...  DepartureGeoCodeType  # String  Circle Polygon  ***Required***  ***Not Required***
  ...    Indicates whether the site area is defined as a circle or a polygon
  ...  DeparturePolygonPoints  # String  Alphanumeric string of latitude and longitude coordinates.​  ***Not Required***
  ...    Collection of latitude and longitude coordinate​ pairs for each point that defines the boundary of the polygon GeoCode type.
  ...  DepartureRadius  # Double  xxx.xxxx  Default: 500.0000  ***Required***
  ...    Departure perimeter of a circle Geocode Type
  ...    NOTE: This field does not apply to polygon GeoCode types.
  ...  DepartureSameAsArrival  #  Boolean  TRUE FALSE  Default: True  ***Not Required***
  ...    Indicates whether the site departure geocode is the same as the site arrive geocode.
  ...  Latitude  # Double  -90.000000 to 90.000000  ***Not Required***
  ...    The latitudinal position of the site.
  ...    XRS supports up to 6 decimal points for this value.
  ...  Longitude  # Double  -180.000000 to 180.000000  ***Not Required***
  ...    The longitudinal position of the site.
  ...    XRS supports up to 6 decimal points for this value.
  ...  Measure  # String  Feet Miles Meters Kilometers  Default: Feet  ***Required***  ***Not Required***
  ...    The unit of measure to be used for the Site radius (if selected)
  ...  ModifiedBy  # String  Positive Numeric value  Default: Null  ***Read Only***
  ...    The ID of the last person to modify the site.
  ...    From AC: CreateDate, ModifiedDate and ModifiedBy data fields will be initialized by system.
  ...  ModifiedDate  # DateTime  DateTime  ***Read Only***
  ...    The date the site record was last modified.
  ...    The value of this field is Read Only and cannot be modified using PUT or POST commands.
  ...  Name  # String  Alpha Numeric Value  ***Required***  ***Not Required***
  ...    The name of the Site.
  ...    Field length is 3-50 to match current host GUI.
  ...  OrganizationID  # String  Alpha Numeric Value  ***Not Required***  ***Required***
  ...    The user-defined ID of the Organization in XRS.
  ...  OrganizationName  # String  Alpha Numeric Value  ***Required***  ***Not Required***
  ...    The user-defined name of the organization.
  ...  PostalCode  # String  5-9 Digit Numeric Value  ***Not Required***
  ...    The 5 to 9 digit zip code for the organization.
  ...  ResourceGroupIDs  # String  comma-delimited list  ***Not Required***
  ...    Indicates the set of ResourceGroupIDs to which the site belongs.
  ...  SiteID  # String  Alpha Numeric Value 3-12 characters  ***Required***
  ...    The user-defined ID of the Site in Omnitracs XRS.
  ...  SiteType  # String  Alpha Numeric Value  ***Required***  ***Not Required***
  ...    Unknown, Commerce, Domicile, Terminal, Fuel Stop, Government, Rest Stop, Shop, Truck Stop
  ...  StateName  # String  [State/Province Name]  ***Required***
  ...    The name of the state or province where the site is located.
  ...    This field corresponds to the State.Province field on the Edit Site > General Information tab.
  ...  TimeZone  # String  NFLD, CST, EST, MST, PST, AST, HST, ARIZ, SASKAT., ALASKA, INDANA  ***Required***
  ...    Identifies the Time Zone the site is located in.
  ...  UserDefinedField1  # String  Max length = 100 characters  ***Not Required***
  ...    User-defined field #1
  ...  UserDefinedField2  # String  Max length = 100 characters  ***Not Required***
  ...    User-defined field #2
  ...  UserDefinedField3  # String  Max length = 100 characters  ***Not Required***
  ...    User-defined field #3
  ...  UserDefinedField4  # String  Max length = 100 characters  ***Not Required***
  ...    User-defined field #4
  ...  UserDefinedField5  # String  Max length = 100 characters  ***Not Required***
  ...    User-defined field #5
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Site}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}
  ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Put Sites
  [Arguments]  @{list_data}
  [Documentation]  Calls the Put Method on Sites.
  ...  Accepts a list of json objects
  ...  See Json field definitions in the "Post Sites" Keyword
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Site}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}
  ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Sites
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on   Sites.
  ...  This will get   Sites that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # DateTime  [1900-01-01T00:00:00] DateTime  Default Value [7 Days]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...      System Limit: 30 days
  ...  Limit  # Long  0-10000  Default 5000
  ...      Used in conjunction with the Offset parameter to implement paging.
  ...      Limits the number of results to a specified number.
  ...      System Limit: 10,000
  ...  Offset  # Long  Default 0
  ...      Used in conjunction with the Limit parameter to implement paging.
  ...      Represents a page number for the starting point of the return set.
  ...  OrganizationID  # Long  Default Value [No Filter]
  ...      Limits results to sites in one or more organizations.
  ...      [No Filter] - Limits results to all sites within organizations that are associated with the Web Service User ID.
  ...      [OrganizationID] - Limits results to sites that belong to the specified Organization.
  ...  Recurse  # Boolean  True False  Default: False
  ...      True - Limits results to all site objects in the hierarchy of organizations within the specified OrganizationID.
  ...      False - Limits results to all site objects within specified OrganizationID.
  ...  ResourceGroupID  # Long  Default Value [No Filter]
  ...      Limits results to sites in one or more resource groups.
  ...      [No Filter] - Limits results to all sites within resource groups that are associated with the Web Service User ID.
  ...      [ResourceGroupID] - Limits results to the specified Resource Group ID.
  ...  SiteID  # Long  Positive Numeric Value
  ...      Limits results to site object with SiteID equal to that specified.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Site}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Sites With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get Sites that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Sites Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Site}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Sites
  [Documentation]  Get attributes for all sites.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Site}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Sites By Site Id
  [Arguments]  ${site_id}
  [Documentation]  Get organizations by Site ID.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Site}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}/${site_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Delete Sites By Site Id
  [Arguments]  ${site_id}
  [Documentation]  Delete Site by Site ID.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Site}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}/${site_id}
  ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Helper Keywords
Get Sites Response Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Sites  &{params}
  [Return]  ${response.status_code}

Get Sites Response With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Sites With URI Ending With / And Parameters &{params}
  [Return]  ${response.status_code}

Get Sites Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Site}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response.status_code}