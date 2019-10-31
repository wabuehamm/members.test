*** Settings ***

Documentation  Members list page features
Library  SeleniumLibrary
Library  String
Resource  PageIdentification.robot
Resource  HomePage.robot
Resource  BasicNavigation.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}
  Go To Menu  Spielerliste
  I Am On  Spielerliste
  Take Current Screenshot  spielerliste

Check Search Feature
  [Documentation]  Check the search feature for availability
  Element Should Be Visible  member_query

Check Memberlist
  [Documentation]  Check the list of members for validity
  ${listElements} =  Get Element Count  css:.elgg-item-user
  Should Be Equal As Numbers  ${listElements}  10
  ${numberOfMembers} =  Get Text  css:.elgg-form-members-search p.elgg-text-help
  ${members} =  Get Regexp Matches  ${numberOfMembers}  Gesamtzahl der Mitglieder: ([0-9]+)  1
  Should Be True  ${members}[0] > 300
  Element Should Not Be Visible  css:li[data-menu-item=popular]

Check Pagination
  [Documentation]  Check the pagination features
  Element Should Be Visible  class:elgg-pagination
  ${pages} =  Get Element Count  css:ul.elgg-pagination li
  Should Be True  ${pages} > 5