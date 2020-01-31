*** Settings ***
Documentation  Keyword library for interacting with the Entity > Resource Group Webservices
Library  RequestsLibrary
Resource   ../../XRS_WebServices/XRSCommonWebService.resource
Resource   ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUP} =  /resourcegroup
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUPS} =  /resourcegroups

*** Keywords ***
Get Resource Group By Resource Group Id
  [Arguments]  ${resource_group_id}
  [Documentation]  Get resource group information for a particular group using the resource group id
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Resource_Group}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUP}/${resource_group_id}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Resource Groups
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Organizations.
  ...  This will get Organizations that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [No Filter]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...  Status  # Default Value [No Filter]
  ...      Filters results to active organizations only.
  ...      Valid Values: True False Both
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
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Resource_Group}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUPS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Resource Groups
  [Documentation]  Get attributes for all organizations.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Resource_Group}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUPS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Resource Groups By Resource Group Sid
  [Arguments]  ${resource_group_sid}
  [Documentation]  Get resource group information for a particular group using the resource group sid
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Resource_Group}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUPS}/${resource_group_sid}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

Get Resource Groups With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get Resource Groups that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Resource Groups Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Resource_Group}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUPS}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

# Helper Keywords
Get Resource Groups Response Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Resource Groups  &{params}
  [Return]  ${response}

Get Resource Groups Response With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Resource Groups With URI Ending With / And Parameters &{params}
  [Return]  ${response}

Get Resource Groups Raw String URI Response With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With
  ...  ${XRS_Entity_Management_Base_URI.Resource_Group}
  ...  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_GET_RESOURCE_GROUPS}
  ...  ${character_string}
  ...  ${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri_string}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}