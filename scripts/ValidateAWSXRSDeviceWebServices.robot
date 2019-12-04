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
Validate AWS XRS Device REST Webservices
    [Documentation]  Initial test to verify that all AWS XRS Web Services are available
    [Tags]  awsxrsdevicerestwebservicevalidation
    Verify Get Devices

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