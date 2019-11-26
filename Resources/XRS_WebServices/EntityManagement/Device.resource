*** Settings ***
Documentation  Keyword library for interacting with the Entity > Device Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/CommonWebService.robot

*** Variables ***
${ENTITY_MANAGEMENT_WEBSERVICE_GET_DEVICE_EXT} =  /DeviceWebService.svc/device/
  Device_REST:
    base_uri: DeviceWebService.svc
    get_device: device/{PHONENUMBER}
    delete_device: device/{PHONENUMBER}
    post_devices: devices
    put_devices: devices
    get_devices: devices/?OrganizationID={ORGANIZATIONID}&ResourceGroupID={RESOURCEGROUPID}&IsActive={ISACTIVE}&AsOfDateTime={ASOFDATETIME}&Limit={LIMIT}&Offset={OFFSET}

*** Keywords ***
Get Device With Phone Number
    [Documentation]  This will return device information for a particular device using the phone number
    [Arguments]  ${phone_number}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_DEVICE_EXT}${phone_number}  headers=${headers}
    [Return]  ${response}