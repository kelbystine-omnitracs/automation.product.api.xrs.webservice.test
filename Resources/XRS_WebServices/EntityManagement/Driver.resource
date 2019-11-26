*** Settings ***
Documentation  Keyword library for interacting with the Entity > Driver Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/CommonWebService.robot

*** Variables ***
${ENTITY_MANAGEMENT_WEBSERVICE_GET_DRIVER_EXT} =  /DriverWebService.svc/driver/

*** Keywords ***
Get Driver With ID ${driver_id}
    [Documentation]  This will return driver information for a particular driver using the driver id
    Create XRS Web Services Session
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_DRIVER_EXT}${driver_id}  headers=${WEBSERVICES_HEADER}
    [Return]  ${response}
