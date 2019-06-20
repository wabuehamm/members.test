*** Settings ***

Documentation  Search page features
Library  SeleniumLibrary
Resource  HomePage.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Search For Events
  [Documentation]  Check for searching for events
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)

  Input Text  jquery:${parentBar} .elgg-menu-item-search input[name=q]  Rollenverteilung
  Submit Form  css:${parentBar} .elgg-menu-item-search form

  Take Current Screenshot  suche-termin

  Click Element  css:a[data-menu-item-name="item:object:event_calendar"]
  ${events} =  Get Element Count  css:.search-list li
  Should Be True  ${events} >= 1

Search For Forum Posts
  [Documentation]  Check for searching for forum posts
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  
  Input Text  jquery:${parentBar} .elgg-menu-item-search input[name=q]  Rollenverteilung
  Submit Form  css:${parentBar} .elgg-menu-item-search form

  Take Current Screenshot  suche-forum

  Click Element  css:a[data-menu-item-name="item:object:discussion"]
  ${events} =  Get Element Count  css:.search-list li
  Should Be True  ${events} >= 1

Search For People
  [Documentation]  Check for searching for people
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  
  Input Text  jquery:${parentBar} .elgg-menu-item-search input[name=q]  Hesse
  Submit Form  css:${parentBar} .elgg-menu-item-search form

  Take Current Screenshot  suche-mitglieder

  Click Element  css:a[data-menu-item-name="item:user"]
  ${events} =  Get Element Count  css:.search-list li
  Should Be True  ${events} >= 1