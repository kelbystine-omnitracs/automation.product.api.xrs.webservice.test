** Settings ***
Documentation  Keyword library for interacting with the Entity > User Webservices
Library  RequestsLibrary
Resource  ../../XRS_WebServices/Toolbox/URIStringBuilderTool.resource
Resource  ../../XRS_WebServices/XRSCommonWebService.resource
Variables  ../../XRS_WebServices/XRSWebServicesBaseURI.yaml

*** Variables ***
${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS} =  /users

*** Keywords ***
Get User By ID
    [Arguments]  ${user_id}
    [Documentation]  Get attributes for a specific user by specifying a user id value.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.User}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}/${user_id}
    ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Delete User By ID
    [Arguments]  ${user_id}
    [Documentation]  Delete a single user record in Omnitracs XRS by specifying the user id.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.User}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}/${user_id}
    ${response} =  Delete Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Post Users
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Users.
    ...  Accepts a list of json objects
    ...  Json field definitions:
    ...  AccountLocked  # String [Boolean]  True [False]  ***Required***
    ...    Indicates if this user account is currently locked or unlocked.
    ...  AlertSubscriptionIDs  # String [Collection of ResourceGroupID values]  Comma separated list of AlertSubscriptionIDs  ***Not Required***
    ...    The list of Alerts to which this user is to be subscribed.
    ...    Changing this value is not allowed in the Put method call until a future release – it must be changed manually on the host website.
    ...  AlertSubscriptionsChanged  # String [Boolean]  True False  ***Read Only***
    ...    A read-only field indicating if the Alert Subscription field has changed since the AsOfDateTime query parameter value.
    ...  AllowedSingleSignOn  # String [Boolean]  True [False]  ***Not Required***
    ...    Indicates if single sign on is enable for this user.
    ...  BelongsToResourceGroups  # String [Collection of ResourceGroupID values]  Comma separated list of ResourceGroupIDs  ***Not Required***
    ...    Indicates the set of ResourceGroupIDs to which the user should belong.
    ...    NOTE: If a resource group is not provided in a Post call, 
    ...    the new User is to be placed in the default resource group for the organization to which the new User is being added.
    ...    Changing this value is not allowed in the Put method call until a future release – it must be changed manuall on the host website.
    ...  BelongsToResourceGroupsChanged  # String [Boolean]  True [False]  ***Read Only***
    ...    A read-only field indicating if the BelongsToResourceGroup field has changed since the AsOfDateTime query parameter value.
    ...  CompanyName  # String  Alpha-numeric  ***Read Only***
    ...    The user defined name of the company.
    ...  CreateDate  # String  [1900-01-01T00:00:00]  DateTime  ***Read Only***
    ...    A read-only field indicating the date and time the user object was created.
    ...  DashboardName  # String  [Fleet Compliance Dashboard] None, Fleet Compliance Dashboard  Max 20 characters  ***Required***
    ...    Inidicates which dashboard display will be presented to the user on the Omnitracs XRS dashboard when a user logs in.
    ...  Email  # String  3-50 characters  ***Required***
    ...    The email address for the user.
    ...  EmailIncomingDriverMessages  # Boolean  True [False]  ***Not Required***
    ...    Indicates if messages from driver destined for this user will be emailed to the users email address.
    ...  EmailPassword  # String [Boolean]  True [False]  ***Not Required***
    ...    Indicates if the password provided in the Password field will be emailed to the user upon creation of the user.
    ...  EmailRejectedCount  # String  Positive Numberic value  ***Read Only***
    ...    A read-only field indicating the count of the number of unsuccessful attempts to email the password
    ...    to the user at the specified email address in the Email field.
    ...  EmailVerificationExpirationDate  # String  [1900-01-01T00:00:00] DateTime  ***Read Only***
    ...    A read-only field indicating
    ...  EmailVerificationKey  # String  Max 20 characters  ***Read Only***
    ...    Is this needed to decrypt provided password when calling Get method?
    ...  EmailVerified  # String [Boolean] True [False]  ***Read Only***
    ...    Indicates the email address has been verified by Omnitracs XRS.
    ...  EncryptedPassword  # String  3-50 characters  ***Required***  ***Not Required***
    ...    This field does not need to be encrypted by the caller in a post or put.
    ...    The Omnitracs XRS system encrypts it for the user as a part of the post/put method execution.
    ...    This field IS is encrypted in the returns from the Get method.
    ...  FirstName  # String  Max 20 characters  ***Required***
    ...    The first name of the user.
    ...  Language  # String  [English] Spanish French  ***Required***
    ...    The language used to present information to the user in the Omnitracs XRS.
    ...  LastLogin  # String  [1900-01-01T00:00:00]  DateTime  ***Read Only***
    ...    The date and time of the last time this user logged in to Omnitracs XRS.
    ...  LastName  # String  Max 20 characters  ***Required***
    ...    The last name of the user.
    ...  MiddleName  # String  Max 20 characters  ***Not Required***
    ...    The middle name of the user.
    ...  ModifiedBy  # String  [Null] Positive Numeric Value  ***Read Only***
    ...    A read-only field indicating the user ID of the last person to modify the user record.
    ...  ModifiedDate  # String  [1900-01-01T00:00:00]  DateTime  ***Read Only***
    ...    A read-only field indicating the date the user record was last modified.
    ...  OrganizationID  # String  Positive Numeric Value  ***Required***
    ...    The user-defined ID of the organization in which the user is located.
    ...  OrganizationName  # String  Alpha-numeric  ***Not Required***
    ...    The user defined name of the organization in which the user is located.
    ...  PasswordNeverExpires  # String [Boolean]  True [False]  ***Required***
    ...    Indicates if the password can expire.
    ...  ScheduleReportSubscriptions  # String [Collection of ResourceGroupID values]  Comma separated list of Schedule Report IDs  ***Not Required***
    ...    A comman separated list of Schedule Report IDs to which the user is subscribed.
    ...    Changing this value is not allowed in the Put method call until a future release – it must be changed manually on the Omnitracs XRS website.
    ...  ScheduledReportSubscriptionsChanged  # String [Boolean] True [False] ***Read Only***
    ...    A read-only field indicating if the ScheduledReportSubscriptions field has changed since the AsOfDateTime query parameter value.
    ...  SendAlertsToEmail  # String [Boolean]  True [False]  ***Not Required***
    ...    Indicates if alerts to which the user has subscribed will be sent to that users email address.
    ...  SendAlertsToMessageInbox  # String [Boolean]  True [False]  ***Not Required***
    ...    Indicates if alerts to which the user has subscribed will be sent to that users message inbox.
    ...  Status  # String  [Active] Inactive  ***Required***
    ...    Identifies if a user is active or inactive in Omnitracs XRS. The value of this field must be Active or Inactive.
    ...  UserDefinedField1  # String  [Null] Max length 100 characters  ***Not Required***
    ...    User-defined field #1
    ...  UserDefinedField2  # String  [Null] Max length 100 characters  ***Not Required***
    ...    User-defined field #2
    ...  UserDefinedField3  # String  [Null] Max length 100 characters  ***Not Required***
    ...    User-defined field #3
    ...  UserDefinedField4  # String  [Null] Max length 100 characters  ***Not Required***
    ...    User-defined field #4
    ...  UserDefinedField5  # String  [Null] Max length 100 characters  ***Not Required***
    ...    User-defined field #5
    ...  UserName  # String  3-50 characters  ***Required***
    ...    The name the user will use to log into Omnitracs XRS.
    ...  UserRole  # String  3-50 characters  ***Required***
    ...    The role to which the user has been assigned.
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.User}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}
    ${response} =  Post Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Put Users
    [Arguments]  @{list_data}
    [Documentation]  Calls the Post Method for Userss.
    ...  Accepts a list of json objects
    ...  See Json field definitions in the "Post Users" Keyword 
    ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.User}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}
    ${response} =  Put Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  json=${list_data}  headers=${XRS_WEBSERVICES_JSON_HEADER}
    [Return]  ${response}

Get Users
  [Arguments]  &{params}
  [Documentation]  Call the Get Method on users.
  ...  This will get users that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  Param Definitions:
  ...  AsOfDateTime  # Default Value [No Filter]
  ...      Tells the service to return only the data that changed since the specified date and time.
  ...  IsActive  # Default Value [No Filter]
  ...      Filters results to active users only.
  ...      True, False, Both
  ...  Limit  # Default Value 100
  ...      Used in conjunction with the Offset parameter to implement paging.
  ...      Limits the number of results to a specified number.
  ...      System Limit: 10,000
  ...  Offset  # Default Value 1
  ...      Used in conjunction with the Limit parameter to implement paging.
  ...      Represents a page number for the starting point of the return set.
  ...  OrganizationID  # Default Value [No Filter]
  ...      Limits results to users in one or more organizations.
  ...      Maximum of 20 characters.
  ...  PhoneNumber  # Default Value [No Filter]
  ...      The following values can be specified:
  ...      [No Filter] - Limits results to all user records within the Web Service users' OrganizationID and ResourceGroupID.
  ...      10 character phone number - Limits results to the user record within the Web Service users' OrganizationID and ResourceGroupID
  ...      Example value: 1234567890
  ...  ResourceGroupID  # Default Value [No Filter]
  ...      Limits results to users in one or more resource groups.
  ...  UserID  # Default Long - Positive Numeric Value
  ...      Limits the results to the user object with the specified userID in the Web Service user's OrganizationID and ResourceGroupID.
  ...      Maximum of 20 characters.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.User}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get Users With URI Ending With ${ending_character} And Parameters ${params}
  [Documentation]  This Keyword modifies character between the base uri and the parameters
  ...  This will get users that match the provided parameters.
  ...  Params can be named individually or within a Dictionary
  ...  See the Get Users Keyword for param definitions.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.User}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}${ending_character}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}  params=${params}
  [Return]  ${response}

Get All Users
  [Documentation]  Get attributes for all userss.
  ${uri} =  Set Variable  ${XRS_Entity_Management_Base_URI.User}${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response}

# Helper Keywords
Get Users Response Code Without Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code with '?' before the parameters.
  ${response} =  Get Users  &{params}
  [Return]  ${response.status_code}

Get Users Response Code With Forward Slash
  [Arguments]  &{params}
  [Documentation]  Returns the response code when the character '/' is placed before '?'.
  ${response} =  Get Users With URI Ending With / And Parameters &{params}
  [Return]  ${response.status_code}

Get Users Raw String URI Response Code With ${character_string} And Parameters ${params_string}
  [Documentation]  Uses the given character string to create raw URI string Get request
  ...  ${character_string} is a set of 1+ characters
  ...  ${params_string} is a series of '&' delimited parameters 
  ${uri_string} =  Create URI String With  ${XRS_Entity_Management_Base_URI.User}  ${XRS_WEBSERVICE_ENTITY_MANAGEMENT_POST_GET_PUT_DELETE_USERS}  ${character_string}
  ${uri} =  Set Variable  ${uri_string}${params_string}
  ${response} =  Get Request  ${XRS_WEB_SERVICE_SESSION_ALIAS}  ${uri}  headers=${XRS_WEBSERVICES_JSON_HEADER}
  [Return]  ${response.status_code}