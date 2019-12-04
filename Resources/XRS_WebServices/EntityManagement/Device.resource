*** Settings ***
Documentation  Keyword library for interacting with the Entity > Device Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml
# get_device: device/{PHONENUMBER}
#     delete_device: device/{PHONENUMBER}
#     post_devices: devices
#     put_devices: devices
#     get_devices: devices/?OrganizationID={ORGANIZATIONID}&ResourceGroupID={RESOURCEGROUPID}&IsActive={ISACTIVE}&AsOfDateTime={ASOFDATETIME}&Limit={LIMIT}&Offset={OFFSET}

*** Variables ***
${ENTITY_MANAGEMENT_WEBSERVICE_GET_DEVICE_EXT} =  DeviceWebService.svc/devices
# ${XRS_MANAGE_WEBSERVICES_GET_DEVICE} =  
#   Device_REST:
#     base_uri: DeviceWebService.svc
#     get_device: device/{PHONENUMBER}
#     delete_device: device/{PHONENUMBER}
#     post_devices: devices
#     put_devices: devices
#     get_devices: devices/?OrganizationID={ORGANIZATIONID}&ResourceGroupID={RESOURCEGROUPID}&IsActive={ISACTIVE}&AsOfDateTime={ASOFDATETIME}&Limit={LIMIT}&Offset={OFFSET}

*** Keywords ***
Get Device With Phone Number
  [Documentation]  This will get device information for a particular device using the phone number
  [Arguments]  ${phone_number}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_DEVICE_EXT}${phone_number}  headers=${XRS_WEBSERVICES_HEADER}
  [Return]  ${response}

Delete Device With Phone Number
  [Documentation]  This will delete device information for a particular device using the phone number
  [Arguments]  ${phone_number}
  ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION}  ${ENTITY_MANAGEMENT_WEBSERVICE_GET_DEVICE_EXT}${phone_number}  headers=${XRS_WEBSERVICES_HEADER}
  [Return]  ${response}

Post Devices
  [Documentation]  This will post device information.
  [Arguments]  &{data}
  #   [{
  # 	"BelongsToDeviceResourceGroups":["String content"],
  # 	"BluetoothAddress":"String content",
  # 	"CarrierDisplayName":"String content",
  # 	"CompanyName":"String content",
  # 	"CreateDate":"String content",
  # 	"Description":"String content",
  # 	"DeviceType":"String content",
  # 	"FixedDisplay":"String content",
  # 	"IsChanged":"String content",
  # 	"LastCommunication":"String content",
  # 	"LastDriverID":"String content",
  # 	"LastDriverName":"String content",
  # 	"LastVehicleID":"String content",
  # 	"ModifiedBy":"String content",
  # 	"ModifiedDate":"String content",
  # 	"OrganizationID":"String content",
  # 	"OrganizationName":"String content",
  # 	"PhoneNumber":"String content",
  # 	"SendInstallLink":"String content",
  # 	"Status":"String content",
  # 	"StoreGNISFileOnMobile":"String content",
  # 	"UserDefinedField1":"String content",
  # 	"UserDefinedField2":"String content",
  # 	"UserDefinedField3":"String content",
  # 	"UserDefinedField4":"String content",
  # 	"UserDefinedField5":"String content"
  # }]
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}/devices
  ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION}  ${uri}  json=${data} headers=${XRS_WEBSERVICES_HEADER}
  [Return]  ${response}

Get Devices
  [Documentation]  This will get devices that match the provided parameters.
  ...  Params:
  ...  OrganizationID={ORGANIZATIONID}
  ...  ResourceGroupID={RESOURCEGROUPID}
  ...  IsActive={ISACTIVE}
  ...  AsOfDateTime={ASOFDATETIME}
  ...  Limit={LIMIT}
  ...  Offset={OFFSET}
  [Arguments]  &{params}
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.Device}/devices
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION}  ${uri}  headers=${XRS_WEBSERVICES_HEADER}  params=${params}
  [Return]  ${response}