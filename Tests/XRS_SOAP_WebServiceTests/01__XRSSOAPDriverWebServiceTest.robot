*** Settings ***
Documentation  This is a POC for using the SOAP testing in RF.
Library  SudsLibrary
Library  RequestsLibrary
Library    ./SudsLibraryExtension.py
Library    Collections 
Variables  ../../Data/XRSEnvironmentData.yaml
Variables  ../../Resources/XRS_WebServices/XRSWebServicesBaseURI.yaml
Variables  ../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/Users.yaml
Variables  ../../Data/TestBenchDefinitions/%{TEST_BENCH}TestBench/CompanyDefinition.yaml

*** Variables ***
${XRS_WEB_SERVICE_SESSION_ALIAS} =  xrs_web_service_session
@{XRS_WEBSERVICES_AUTHORIZATION} =  ${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}  ${DEFAULT_ADMIN_USER.PASSWORD}
&{XRS_WEBSERVICES_SOAP_HEADER} =  Content-Type=application/soap+xml  Accept=application/soap+xml  Accept-Encoding=gzip, deflate
${XRS_HOST_ENVIRONMENT} =  d3
${XRS_SINGLE_WSDL} =  ?singleWsdl
${SOAP_SVC} =  /soap
${uri} =  ${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]/${XRS_Entity_Management_Base_URI.Driver}${XRS_SINGLE_WSDL}
# &{XRS_WEBSERVICES_AUTHORIZATION} =  username=${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}  password=${DEFAULT_ADMIN_USER.PASSWORD}

*** Test Cases ***
Requests Tests
    [Tags]  soapy
    [Documentation]
    ${body_data} =  Set Variable  <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:tem="http://tempuri.org/">
   ...  <soap:Header/>
   ...  <soap:Body>
   ...     <tem:GetDrivers>
   ...     </tem:GetDrivers>
   ...  </soap:Body>
   ...  </soap:Envelope>
    Create Session  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}
    ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  /  body=${body_data}  auth=${XRS_WEBSERVICES_AUTHORIZATION}  headers=${XRS_WEBSERVICES_SOAP_HEADER}
    Log To Console  ${response}
# import requests
# url="http://wsf.cdyne.com/WeatherWS/Weather.asmx?WSDL"
# #headers = {'content-type': 'application/soap+xml'}
# headers = {'content-type': 'text/xml'}
# body = """<?xml version="1.0" encoding="UTF-8"?>
#          <SOAP-ENV:Envelope xmlns:ns0="http://ws.cdyne.com/WeatherWS/" xmlns:ns1="http://schemas.xmlsoap.org/soap/envelope/" 
#             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
#             <SOAP-ENV:Header/>
#               <ns1:Body><ns0:GetWeatherInformation/></ns1:Body>
#          </SOAP-ENV:Envelope>"""

# response = requests.post(url,data=body,headers=headers)
# print response.content

Get All Drivers
    [Tags]
    [Documentation]
    Set Binding     SOAP-ENV    http://www.w3.org/2003/05/soap-envelope
    Create Soap Client  ${uri}  alias=XRS_SOAP
    Apply Username Token  ${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}  password=${DEFAULT_ADMIN_USER.PASSWORD}
    ${headers} =  Create Dictionary
    ...  Content-Type=application/soap+xml
    ...  Accept=application/soap+xml
    ...  Endcoding=UTF-8
    # ...  Username=${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}
    # ...  Password=${DEFAULT_ADMIN_USER.PASSWORD}
    Set Headers  ${headers}
    Set Headers    Action          "${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]/${XRS_Entity_Management_Base_URI.Driver}/GetDrivers"
    ${wsdlobj} =  Create Wsdl Object  GetDrivers
    &{beer} =  Create Dictionary  isActive=True
    ${response} =  Call Soap Method  GetDrivers  ${wsdlobj}

W3 School
    [Tags]
    [Documentation]
    Create Soap Client  https://www.w3schools.com/xml/tempconvert.asmx?WSDL  alias=W3_SCHOOL
    ${headers} =  Create Dictionary
    ...  Content-Type=application/soap+xml
    ...  Accept=application/soap+xml
    ...  Endcoding=UTF-8
    # ...  Username=${XRS_GENERAL_INFORMATION.Company.Company_Login_ID}|${DEFAULT_ADMIN_USER.USERNAME}
    # ...  Password=${DEFAULT_ADMIN_USER.PASSWORD}
    Set Headers  ${headers}
    ${wsdlobj} =  Create Wsdl Object  CelsiusToFahrenheit
    Set Wsdl Object Attribute  ${wsdlobj}  Celsius  20
    &{beer} =  Create Dictionary  Celsius=20
    ${response} =  Call Soap Method  CelsiusToFahrenheit  ${wsdlobj}

TC
    [Tags]
    [Documentation]
    ${BASE_URL}    Set Variable         ${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]
    ${SERVICE}     Create Dictionary    
    ...                                 name=HolidayService_v2    
    ...                                 wsdl=HolidayService2.asmx?WSDL
    ${PORT}        Set variable         80
    ${METHOD}      Set variable         GetDrivers

    Set Binding     SOAP-ENV    http://www.w3.org/2003/05/soap-envelope
    Create Soap Client     ${uri}
    # Set Port    ${PORT}

    Set Headers    Content-Type    application/soap+xml
    Set Headers  Accept  application/soap+xml
    Set Headers    Charset  UTF-8
    # Set Headers    Soapaction      ${EMPTY}
    Set Headers    Action          "${XRS_WEBSERVICES_URL}[${XRS_HOST_ENVIRONMENT}]/${XRS_Entity_Management_Base_URI.Driver}/${METHOD}"

    ${result}          Call Soap Method     ${METHOD}

*** Keywords ***