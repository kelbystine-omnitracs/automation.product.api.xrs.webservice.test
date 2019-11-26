*** Settings ***
Documentation  Sets up the header and authorization for a web service session
...
Library  RequestsLibrary
Variables  ../../Data/XRSEnvironmentData.yaml
Variables  ../../Data/TestBenchDefinitions/%{COMPUTERNAME}TestBench/Users.yaml
Variables  ../../Data/TestBenchDefinitions/%{COMPUTERNAME}TestBench/CompanyDefinition.yaml

*** Variables ***
${XRS_WEB_SERVICE_SESSION} =  xrs_web_service_session
@{XRS_WEBSERVICES_AUTHORIZATION} =  ${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}  ${DEFAULT_ADMIN_USER.PASSWORD}
&{XRS_WEBSERVICES_HEADER} =  Content-Type=application/json  Accept=application/json

*** Keywords ***
Create XRS Web Services Session
    [Documentation]  Create a session with xrs web services
    Create Session  ${XRS_WEB_SERVICE_SESSION}  ${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]  auth=${XRS_WEBSERVICES_AUTHORIZATION}