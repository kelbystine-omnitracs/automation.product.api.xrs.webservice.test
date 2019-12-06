*** Settings ***
Documentation  Keyword library for interacting with the Entity > Driver Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${ENTITY_MANAGEMENT_WEBSERVICE_GET_DELETE_DRIVER_WITH_DRIVERID} =  /driver
${ENTITY_MANAGEMENT_WEBSERVICE_POST_PUT_GET_DELETE_DRIVERS} =  /drivers

*** Keywords ***
Get Driver With ID
    [Arguments]  ${driver_id}
    [Documentation]  This will return driver information for a particular driver using the driver id
    ${uri} =  Set Variable  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_DELETE_DRIVER_WITH_DRIVERID}/${driver_id}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}
