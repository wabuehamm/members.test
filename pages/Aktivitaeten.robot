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
  ${ITEMS} =  Get Element Count  css:li.elgg-item-river

  Should Be Equal As Integers  ${ITEMS}  ${EXPECTED_ACTIVITY_STREAM_ITEMS}

  Element Should Be Visible  jquery:li.elgg-state-selected:contains(1)
  
  Click Element  jquery:a.elgg-anchor:contains(Weiter)
  
  Element Should Be Visible  jquery:li.elgg-state-selected:contains(2)