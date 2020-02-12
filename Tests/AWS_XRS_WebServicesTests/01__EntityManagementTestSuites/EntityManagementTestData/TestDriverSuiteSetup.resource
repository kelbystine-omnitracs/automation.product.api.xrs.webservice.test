*** Settings ***
Documentation  Keywords for setting up suite test data.
Variables       ./TestDriverData.yaml
Variables       ../../../../Data/TestBenchDefinitions/${XRS_TEST_BENCH_FOLDER_NAME}/CompanyDefinition.yaml

*** Keywords ***
Test Data Setup For XRS AWS Driver Web Service Test Suite
  [Documentation]  Keyword for setting up suite variables for AWS Driver Web Service Tests.
  # Create post test driver 1 data.
  &{XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_1_DICT} =  Create Dictionary
  ...  CDLNumber=${XRS_WEB_SERVICES_TEST_DRIVER_1.CDLNumber}
  ...  DriverID=${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}
  ...  DefaultHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.DefaultHOSRule}
  ...  ELDExempt=${XRS_WEB_SERVICES_TEST_DRIVER_1.ELDExempt}
  ...  EnableBigDay=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableBigDay}
  ...  EnableDriverPortal=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableDriverPortal}
  ...  EnableHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableHOSRule}
  ...  EnablePersonalConveyance=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnablePersonalConveyance}
  ...  EnableTimeClock=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableTimeClock}
  ...  EnableYardMove=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableYardMove}
  ...  FirstName=${XRS_WEB_SERVICES_TEST_DRIVER_1.FirstName}
  ...  Language=${XRS_WEB_SERVICES_TEST_DRIVER_1.Language}
  ...  LastName=${XRS_WEB_SERVICES_TEST_DRIVER_1.LastName}
  ...  LicenseIssuingCountry=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingCountry}
  ...  LicenseIssuingStateProvince=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingStateProvince}
  ...  MiddleName=${XRS_WEB_SERVICES_TEST_DRIVER_1.MiddleName}
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  OrganizationSID=${XRS_WEB_SERVICES_TEST_DRIVER_1.OrganizationSID}
  ...  Password=${XRS_WEB_SERVICES_TEST_DRIVER_1.Password}
  ...  SendInboundMessageTo=${XRS_WEB_SERVICES_TEST_DRIVER_1.SendInboundMessageTo}
  ...  SID=${XRS_WEB_SERVICES_TEST_DRIVER_1.SID}
  ...  Status=${XRS_WEB_SERVICES_TEST_DRIVER_1.Status}
  ...  UseHOSOrganizationSettings=${XRS_WEB_SERVICES_TEST_DRIVER_1.UseHOSOrganizationSettings}
  ...  UserName=${XRS_WEB_SERVICES_TEST_DRIVER_1.UserName}
  @{XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_POST_TEST_DRIVER_LIST}
  # Create put test driver 1 data.
  &{XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_1_DICT} =  Create Dictionary
  ...  DriverID=${XRS_WEB_SERVICES_TEST_DRIVER_1.DriverID}
  ...  DefaultHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.DefaultHOSRule}
  ...  ELDExempt=${XRS_WEB_SERVICES_TEST_DRIVER_1.ELDExempt}
  ...  EnableBigDay=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableBigDay}
  ...  EnableDriverPortal=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableDriverPortal}
  ...  EnableHOSRule=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableHOSRule}
  ...  EnablePersonalConveyance=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnablePersonalConveyance}
  ...  EnableTimeClock=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableTimeClock}
  ...  EnableYardMove=${XRS_WEB_SERVICES_TEST_DRIVER_1.EnableYardMove}
  ...  FirstName=${XRS_WEB_SERVICES_TEST_DRIVER_1.FirstName}
  ...  Language=${XRS_WEB_SERVICES_TEST_DRIVER_1.Language}
  ...  LastName=${XRS_WEB_SERVICES_TEST_DRIVER_1.LastName}
  ...  LicenseIssuingCountry=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingCountry}
  ...  LicenseIssuingStateProvince=${XRS_WEB_SERVICES_TEST_DRIVER_1.LicenseIssuingStateProvince}
  ...  MiddleName=This has been changed.
  ...  OrganizationSID=${XRS_WEB_SERVICES_TEST_DRIVER_1.OrganizationSID}
  ...  SendInboundMessageTo=${XRS_WEB_SERVICES_TEST_DRIVER_1.SendInboundMessageTo}
  ...  SID=${XRS_WEB_SERVICES_TEST_DRIVER_1.SID}
  ...  Status=${XRS_WEB_SERVICES_TEST_DRIVER_1.Status}
  ...  UseHOSOrganizationSettings=${XRS_WEB_SERVICES_TEST_DRIVER_1.UseHOSOrganizationSettings}
  ...  UserName=${XRS_WEB_SERVICES_TEST_DRIVER_1.UserName}
  @{XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_LIST} =  Create List  ${XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_1_DICT}
  Set Suite Variable  @{XRS_AWS_WEBSERVICE_PUT_TEST_DRIVER_LIST}
  # Create test params
  ${yyyy}	${mm}	${dd} =	Get Time	year,month,day
  &{XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS} =  Create Dictionary
  ...  OrganizationID=${XRS_GENERAL_INFORMATION.Company.Company_ID}
  ...  IsActive=True
  ...  AsOfDateTime=${mm}/${dd}/${yyyy}
  Set Suite Variable  &{XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS}
  ${GET_DRIVERS_PARAMS_STRING} =  Catenate  SEPARATOR=&
  ...  OrganizationID=${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS.OrganizationID}
  ...  IsActive=${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS.IsActive}
  ...  AsOfDateTime=${XRS_AWS_WEBSERVICE_DRIVER_TEST_PARAMS.AsOfDateTime}
  Set Suite Variable  ${GET_DRIVERS_PARAMS_STRING}

Get ${key} Value From ${response} And Set Test Suite Variable
    [Documentation]  Set a Suite variable for the delete driver test
    ${XRS_WEB_SERVICES_TEST_DRIVER_1_SID} =  ParseResponse.Get Value From Response With Key  ${key}  ${response}
    Set Suite Variable  ${XRS_WEB_SERVICES_TEST_DRIVER_1_SID}