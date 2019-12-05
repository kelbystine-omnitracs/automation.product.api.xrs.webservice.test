*** Settings ***
Documentation     This task is designed to create 100 messages at a time to be sent to mobile through webservices.
Library           RequestsLibrary
Library           FakerLibrary
Variables         ../Data/TestBenchDefinitions/%{COMPUTERNAME}TestBench/Users.yaml
Variables         ../Data/TestBenchDefinitions/%{COMPUTERNAME}TestBench/CompanyDefinition.yaml
Variables         ../Data/CommonData.yaml
Variables         ../Data/EnvironmentData.yaml

*** Variables ***
${MESSAGES_WEBSERVICE_SESSION}    messages
${MESSAGING_WEBSERVICE_MESSAGES_EXT}    /MessageWebService.svc/messages

*** Test Cases ***
Send 100 Messages to a driver
    [Documentation]    This will send one hundred messages to a single driver using webservices
    [Tags]    messaging    webservices
    Create Message Session
    Repeat Keyword    100    Send Message With Webservices To tomte1

*** Keywords ***
Create Message Session
    [Documentation]    This is a POC of how we can address the webservices API.
    ${auth} =    Create List    ${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}    ${DEFAULT_ADMIN_USER.PASSWORD}
    Create Session    ${MESSAGES_WEBSERVICE_SESSION}    ${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]    auth=${auth}

Send Message With Webservices To ${driver_id}
    [Documentation]    This is a POC of how we can address the webservices API.
    ${text_message} =    FakerLibrary.Sentences
    &{headers} =    Create Dictionary    Content-Type=application/json    Accept=application/json
    &{data} =    Create Dictionary    IsAcknowledgeRead=true    IsAcknowledgeReceived=true    IsReplyRequired=false    MessageType=textMessage    Priority=Normal
    ...    RecipientIds=${driver_id}    Recipients=    Sid=00000000-0000-0000-0000-000000000000    TextMessage=Webserver Test: ${text_message}[0]    Title=
    ${resp} =    Post Request    ${MESSAGES_WEBSERVICE_SESSION}    ${MESSAGING_WEBSERVICE_MESSAGES_EXT}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
