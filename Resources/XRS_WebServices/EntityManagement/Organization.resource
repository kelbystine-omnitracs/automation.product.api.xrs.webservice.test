*** Settings ***
Documentation  Keyword library for interacting with the Entity > Organization Webservices
...  Version 1.1
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_ORGANIZATION} =  /organization
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS} =  /organizations
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_PUT_ORGANIZATIONS} =  /organizations/update
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_PUT_ORGANIZATIONS_PERFORMANCE} =  /organizations/performance

*** Keywords ***
Get Organization By OrganizationSID
  [Arguments]  ${organization_sid}
  [Documentation]  Get Organization information for a particular Organization using the OrganizationSID
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_ORGANIZATION}/${organization_sid}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Post Organizations
  [Arguments]  @{list_data}
  [Documentation]  Calls the Post Method on Organizations.
  ...  Accepts a list of json objects
  ...  Json field definitions:
  ...  Address1  # String ***Not Required***
  ...      The Address of the organization.
  ...      Defaults to Parent Organization's value.
  ...  Address2  # String ***Not Required***
  ...      The Address of the organization.
  ...      Defaults to Parent Organization's value.
  ...  AllowSharedResourceGroup  # Boolean  True, False  ***Not Required***
  ...      An advanced feature, users can view and report on shared resources across organizations.
  ...      See Resource Group Field Definitions for more information.
  ...  AllowSubscriptionChange  # Boolean  True, False  ***Not Required***
  ...      When set to True, Omnitracs XRS will track any changes that affect subscription levels
  ...      (adding subscribers, or moving vehicles or drivers between organizations).
  ...      The customer will be billed based on the changes.
  ...      When set to False, customers must contact Omnitracs XRS or their sales channel for subscription changes.
  ...  BillingOrganizationId  # String  AlphaNumeric  ***Not Required***
  ...      The ID of the Billing Organization.
  ...  BillingOrganizationSid  # Long  Positive Numeric Value  ***Not Required***
  ...      The SID of the Billing Organization.
  ...      This value is generated automatically by Omnitracs XRS and can be retrieved using the GET method.
  ...  CarrierName  # String  ***Required***
  ...      DOT-specific carrier name.
  ...  City  # String  ***Not Required***
  ...      The name of the city where the organization is based.
  ...  Country  # String  ***Required***
  ...      The name of the country where the organization is based.
  ...  CreateDate  # DateTime  DateTime  ***Read Only***
  ...      The date and time the account was created.
  ...      The value of this field is Read Only and cannot be modified using PUT or POST commands.
  ...  DotNumber  # String  ***Required***
  ...      Company's US DOT Number.
  ...  FleetViewRefresh  # Integer  0, 5, 10, 15, 30, 60  ***Not Required***
  ...      A read only field indicating the ID of the last driver which logged into the Organization.
  ...  Language  # String English Spanish French  ***Required***
  ...      A read only field indicating the name of the last driver which logged into the Organization.
  ...  ModifiedBy  # Long XRS_User_ID  ***Read Only***
  ...      The SID of the last Omnitracs XRS User that made modifications to the record.
  ...  ModifiedDate  # DateTime  DateTime  ***Read Only***
  ...      The Date and Time the site record was last modified.
  ...  OrganizationID   # String  Positive Numeric Value  ***Required***
  ...      The user-defined ID of the organization.
  ...  OrganizationName  # String 3-50 characters  ***Required***
  ...      A read-only field containing the name of the organization to which the Organization is assigned.
  ...  OrganizationSid  # Long  Positive Numeric Value  ***Not Required***
  ...      The internal system generated ID (primary key) of the Organization in Omnitracs XRS.
  ...      This value can be retrieved using the GET method.
  ...  ParentOrganizationID  # String  Max = 20 Characters  ***Required***
  ...      The internal system generated ID (primary key) of the Parent Organization in Omnitracs XRS. 
  ...      Note: This field is required if a ParentOrganizationSID value is not specified.
  ...  ParentOrganizationSid  # Long  Positive Numeric Value  ***Required***
  ...      The ID of the parent organization.
  ...      Note: This field is required if a Parent OrganizationID value is not specified.
  ...  PostalCode  # String  *** Not Required ***
  ...      The 5 to 9 digit zip code for the organization.
  ...  State  # String  [State Name]  *** Not Required ***
  ...      The state, province or territory for the organization.
  ...  Status  # Boolean  Active (default) Inactive  ***Not Required***
  ...      Indicates whether the Organization record is active within Omnitracs XRS.
  ...  TimeZone  # String  NFLD CST EST MST PST AST HST ARIZ SASKAT ALASKA INDANA  ***Required***
  ...      Identifies the Time Zone the Organization is located in.
  ...  UnitOfMeasure  # String  Standard Metric  ***Not Required***
  ...      The unit of measure selected for this organization. This applies to all performance and compliance based reporting.
  ...      Standard (MPG)
  ...      Metric (KM/L)
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}
  ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Put Organizations
  [Arguments]  @{list_data}
  [Documentation]  Calls the Put Method on Organizations.
  ...  Accepts a list of json objects
  ...  See Json field definitions in the "Post Organizations" Keyword
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_PUT_ORGANIZATIONS}
  ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Organizations
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Organizations.
  ...  This will get Organizations that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [1 Day]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...      The date and time are associated with the last modified date and time of the record.
  ...      System Limit: 30 days
  ...  Status  # Default Value [No Filter]
  ...      Filters results to active organizations only.
  ...      Valid Values: True False Both
  ...      Active (same as True)
  ...      Inactive (same as False)
  ...  Limit  # Default Value 100
  ...      Used in conjunction with the Offset parameter to implement paging.
  ...      Limits the number of results to a specified number.
  ...      System Limit: 10,000
  ...  Offset  # Default Value 1
  ...      Used in conjunction with the Limit parameter to implement paging.
  ...      Represents a page number for the starting point of the return set.
  ...  OrganizationId  # Default Value [No Filter]
  ...      Limits results to organizations that fall under the specified organization.
  ...  ResourceGroupId  # Default Value [No Filter]
  ...      Limits results to Organizations in one or more resource groups.
  ...  OrganizationSid  # Default Value [No Filter]
  ...      Limits results to organizations that fall under the specified organization.
  ...  ResourceGroupSid  # Default Value [No Filter]
  ...      Limits results to Organizations in one or more resource groups.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Organizations With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get Organizations that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Organizations Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Organizations By ID
  [Arguments]  ${organization_id}
  [Documentation]  Get organizations by ID.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}/${organization_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get All Organizations
  [Documentation]  Get attributes for all organizations.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Keywords For Organizations Performance (settings) Data
Get Organizations Performance Data By ID
  [Arguments]  ${organization_id}
  [Documentation]  Get performance (settings) data for all organizations by ID
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}/${organization_id}/performance
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Organizations Performance Data
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Organizations Performance (settings) data.
  ...  This will get Organizations that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [1 Day]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...      The date and time are associated with the last modified date and time of the record.
  ...      System Limit: 30 days
  ...  Status  # Default Value [No Filter]
  ...      Filters results to active organizations only.
  ...      Valid Values: True False Both
  ...      Active (same as True)
  ...      Inactive (same as False)
  ...  Limit  # Default Value 100
  ...      Used in conjunction with the Offset parameter to implement paging.
  ...      Limits the number of results to a specified number.
  ...      System Limit: 10,000
  ...  Offset  # Default Value 1
  ...      Used in conjunction with the Limit parameter to implement paging.
  ...      Represents a page number for the starting point of the return set.
  ...  OrganizationId  # Default Value [No Filter]
  ...      Limits results to organizations that fall under the specified organization.
  ...  ResourceGroupId  # Default Value [No Filter]
  ...      Limits results to Organizations in one or more resource groups.
  ...  Recurse  # Default Value [No Filter]
  ...      No clue what this does.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_PUT_ORGANIZATIONS_PERFORMANCE}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=&{params}
  [Return]  ${response}

Get Organizations Performance Data With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get Organizations that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Organizations Performance Data Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_PUT_ORGANIZATIONS_PERFORMANCE}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Organizations Performance Data
  [Documentation]  Get all the organization performance (settings) data
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_PUT_ORGANIZATIONS_PERFORMANCE}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Put Organizations Performance Data By ID
  [Arguments]  ${organization_id}  ${json_data}
  [Documentation]  Calls the Put Method on Organizations performance (settings)
  ...  Requires two variables: OrganizationId and json file data
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Organization}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}/${organization_id}/performance
  ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${json_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Helper Keywords
Get Organizations Response Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Organizations  &{params}
  [Return]  ${response}

Get Organizations Response With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Organizations With URI Ending With / And Parameters &{params}
  [Return]  ${response}

Get Organizations Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Organization}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_ORGANIZATIONS}  ${character_string}  ${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri_string}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Organizations Performance (settings) Data Response Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Organizations  &{params}
  [Return]  ${response}

Get Organizations Performance (settings) Data Response With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Organizations Performance Data With URI Ending With / And Parameters &{params}
  [Return]  ${response}

Get Organizations Performance (settings) Data Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.Organization}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_PUT_ORGANIZATIONS_PERFORMANCE}  ${character_string}  ${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri_string}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}