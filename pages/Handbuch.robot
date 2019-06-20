*** Settings ***

Documentation  Handbuch page features
Library  SeleniumLibrary
Library  String
Library  OperatingSystem
Library  DateTime
Resource  PageIdentification.robot
Resource  HomePage.robot
Resource  BasicNavigation.robot
Resource  Constants.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}
  Go To Menu  Handbuch
  I Am On  Handbuch
  Take Current Screenshot  handbuch
