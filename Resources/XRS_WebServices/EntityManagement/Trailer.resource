*** Settings ***
Documentation  Keyword library for interacting with the Entity > Trailer Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/CommonWebService.robot

*** Variables ***
${ENTITY_MANAGEMENT_WEBSERVICE_GET_TRAILER_EXT} =  /TrailerWebService.svc/trailer/

*** Keywords ***
Get Trailer With ID
    [Documentation]  This will return Trailer information for a particular trailer using the trailer id
    [Arguments]  ${trailer_id}
    Create XRS Web Services Session
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_TRAILER_EXT}${trailer_id}  headers=${WEBSERVICES_HEADER}
    [Return]  ${response}
