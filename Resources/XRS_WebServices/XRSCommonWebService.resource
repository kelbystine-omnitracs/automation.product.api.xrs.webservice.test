*** Settings ***
Documentation  Creates a XRS Web Service session with or without authorization.
...  The default authorization is based upon the admin user of the company.
Library  RequestsLibrary
Variables  ../../Data/XRSEnvironmentData.yaml
Variables  ../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/Users.yaml
Variables  ../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml

*** Variables ***
${XRS_WEB_SERVICE_SESSION_ALIAS} =  xrs_web_service_session
@{XRS_WEBSERVICES_AUTHORIZATION} =  ${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}  ${DEFAULT_ADMIN_USER.PASSWORD}
&{XRS_WEBSERVICES_JSON_HEADER} =  Content-Type=application/json  Accept=application/json  Accept-Encoding=gzip, deflate

*** Keywords ***
Create XRS Web Services Session
    [Documentation]  Create a session with xrs web services
    Create Session  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]  auth=${XRS_WEBSERVICES_AUTHORIZATION}

Create XRS Web Services Session With No Authorization
    [Documentation]  Create a session with xrs web services without authorization
    Create Session  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]

Create AWS XRS Web Services Session
    [Documentation]  Create a session with aws xrs web services
    Create Session  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${XRS_AWS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]  verify=True  auth=${XRS_WEBSERVICES_AUTHORIZATION}

Create AWS XRS Web Services Session With No Authorization
    [Documentation]  Create a session with aws xrs web services without authorization
    Create Session  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${XRS_AWS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]  verify=True