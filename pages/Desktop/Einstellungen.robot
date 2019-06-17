*** Settings ***

Documentation  Einstellungen page features
Library  SeleniumLibrary
Resource  PageIdentification.robot
Resource  HomePage.robot
Resource  BasicNavigation.robot
Resource  ../Constants.robot
Resource  ../Utils.robot

*** Keywords ***

Go to Page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}
  Go To Menu  Einstellungen
  I Am On  Einstellungen
  Take Current Screenshot  einstellungen

Check Change Password
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
  Go To Menu  Einstellungen
  ${EMAILADRESS} =  Get Value  name:email

  Input Text  name:email  test@test.com
  Submit Form  class:elgg-form-usersettings-save

  Element Attribute Value Should Be  name:email  value  test@test.com

  Input Text  name:email  ${EMAILADRESS}
  Submit Form  class:elgg-form-usersettings-save

  Element Attribute Value Should Be  name:email  value  ${EMAILADRESS}