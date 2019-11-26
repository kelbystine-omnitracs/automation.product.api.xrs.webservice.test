*** Settings ***
Documentation  Keyword library for interacting with the Entity > Device Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/CommonWebService.robot

*** Variables ***
${ENTITY_MANAGEMENT_WEBSERVICE_GET_DEVICE_EXT} =  /DeviceWebService.svc/device/

*** Keywords ***
Get Device With Phone Number ${phone_number}
    [Documentation]  This will return device information for a particular device using the phone number
    Create XRS Web Services Session
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_DEVICE_EXT}${phone_number}  headers=${headers}
    [Return]  ${response}