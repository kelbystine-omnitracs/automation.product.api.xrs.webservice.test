*** Settings ***
Documentation  Validates 
#   Device_REST:
#     base_uri: DeviceWebService.svc
#     get_device: device/{PHONENUMBER}
#     delete_device: device/{PHONENUMBER}
#     post_devices: devices
#     put_devices: devices
#     get_devices: devices/?OrganizationID={ORGANIZATIONID}&ResourceGroupID={RESOURCEGROUPID}&IsActive={ISACTIVE}&AsOfDateTime={ASOFDATETIME}&Limit={LIMIT}&Offset={OFFSET}
Resource  ../../Resources/XRS_WebServices/CommonWebService.resource
Variables  ../../Data/XRSCommonWebServices.yaml

Suite Setup  Create AWS XRS Web Services Session
Suite Teardown  Delete All Sessions

*** Variables ***
${XRS_HOST_ENVIRONMENT} =  d3

*** Test Cases ***
Validate AWS XRS Device REST Webservices
    [Documentation]  Initial test to verify that all AWS XRS Web Services are available
    [Tags]  awsxrsdevicerestwebservicevalidation
    Run Keyword And Continue On Failure  Get Device
    Run Keyword And Continue On Failure  Delete Device
    Run Keyword And Continue On Failure  Post Devices
    Run Keyword And Continue On Failure  Put Devices
    Run Keyword And Continue On Failure  Get Devices

*** Keywords ***
Get Device
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${XRS_Entity_Management_REST.Device_REST.base_uri}/device
    Log To Console  ${response.headers}
    Should Be Equal As Strings    ${response.status_code}    401

Delete Device
    ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION}  ${XRS_Entity_Management_REST.Device_REST.base_uri}/device
    Should Be Equal As Strings    ${response.status_code}    401
    Log To Console  ${response}

Post Devices
    ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION}  ${XRS_Entity_Management_REST.Device_REST.base_uri}/devices
    Should Be Equal As Strings    ${response.status_code}    401
    Log To Console  ${response}

Put Devices
    ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION}  ${XRS_Entity_Management_REST.Device_REST.base_uri}/devices
    Should Be Equal As Strings    ${response.status_code}    401
    Log To Console  ${response}

Get Devices
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${XRS_Entity_Management_REST.Device_REST.base_uri}/devices
    Should Be Equal As Strings    ${response.status_code}    401
    Log To Console  ${response}