import requests

url = "https://d3ws.xataxrs.com/DeviceWebService.svc/devices"

payload = " [{\r\n        \"BelongsToDeviceResourceGroups\":[\"Gnome Shipping D3\"],\r\n        \"BluetoothAddress\":\"\",\r\n        \"CarrierDisplayName\":\"Other\",\r\n        \"CompanyName\":\"Gnome Shipping D3\",\r\n        \"CreateDate\":\"\",\r\n        \"Description\":\"Test\",\r\n        \"DeviceType\":\"Nexus\",\r\n        \"FixedDisplay\":\"False\",\r\n        \"IsChanged\":\"False\",\r\n        \"LastCommunication\":\"\",\r\n        \"LastDriverID\":\"\",\r\n        \"LastDriverName\":\"\",\r\n        \"LastVehicleID\":\"\",\r\n        \"ModifiedBy\":\"\",\r\n        \"ModifiedDate\":\"\",\r\n        \"OrganizationID\":\"46663\",\r\n        \"OrganizationName\":\"Gnome Shipping D3\",\r\n        \"PhoneNumber\":\"2302302323\",\r\n        \"SendInstallLink\":\"False\",\r\n        \"Status\":\"Active\",\r\n        \"StoreGNISFileOnMobile\":\"True\",\r\n        \"UserDefinedField1\":\"\",\r\n        \"UserDefinedField2\":\"\",\r\n        \"UserDefinedField3\":\"\",\r\n        \"UserDefinedField4\":\"\",\r\n        \"UserDefinedField5\":\"\"\r\n        }]"
headers = {
    'Content-Type': "application/json",
    'Accept': "application/json",
    'Authorization': "Basic R25vbWVTaGlwcGluZ0QzfGtzdGluZTp4cnMxMjM=",
    'User-Agent': "PostmanRuntime/7.20.1",
    'Cache-Control': "no-cache",
    'Postman-Token': "53ac9ff8-5860-4884-bbd3-ede28725ddfe,c398d6bc-8c6b-403b-8335-e73ec6695b6c",
    'Host': "d3ws.xataxrs.com",
    'Accept-Encoding': "gzip, deflate",
    'Content-Length': "909",
    'Connection': "keep-alive",
    'cache-control': "no-cache"
    }

response = requests.request("POST", url, data=payload, headers=headers)

print(response.text)