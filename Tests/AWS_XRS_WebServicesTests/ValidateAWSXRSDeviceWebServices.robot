*** Settings ***
Documentation  Validates 
Resource  ../../Resources/XRS_WebServices/XRSCommonWebService.resource
Variables  ../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Resource  ../../Resources/XRS_WebServices/EntityManagement/Device.resource

Suite Setup  Create AWS XRS Web Services Session
Suite Teardown  Delete All Sessions

*** Variables ***
${XRS_HOST_ENVIRONMENT} =  d3

*** Test Cases ***
Validate AWS XRS Get Devices REST Webservices
    [Documentation]  Initial test to verify that all AWS XRS Web Services are available
    [Tags]  awsxrsdevicerestwebservicevalidation
    Verify Get Devices

Validate AWS XRS Device REST Webservices
    [Documentation]  Initial test to verify that all AWS XRS Web Services are available
    [Tags]  pooky
    Verify Post Devices

*** Keywords ***
Verify Get Devices
    ${organization_id} =  Set Variable  46663
    ${resourcegroup} =  Set Variable  Gnome Shipping D3
    ${isactive} =  Set Variable  True
    ${asofdattime} =  Set Variable  11/01/2019
    ${limit} =  Set Variable  1
    ${offset} =  Set Variable  1
    ${response} =  Get Devices  OrganizationID=${organization_id}  ResourceGroupID=${resourcegroup}  IsActive=${isactive}  AsOfDateTime=${asofdattime}  Limit=${limit}  Offset=${offset}
    Log To Console  ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200

Verify Post Devices
    [Documentation]
    #   [{
    # 	"BelongsToDeviceResourceGroups":["String content"],
    # 	"BluetoothAddress":"String content",
    # 	"CarrierDisplayName":"String content",
    # 	"CompanyName":"String content",
    # 	"CreateDate":"String content",
    # 	"Description":"String content",
    # 	"DeviceType":"String content",
    # 	"FixedDisplay":"String content",
    # 	"IsChanged":"String content",
    # 	"LastCommunication":"String content",
    # 	"LastDriverID":"String content",
    # 	"LastDriverName":"String content",
    # 	"LastVehicleID":"String content",
    # 	"ModifiedBy":"String content",
    # 	"ModifiedDate":"String content",
    # 	"OrganizationID":"String content",
    # 	"OrganizationName":"String content",
    # 	"PhoneNumber":"String content",
    # 	"SendInstallLink":"String content",
    # 	"Status":"String content",
    # 	"StoreGNISFileOnMobile":"String content",
    # 	"UserDefinedField1":"String content",
    # 	"UserDefinedField2":"String content",
    # 	"UserDefinedField3":"String content",
    # 	"UserDefinedField4":"String content",
    # 	"UserDefinedField5":"String content"
    # }]
    &{data} =  Create Dictionary  PhoneNumber=1234567896  DeviceType=Nexus  CarrierDisplayName=Sprint  OrganizationName=Gnome Shipping D3
    ${response} =  Post Devices  PhoneNumber=1234567896  DeviceType=Nexus  CarrierDisplayName=Sprint  OrganizationName=Gnome Shipping D3
    Log To Console  ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200