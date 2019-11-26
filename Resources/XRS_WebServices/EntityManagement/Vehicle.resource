*** Settings ***
Documentation  Keyword library for interacting with the Entity > Vehicle Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/CommonWebService.robot

*** Variables ***
${ENTITY_MANAGEMENT_WEBSERVICE_GET_VEHICLE_EXT} =  /VehicleWebService.svc/vehicle/

*** Keywords ***
Get Vehicle With ID
    [Documentation]  This will return Vehicle information for a particular vehicle using the vehicle id
    [Arguments]  ${vehicle_id}
    Create XRS Web Services Session
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_VEHICLE_EXT}${vehicle_id}  headers=${headers}
    [Return]  ${response}
