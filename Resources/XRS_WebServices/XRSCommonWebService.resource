*** Settings ***
Documentation  Creates a XRS Web Service session with or without authorization.
...  The default authorization is based upon the admin user of the company.
Library  RequestsLibrary
Library  Collections
Variables  ../../Data/XRSEnvironmentData.yaml
Variables  ../../Data/XRSCommonData.yaml
Variables  ../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/Users.yaml
Variables  ../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml

*** Variables ***
@{XRS_WEBSERVICES_AUTHORIZATION} =  ${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}  ${DEFAULT_ADMIN_USER.PASSWORD}
&{XRS_WEBSERVICES_JSON_HEADER} =  Content-Type=application/json  Accept=application/json  Accept-Encoding=gzip, deflate
${XRS_WEB_SERVICE_SESSION_ALIAS} =  xrs_web_services

*** Keywords ***
Create REST API Session
    [Arguments]  ${alias}=${XRS_WEB_SERVICE_SESSION_ALIAS}
    [Documentation]  Creates a REST API Web Services Session based on the type of connection.
    ...  The ${alias} parameter defaults to xrs_web_services if no other paramter is supplied.
    ...  Valid url options: xrs_webservices, xrs_webservices_aws
    Run Keyword If  "${XRS_WEBSERVICE_SESSION_TYPE}"=="xrs_webservices"  Create XRS Web Services Session  ${alias}
    Run Keyword If  "${XRS_WEBSERVICE_SESSION_TYPE}"=="xrs_webservices_aws"  Create AWS XRS Web Services Session  ${alias}

Create REST API Session With No Authorization
    [Arguments]  ${alias}=${XRS_WEB_SERVICE_SESSION_ALIAS}
    [Documentation]  Creates a REST API Web Services Session based on the type of connection.
    ...  The ${alias} parameter defaults to xrs_web_services if no other paramter is supplied.
    ...  Valid url options: xrs_webservices, xrs_webservices_aws
    Run Keyword If  "${XRS_WEBSERVICE_SESSION_TYPE}"=="xrs_webservices"  Create XRS Web Services Session With No Authorization  ${alias}
    Run Keyword If  "${XRS_WEBSERVICE_SESSION_TYPE}"=="xrs_webservices_aws"  Create AWS XRS Web Services Session With No Authorization  ${alias}

Create XRS Web Services Session
    [Arguments]  ${alias}  ${authorization}=${XRS_WEBSERVICES_AUTHORIZATION}
    [Documentation]  Create a session with xrs web services
    ${url} =  Get From Dictionary  ${XRS_WEBSERVICES_URL}  ${XRS_HOST_ENVIRONMENT}
    Create Session  ${alias}  ${url}  auth=${authorization}

Create XRS Web Services Session With No Authorization
    [Arguments]  ${alias}
    [Documentation]  Create a session with xrs web services without authorization
    ${url} =  Get From Dictionary  ${XRS_WEBSERVICES_URL}  ${XRS_HOST_ENVIRONMENT}
    Create Session  ${alias}  ${url} 

Create AWS XRS Web Services Session
    [Arguments]  ${alias}  ${authorization}=${XRS_WEBSERVICES_AUTHORIZATION}
    [Documentation]  Create a session with aws xrs web services
    ${url} =  Get From Dictionary  ${XRS_AWS_WEBSERVICES_URL}  ${XRS_HOST_ENVIRONMENT}
    Create Session  ${alias}  ${url}  verify=True  auth=${authorization}

Create AWS XRS Web Services Session With No Authorization
    [Arguments]  ${alias}
    [Documentation]  Create a session with aws xrs web services without authorization
    ${url} =  Get From Dictionary  ${XRS_AWS_WEBSERVICES_URL}  ${XRS_HOST_ENVIRONMENT}
    Create Session  ${alias}  ${url}  verify=True