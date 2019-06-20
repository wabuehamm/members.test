*** Settings ***

Documentation  Activity strem features
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
  Go To  %{MEMBERS_TEST_BASEURL}/activity
  I Am On  Aktivitaeten
  Take Current Screenshot  aktivitaeten

Check Items
  [Documentation]  Check item layout in the "river" aka activity stream
  ${ITEMS} =  Get Element Count  css:div.elgg-inner>div.elgg-list-container>ul.elgg-list>li.elgg-item

  Should Be Equal As Integers  ${ITEMS}  ${EXPECTED_ACTIVITY_STREAM_ITEMS}
  Click Element  css:a.elgg-after
  Wait Until Element Is Not Visible  class:elgg-spinner
  
  ${ITEMS_20} =  Get Element Count  css:div.elgg-inner>div.elgg-list-container>ul.elgg-list>li.elgg-item

  Should Be Equal As Integers  ${ITEMS + 20}  ${ITEMS_20}