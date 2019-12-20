*** Settings ***
Documentation  Keyword library for interacting with the Entity > Site Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_SITE} =  /sites

*** Keywords ***
Post Sites
  [Arguments]
  [Documentation]  Calls the Post Method on Organizations.
  ...  Accepts a list of json objects
  ...  Json field definitions:
  ...  Address  # String  Alpha Numeric Value  ***Not Required***
  ...    The address of the site.
  ...  ArrivalGeoCodeType  # String  Circle Polygon  Default: Circle  ***Required***
  ...    Indicates whether the site area is defined as a circle or a polygon
  ...  ArrivalPolygonPoints  # String  Alphanumeric string of latitude and longitude coordinates.​​  ***Not Required***
  ...    The collection of lat/long pairs for each point that defines the boundaries of the polygon.
  ...  ArrivalRadius  #  Double  x.xxxx  Default: 500  ***Required***
  ...    Arrival perimeter of CIRCLE GeoCode site.
  ...    The arrival circle characteristics are also used in site lookups throughout the system.​
  ...  City  # String  AlphaNumeric Value  ***Required***
  ...    The name of the city where the site is located.
  ...  Country  # String  AlphaNumeric Value  ***Required***
  ...    The name of the country where the site is located.
  ...  CreateDate  # DateTime  [1900-01-01T00:00:00] DateTime  ***Not Required***
  ...    The date and time the site object was created.  
  ...    The value of this field is Read Only and cannot be modified using PUT or POST commands.
  ...  DeliveryWindows	  #	[Collection]				See Delivery Windows for More information
  ...  DepartureGeoCodeType	  #	String	Circle Polygon	Yes	No	Indicates whether the site area is defined as a circle or a polygon
  ...  DeparturePolygonPoints	  #	String	Alphanumeric string of latitude and longitude coordinates.​	No	No	Collection of latitude and longitude coordinate​ pairs for each point that defines the boundary of the polygon GeoCode type. 
  ...  DepartureRadius	  #	Double	xxx.xxxx Default: 500.0000	Yes	No	"Departure perimeter of a circle Geocode Type
  ...  NOTE: This field does not apply to polygon GeoCode types. "
  ...  DepartureSameAsArrival	  #	Boolean	"TRUE
  ...  FALSE
  ...  Default: True"	No	No	Indicates whether the site departure geocode is the same as the site arrive geocode.
  ...  Latitude	  #	Double	-90.000000 to 90.000000	No	No	"The latitudinal position of the site.
  ...  XRS supports up to 6 decimal points for this value."
  ...  Longitude	  #	Double	-180.000000 to 180.000000	No	No	"The longitudinal position of the site.
  ...  XRS supports up to 6 decimal points for this value."
  ...  Measure	  #	String	"Feet
  ...  Miles
  ...  Meters
  ...  Kilometers
  ...  Default: Feet"	Yes	No	The unit of measure to be used for the Site radius (if selected)
  ...  ModifiedBy	  #	String	Positive Numeric value Default: Null	No	No	"The ID of the last person to modify the site.
  ...  From AC: CreateDate, ModifiedDate and ModifiedBy data fields will be initialized by system."
  ...  ModifiedDate	  #	DateTime	DateTime	No	No	The date the site record was last modified. The value of this field is Read Only and cannot be modified using PUT or POST commands.
  ...  Name	  #	String	Alpha Numeric Value	Yes	No	The name of the Site. Field length is 3-50 to match current host GUI.
  ...  OrganizationID	  #	String	Alpha Numeric Value	No	Yes	The user-defined ID of the Organization in XRS.
  ...  OrganizationName	  #	String	Alpha Numeric Value	Yes	No	The user-defined name of the organization.
  ...  PostalCode	  #	String	5-9 Digit Numeric Value	No	No	The 5 to 9 digit zip code for the organization.
  ...  ResourceGroupIDs	  #	String	comma-delimited list	No	No	Indicates the set of ResourceGroupIDs to which the site belongs.
  ...  SiteID	  #	String	Alpha Numeric Value 3-12 characters	Yes	Yes	The user-defined ID of the Site in Omnitracs XRS.
  ...  SiteType	  #	String	Alpha Numeric Value	Yes	No	Unknown, Commerce, Domicile, Terminal, Fuel Stop, Government, Rest Stop, Shop, Truck Stop
  ...  StateName	  #	String	[State/Province Name]	Yes	Yes	"The name of the state or province where the site is located.
  ...  This field corresponds to the State.Province field on the Edit Site > General Information tab."
  ...  TimeZone	  #	String	NFLD, CST, EST, MST, PST, AST, HST, ARIZ, SASKAT., ALASKA, INDANA	Yes	Yes	Identifies the Time Zone the site is located in.
  ...  UserDefinedField1	  #	String	Max length = 100 characters	No	No	User-defined field #1
  ...  UserDefinedField2	  #	String	Max length = 100 characters	No	No	User-defined field #2
  ...  UserDefinedField3	  #	String	Max length = 100 characters	No	No	User-defined field #3
  ...  UserDefinedField4	  #	String	Max length = 100 characters	No	No	User-defined field #4
  ...  UserDefinedField5	  #	String	Max length = 100 characters	No	No	User-defined field #5

  

Put Sites
  [Arguments]
  [Documentation]

Get Sites
  [Arguments]
  [Documentation]

Get Sites By Site Id
  [Arguments]
  [Documentation]

Delete Sites By Site Id
  [Arguments]
  [Documentation]