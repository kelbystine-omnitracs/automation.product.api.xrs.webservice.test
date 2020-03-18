*** Settings ***
Documentation  Keyword library for interacting with the Performance > Black Box Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_COMPLIANCE_GET_DRIVER_LOG} = /driverlog
${XRS_WEBSERVICE_COMPLIANCE_GET_DRIVER_LOG_DETAILS} =  /driverlogdetails
${XRS_WEBSERVICE_COMPLIANCE_POST_GET_PUT_DRIVER_LOG_DETAILS_V2} = /driverlog
${XRS_WEBSERVICE_COMPLIANCE_GET_DRIVER_LOG_DETAILS_V2} =  /driverlogdetails
${XRS_WEBSERVICE_COMPLIANCE_GET_DRIVER_LOG_V3} = /driverlog

*** Keywords ***
Get Driver Log
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on Devices.
  ...  This will get devices that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  DriverID  # Long  Positive Number Value  Default Value [No Filter]
  ...     Limits results to driver log objects with DriverID equal to that specified..
  ...  EndDate  # DateTime  [1900-01-01T00:00:00] DateTime  Default Value [No Filter]
  ...     Limits results to all driver log objects with a log period falling within the period from the StartDate to EndDate.
  ...     The period from the StartDate to the EndDate must not be greater than 15 days.
  ...     If no StartDate and EndDate are provided, edited logs for edits made less than or equal to 15 days prior to the call will be returned.
  ...     The Time portion of this field is ignored by this Web Service. This Web Service is intended to provide HOS Log data for one or more complete days.
  ...     Current Implementation:
  ...     If StartDate and EndDate field values are provided, then the Edits parameter is ignored.
  ...     When StartDate and EndDate field values are provided, the DriverLog Web Service will return the following:
  ...       Logs for the requested date range
  ...       Edits to logs whose record dates fall within the specified date range are included in the returned data
  ...  Limit  # Long  0-10000  Default Value 5000
  ...     Used in conjunction with the Offset parameter to implement paging.
  ...     Limits the number of results to a specified number.
  ...  Offset  # Long  Default Value 0
  ...     Used in conjunction with the Limit parameter to implement paging.
  ...     Represents a page number for the starting point of the return set.
  ...  OrganizationID  # Long  [OrganizationID] ***Required***
  ...     [OrganizationID] - Limits results to all driver log objects within the specified OrganizationID value.
  ...     The OrganizationID query parameter is required when performing a GET method call using the DriverLog Web Service.
  ...  Edits  # Boolean  true false  Default Value true
  ...     Omnitracs XRS currently ignores the value of the Edits field, even if a value is provided.
  ...     This will be corrected in a future release of Omnitracs XRS.
  ...     Returns driver log objects within the time period specified by StartDate and EndDate which have been edited
  ...     - along with the unedited driver logs for that period.
  ...     If StartDate and EndDate field values are not provided and the Edits field is set to True, the DriverLog Web Service will return the following:
  ...       Yesterday's logs are returned.
  ...       Driver Logs which were edited yesterday are returned, regardless of the date the log occurred.
  ...  ResourceGroupID  # Long  [none] [ResourceGroupID]  Default Value [No Filter]
  ...     none - Limits results to all driver log objects within all resource groups within organizationIDs (as specified by OrganizationID field).
  ...     ResourceGroupID - Limits results to all driver log objects within OrganizationID (as specified by OrganizationID field) and ResourceGroupID.
  ...  StartDate  # DateTime  [1900-01-01T00:00:00] DateTime  Default Value [No Filter]
  ...     Limits results to all driver log objects with a log period falling within the period from the StartDate to EndDate.
  ...     The period from the StartDate to the EndDate must not be greater than 15 days.
  ...     The StartDate value must be less than or equal to 6 months prior to the service request (i.e. service request made on 9/3, limit is 3/3)[ME1] 
  ...     If no  StartDate  and EndDate values are provided, edited logs for edits made less than or equal to 15 days prior to the call will be returned.
  ...     The Time portion of this field is ignored by this Web Service. This Web Service is intended to provide HOS Log data for one or more complete days.
  ...     Current Implementation:
  ...     If StartDate and EndDate field values are provided, then the Edits parameter is ignored.
  ...     When StartDate and EndDate field values are provided, the DriverLog Web Service will return the following:
  ...       Logs for the requested date range
  ...       Edit are included in the returned data
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}${XRS_WEBSERVICE_COMPLIANCE_GET_DRIVER_LOG}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}