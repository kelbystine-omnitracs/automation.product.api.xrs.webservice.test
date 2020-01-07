*** Settings ***
Documentation  Tool for retrieving a random VIN from randomvin.com
Library  RequestsLibrary
Library  String

*** Variables ***
${RANDOM_VIN_ORG_ALIAS} =  random_vin_session_alias
${RANDOM_VIN_ORG_BASE_URI} =  https://randomvin.com
${RANDOM_VIN_ORG_GET_VIN} =  /getvin.php
&{RANDOM_VIN_ORG_HEADER} =  Content-Type=text/html  Accept=*/*  Accept-Encoding=gzip, deflate, br

*** Keywords ***
Create Session For randomvin.com
    [Documentation]  Create a session with Random VIN
    Create Session  ${RANDOM_VIN_ORG_ALIAS}  ${RANDOM_VIN_ORG_BASE_URI}  verify=True

Get Random Valid VIN From randomvin.com
  [Documentation]  Get a random valid fake VIN from random VIN
  &{params} =  Create Dictionary  type=fake
  Create Session For randomvin.com
  ${response} =  Get Request  ${RANDOM_VIN_ORG_ALIAS}  ${RANDOM_VIN_ORG_GET_VIN}  headers=${RANDOM_VIN_ORG_HEADER}  params=${params}
  ${decoded_response} =  Decode Bytes To String  ${response.content}  UTF-8
  ${edited_response} =  Get Line  ${decoded_response}  1
  [Return]  ${edited_response}

Get Random Real VIN From randomvin.com
  [Documentation]  Get a random real VIN from random VIN
  &{params} =  Create Dictionary  type=real
  Create Session For randomvin.com
  ${response} =  Get Request  ${RANDOM_VIN_ORG_ALIAS}  ${RANDOM_VIN_ORG_GET_VIN}  params=${params}
  ${decoded_response} =  Decode Bytes To String  ${response.content}  UTF-8
  ${edited_response} =  Get Line  ${decoded_response}  1
  [Return]  ${edited_response}