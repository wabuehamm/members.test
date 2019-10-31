*** Settings ***

Documentation  Einstellungen page features
Library  SeleniumLibrary
Resource  PageIdentification.robot
Resource  HomePage.robot
Resource  BasicNavigation.robot
Resource  Constants.robot
Resource  Utils.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}
  Go To Menu  Einstellungen
  I Am On  Einstellungen
  Take Current Screenshot  einstellungen

Check Change Password
  [Documentation]  Check the workflow of changing a password
  Go To Menu  Einstellungen
  Input Text  name:current_password  %{MEMBERS_TEST_PASSWORD}
  Input Text  name:password  test12345
  Input Text  name:password2  test12345
  Submit Form  class:elgg-form-usersettings-save
  HomePage.Logout
  Close Browser  

  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  test12345
  
  Go To Menu  Einstellungen
  Input Text  name:current_password  test12345
  Input Text  name:password  %{MEMBERS_TEST_PASSWORD}
  Input Text  name:password2  %{MEMBERS_TEST_PASSWORD}
  Submit Form  class:elgg-form-usersettings-save
  HomePage.Logout
  Close Browser  

  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Check E-Mailadress
  [Documentation]  Check the workflow of changing the E-Mailaddress
  Go To Menu  Einstellungen
  ${EMAILADRESS} =  Get Value  name:email

  Input Text  name:email_password  %{MEMBERS_TEST_PASSWORD}
  Input Text  name:email  testaddress3@waldbuehne-heessen.de
  Submit Form  class:elgg-form-usersettings-save

  Wait Until Element Is Not Visible  class:elgg-spinner

  Element Attribute Value Should Be  name:email  value  testaddress3@waldbuehne-heessen.de

  Input Text  name:email_password  %{MEMBERS_TEST_PASSWORD}
  Input Text  name:email  ${EMAILADRESS}
  Submit Form  class:elgg-form-usersettings-save

  Wait Until Element Is Not Visible  class:elgg-spinner

  Element Attribute Value Should Be  name:email  value  testaddress1@waldbuehne-heessen.de

Check Profile
  [Documentation]  Check the user's profile
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Mouse Over  css:li[data-menu-item=account]
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  css:${parentBar} li[data-menu-item=profile] 
  Click Element  css:${parentBar} li[data-menu-item=profile] 

  Take Current Screenshot  user-profile

  Element Should Contain  css:h2.elgg-heading-main  %{MEMBERS_TEST_USER_DISPLAYNAME}
  Element Should Contain  css:div[data-name=birthday]  2018-08-11
  Element Should Contain  css:div[data-name=telephone]  +492381123456
  Element Should Contain  css:div[data-name=street]  Musterstraße 25
  Element Should Contain  css:div[data-name=zip]  59073
  Element Should Contain  css:div[data-name=city]  Hamm
  Element Should Contain  css:div[data-name=no_mail]  nein
  Element Should Contain  css:div[data-name=member_since]  2018
  Element Should Contain  css:div#profile-email  testaddress1@waldbuehne-heessen.de

Check Other Profile
  [Documentation]  Check the profile of another user

  HomePage.Logout
  Close All Browsers  
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To  %{MEMBERS_TEST_BASEURL}/profile/%{MEMBERS_TEST_USERNAME}

  Take Current Screenshot  user-other-profile

  Element Should Contain  css:h2.elgg-heading-main  %{MEMBERS_TEST_USER_DISPLAYNAME}
  Element Should Not Be Visible  css:div[data-name=birthday]
  Element Should Contain  css:div[data-name=telephone]  +492381123456
  Element Should Not Be Visible  css:div[data-name=street]
  Element Should Not Be Visible  css:div[data-name=zip]
  Element Should Not Be Visible  css:div[data-name=city]
  Element Should Contain  css:div[data-name=no_mail]  nein
  Element Should Contain  css:div[data-name=member_since]  2018
  Element Should Contain  css:div#profile-email  testaddress1@waldbuehne-heessen.de
  
  HomePage.Logout
  Close All Browsers  
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Change Profile
  [Documentation]  Check the workflow of changing the profile
  Go To Menu  Einstellungen
  Click Element  css:li[data-menu-item=edit_profile]  

  Input Text  name:birthday  1970-01-01
  Input Text  name:telephone  1234567890
  Input Text  street  test12345
  Input Text  zip  12345
  Input Text  city  testcity

  Element Should Be Disabled  name:member_since
  Element Should Be Disabled  name:away_years

  Submit Form  class:elgg-form-profile-edit

  Wait Until Element Is Not Visible  class:elgg-message

  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Mouse Over  css:li[data-menu-item=account]
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  css:${parentBar} li[data-menu-item=profile]
  Click Element  css:${parentBar} li[data-menu-item=profile] 

  Element Should Contain  css:h2.elgg-heading-main  %{MEMBERS_TEST_USER_DISPLAYNAME}
  Element Should Contain  css:div[data-name=birthday]  1970-01-01
  Element Should Contain  css:div[data-name=telephone]  1234567890
  Element Should Contain  css:div[data-name=street]  test12345
  Element Should Contain  css:div[data-name=zip]  12345
  Element Should Contain  css:div[data-name=city]  testcity

  Go To Menu  Einstellungen
  Click Element  css:li[data-menu-item=edit_profile]  

  Input Text  name:birthday  2018-08-11
  Input Text  name:telephone  +492381123456
  Input Text  street  Musterstraße 25
  Input Text  zip  59073
  Input Text  city  Hamm

  Submit Form  class:elgg-form-profile-edit

  Wait Until Element Is Not Visible  class:elgg-message

  Check Profile