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
  Click Element  css:h1.elgg-heading-site a

  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)

  Input Text  jquery:${parentBar} .search-input  Rollenverteilung
  Submit Form  css:${parentBar} .elgg-search

  Take Current Screenshot  suche-termin

  Click Element  css:li[data-menu-item="item:object:event_calendar"]
  ${events} =  Get Element Count  css:.elgg-module-search-results li.elgg-item
  Should Be True  ${events} >= 1

Search For Forum Posts
  [Documentation]  Check for searching for forum posts
  Click Element  css:h1.elgg-heading-site a

  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  
  Input Text  jquery:${parentBar} .search-input  Rollenverteilung
  Submit Form  css:${parentBar} .elgg-search

  Take Current Screenshot  suche-forum

  Click Element  css:li[data-menu-item="item:object:discussion"]
  ${events} =  Get Element Count  css:.elgg-module-search-results li.elgg-item
  Should Be True  ${events} >= 1

Search For People
  [Documentation]  Check for searching for people
  Click Element  css:h1.elgg-heading-site a

  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  
  Input Text  jquery:${parentBar} .search-input  Hesse
  Submit Form  css:${parentBar} .elgg-search

  Take Current Screenshot  suche-mitglieder

  Click Element  css:li[data-menu-item="item:user:user"]
  ${events} =  Get Element Count  css:.elgg-module-search-results li.elgg-item
  Should Be True  ${events} >= 1