*** Settings ***
Documentation  Validates the top level XRS Web services
Resource  ../../Resources/XRS_WebServices/CommonWebService.resource
Variables  ../../Data/XRSCommonWebServices.yaml

Suite Setup  Create XRS Web Services Session with No Authorization
Suite Teardown  Delete All Sessions

*** Variables ***
${XRS_HOST_ENVIRONMENT} =  d3

*** Test Cases ***
Validate AWS XRS Webservices
    [Documentation]  Initial test to verify that all XRS Web Services are available
    [Tags]  xrswebservicevalidation
    [Template]  Verify 200 OK Response From XRS WebServices
    ${XRS_Entity_Management_REST}
    ${XRS_Form_Messaging_REST}
    ${XRS_Performance_REST}
    ${XRS_Routing_Dispatch_REST}
    ${XRS_Status_REST}
    ${XRS_Compliance_REST}

*** Keywords ***
Verify 200 OK Response From XRS WebServices
    [Documentation]  Validates a 200 response from each xrs webservice
    [Arguments]  ${xrs_web_service_dict}
    ${base_uri} =  Set Variable  base_uri
    FOR  ${e}  IN  @{xrs_web_service_dict}
        ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${xrs_web_service_dict}[${e}][${base_uri}]
        Should Be Equal As Strings    ${response.status_code}    200
    END