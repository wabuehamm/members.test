*** Settings ***

Library  SeleniumLibrary
Resource  ../pages/Homepage.robot
Resource  ../pages/BasicNavigation.robot
Resource  ../pages/Utils.robot
Task Setup  Tearup Application
Task Teardown  Teardown Application

*** Tasks ***

Create First User
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  chrome
  Login  %{MEMBERS_TEST_ADMIN_USERNAME}  %{MEMBERS_TEST_ADMIN_PASSWORD}
  Go To Menu  Admin
  Click Element  css:li[data-menu-item=users]
  Wait Until Element Is Visible  css:li[data-menu-item="users:add"]
  Click Element  css:li[data-menu-item="users:add"]

  Input Text  name:name  %{MEMBERS_TEST_USER_DISPLAYNAME}
  Input Text  name:username  %{MEMBERS_TEST_USERNAME}
  Input Text  email  testaddress1@waldbuehne-heessen.de
  Input Password  name:password  %{MEMBERS_TEST_PASSWORD}
  Input Password  name:password2  %{MEMBERS_TEST_PASSWORD}

  Input Text  name=custom_profile_fields[birthday]  2018-08-11
  Input Text  name=custom_profile_fields[telephone]  +492381123456
  Input Text  name=custom_profile_fields[street]  Musterstraße 25
  Input Text  name=custom_profile_fields[zip]  59073
  Input Text  name=custom_profile_fields[city]  Hamm
  Select From List By Label  name=custom_profile_fields[no_mail]  nein
  Input Text  name=custom_profile_fields[member_since]  2018
  Input Text  name=custom_profile_fields[away_years]  0

  Click Button  class:elgg-button-submit
  
  Wait Until Element Is Visible  class:elgg-message    
  Element Text Should Be  class:elgg-message  Es wurde ein neuer Benutzer hinzugefügt.

  Log  Editing member profile to secure fields, which didn't happen when the user was created. This is a known bug.  level=WARN      
  Go To  %{MEMBERS_TEST_BASEURL}/profile/%{MEMBERS_TEST_USERNAME}/edit
  Click Button  class:elgg-button-submit


Create Second User
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  chrome
  Login  %{MEMBERS_TEST_ADMIN_USERNAME}  %{MEMBERS_TEST_ADMIN_PASSWORD}
  Go To Menu  Admin
  Click Element  css:li[data-menu-item=users]
  Wait Until Element Is Visible  css:li[data-menu-item="users:add"]
  Click Element  css:li[data-menu-item="users:add"]

  Input Text  name:name  %{MEMBERS_TEST_SECOND_USER_DISPLAYNAME}
  Input Text  name:username  %{MEMBERS_TEST_SECOND_USERNAME}
  Input Text  email  testadress2@waldbuehne-heessen.de
  Input Password  name:password  %{MEMBERS_TEST_SECOND_PASSWORD}
  Input Password  name:password2  %{MEMBERS_TEST_SECOND_PASSWORD}

  Input Text  name=custom_profile_fields[birthday]  2018-08-11
  Input Text  name=custom_profile_fields[telephone]  +492381123456
  Input Text  name=custom_profile_fields[street]  Musterstraße 25
  Input Text  name=custom_profile_fields[zip]  59073
  Input Text  name=custom_profile_fields[city]  Hamm
  Select From List By Label  name=custom_profile_fields[no_mail]  nein
  Input Text  name=custom_profile_fields[member_since]  2018
  Input Text  name=custom_profile_fields[away_years]  0

  Click Button  class:elgg-button-submit
  
  Wait Until Element Is Visible  class:elgg-message    
  Element Text Should Be  class:elgg-message  Es wurde ein neuer Benutzer hinzugefügt.

  Log  Editing member profile to secure fields, which didn't happen when the user was created. This is a known bug.  level=WARN      
  Go To  %{MEMBERS_TEST_BASEURL}/profile/%{MEMBERS_TEST_SECOND_USERNAME}/edit
  Click Button  class:elgg-button-submit