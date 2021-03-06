*** Settings ***
Documentation  Validates the top level XRS Web services
Library         Collections
Resource        ../../Resources/XRS_WebServices/XRSCommonWebService.resource
Variables       ../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
# Suite Setup and Teardown
Suite Setup     Create REST API Session With No Authorization
Suite Teardown  Delete All Sessions
Force Tags      xrswebservicevalidation  xrsrestwebservicevalidationsmoketest
Test Template   Verify 200 OK Response From XRS Web Services

*** Variables ***

*** Test Cases ***
Validate Entity Management XRS Web Services     ${XRS_Entity_Management_Base_URI}
Validate Form Messaging XRS Web Services        ${XRS_Form_Messaging_Base_URI}
Validate Performance XRS Web Services           ${XRS_Performance_Base_URI}
Validate Routing Dispatch XRS Web Services      ${XRS_Routing_Dispatch_Base_URI}
Validate Status XRS Web Services                ${XRS_Status_Base_URI}
Validate Compliance XRS Web Services            ${XRS_Compliance_Base_URI}

*** Keywords ***
Verify 200 OK Response From XRS Web Services
    [Documentation]  Validates a 200 response from each xrs webservice
    [Arguments]  ${xrs_web_service_dict}
    FOR  ${w}  IN  @{xrs_web_service_dict}
        ${xrs_web_service} =  Get From Dictionary  ${xrs_web_service_dict}  ${w}
        ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${xrs_web_service}
        Request Should Be Successful    ${response}
    END