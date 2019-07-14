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

  Input Text  name:email  testaddress3@waldbuehne-heessen.de
  Submit Form  class:elgg-form-usersettings-save

  Element Attribute Value Should Be  name:email  value  testaddress3@waldbuehne-heessen.de

  Input Text  name:email  ${EMAILADRESS}
  Submit Form  class:elgg-form-usersettings-save

  Element Attribute Value Should Be  name:email  value  testaddress1@waldbuehne-heessen.de

Check Profile
  [Documentation]  Check the user's profile
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Click Element  css:${parentBar} a[data-menu-item-name=profile] 

  Take Current Screenshot  user-profile

  Element Should Be Visible  css:#profile-details h2
  Element Should Contain  css:div#custom_fields_userdetails  Geburtstag: 2018-08-11
  Element Should Contain  css:div#custom_fields_userdetails  Telefon: +492381123456
  Element Should Contain  css:div#custom_fields_userdetails  Straße: Musterstraße 25
  Element Should Contain  css:div#custom_fields_userdetails  PLZ: 59073
  Element Should Contain  css:div#custom_fields_userdetails  Ort: Hamm
  Element Should Contain  css:div#custom_fields_userdetails  Hat keine E-Mail: nein
  Element Should Contain  css:div#custom_fields_userdetails  Mitglied seit: 2018
  Element Should Contain  css:div#profile-email  E-Mail: testaddress1@waldbuehne-heessen.de

Check Other Profile
  [Documentation]  Check the profile of another user

  HomePage.Logout
  Close All Browsers  
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To  %{MEMBERS_TEST_BASEURL}/profile/%{MEMBERS_TEST_USERNAME}

  Take Current Screenshot  user-other-profile

  Element Should Be Visible  css:#profile-details h2
  Element Should Not Contain  css:div#custom_fields_userdetails  Geburtstag: 2018-08-11
  Element Should Contain  css:div#custom_fields_userdetails  Telefon: +492381123456
  Element Should Not Contain  css:div#custom_fields_userdetails  Straße: Musterstraße 25
  Element Should Not Contain  css:div#custom_fields_userdetails  PLZ: 59073
  Element Should Not Contain  css:div#custom_fields_userdetails  Ort: Hamm
  Element Should Contain  css:div#custom_fields_userdetails  Hat keine E-Mail: nein
  Element Should Contain  css:div#custom_fields_userdetails  Mitglied seit: 2018
  Element Should Contain  css:div#profile-email  E-Mail: testaddress1@waldbuehne-heessen.de

  HomePage.Logout
  Close All Browsers  
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Change Profile
  [Documentation]  Check the workflow of changing the profile
  Go To Menu  Einstellungen
  Click Element  css:a[data-menu-item-name=edit_profile]  

  Input Text  name:birthday  1970-01-01
  Input Text  name:telephone  1234567890
  Input Text  street  test12345
  Input Text  zip  12345
  Input Text  city  testcity

  Element Should Be Disabled  name:member_since
  Element Should Be Disabled  name:away_years

  Submit Form  class:elgg-form-profile-edit

  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Click Element  css:${parentBar} a[data-menu-item-name=profile] 

  Element Should Be Visible  css:#profile-details h2
  Element Should Contain  css:div#custom_fields_userdetails  Geburtstag: 1970-01-01
  Element Should Contain  css:div#custom_fields_userdetails  Telefon: 1234567890
  Element Should Contain  css:div#custom_fields_userdetails  Straße: test12345
  Element Should Contain  css:div#custom_fields_userdetails  PLZ: 12345
  Element Should Contain  css:div#custom_fields_userdetails  Ort: testcity

  Go To Menu  Einstellungen
  Click Element  css:a[data-menu-item-name=edit_profile]  

  Input Text  name:birthday  2018-08-11
  Input Text  name:telephone  +492381123456
  Input Text  street  Musterstraße 25
  Input Text  zip  59073
  Input Text  city  Hamm

  Submit Form  class:elgg-form-profile-edit

  Check Profile