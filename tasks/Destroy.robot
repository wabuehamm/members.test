*** Settings ***

Library  SeleniumLibrary
Resource  ../pages/Homepage.robot
Resource  ../pages/BasicNavigation.robot
Resource  ../pages/Utils.robot
Task Setup  Tearup Application
Task Teardown  Teardown Application

*** Tasks ***

Delete First User
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  chrome
  Login  %{MEMBERS_TEST_ADMIN_USERNAME}  %{MEMBERS_TEST_ADMIN_PASSWORD}

  Go To  %{MEMBERS_TEST_BASEURL}/profile/%{MEMBERS_TEST_USERNAME}
  Click Element  class:profile-admin-menu-toggle
  Click Element  css:.profile-admin-menu-wrapper li[data-menu-item=delete]
  Handle Alert
  Wait Until Element Is Visible  class:elgg-message
  Element Text Should Be  class:elgg-message  Der Benutzeraccount %{MEMBERS_TEST_USER_DISPLAYNAME} wurde gelöscht.

Delete Second User
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  chrome
  Login  %{MEMBERS_TEST_ADMIN_USERNAME}  %{MEMBERS_TEST_ADMIN_PASSWORD}

  Go To  %{MEMBERS_TEST_BASEURL}/profile/%{MEMBERS_TEST_SECOND_USERNAME}
  Click Element  class:profile-admin-menu-toggle
  Click Element  css:.profile-admin-menu-wrapper li[data-menu-item=delete]
  Handle Alert
  Wait Until Element Is Visible  class:elgg-message
  Element Text Should Be  class:elgg-message  Der Benutzeraccount %{MEMBERS_TEST_SECOND_USER_DISPLAYNAME} wurde gelöscht.