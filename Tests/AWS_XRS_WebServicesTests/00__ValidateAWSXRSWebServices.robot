*** Settings ***
Documentation  Validates the top level XRS Web services
Resource  ../../Resources/XRS_WebServices/XRSCommonWebService.resource
Variables  ../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml

Suite Setup  Create AWS XRS Web Services Session With No Authorization
Suite Teardown  Delete All Sessions

*** Variables ***
${XRS_HOST_ENVIRONMENT} =  d3

*** Test Cases ***
Validate XRS AWS Webservices
    [Documentation]  Initial test to verify that all XRS Web Services are available
    [Tags]  xrsawswebservicevalidation
    [Template]  Verify 200 OK Response From XRS WebServices
    ${XRS_Entity_Management_Base_URI}
    ${XRS_Form_Messaging_Base_URI}
    ${XRS_Performance_Base_URI}
    ${XRS_Routing_Dispatch_Base_URI}
    ${XRS_Status_Base_URI}
    ${XRS_Compliance_Base_URI}

*** Keywords ***
Verify 200 OK Response From XRS WebServices
    [Documentation]  Validates a 200 response from each xrs webservice
    [Arguments]  ${xrs_web_service_dict}
    ${base_uri} =  Set Variable  base_uri
    FOR  ${e}  IN  @{xrs_web_service_dict}
        ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${xrs_web_service_dict}[${e}]
        Should Be Equal As Strings    ${response.status_code}    200
    END