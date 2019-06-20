*** Settings ***

Documentation  Identification on which page we are
Library  SeleniumLibrary

*** Keywords ***

I Am On
  [Documentation]  A standardized way of checking if we're on an expected page
  [Arguments]  ${PAGE}

  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  I Am On Desktop  ${PAGE}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  I Am On Mobile  ${PAGE}

I Am On Desktop
  [Documentation]  A standardized way of checking if we're on an expected page on desktop
  [Arguments]  ${PAGE}

  Run Keyword If  '${PAGE}' == 'Homepage'  Element Should Be Visible  css:.elgg-page-body input[name="username"]
  Run Keyword If  '${PAGE}' == 'Startpage'  Element Should Be Visible  css:a[data-menu-item-name="profile"]
  Run Keyword If  '${PAGE}' == 'Spielerliste'  Element Text Should Be  css:h2.title  Alle Mitglieder  
  Run Keyword If  '${PAGE}' == 'Termine'  Element Text Should Be  css:h2.title  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Paged'  Element Text Should Be  css:h2.title  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Agenda'  Check Termine Agenda  
  Run Keyword If  '${PAGE}' == 'Termine-Full'  Element Text Should Be  css:h2.title  Alle Events
  Run Keyword If  '${PAGE}' == 'Termine-ICal-Export'  Element Text Should Be  css:div.nav li.elgg-state-selected span  Exportieren
  Run Keyword If  '${PAGE}' == 'Forum'  Element Text Should Be  css:.elgg-layout-title .title  Forum
  Run Keyword If  '${PAGE}' == 'Umfragen'  Element Should Be Visible  jquery:a.is-active  span:contains(Gruppen-Umfragen)
  Run Keyword If  '${PAGE}' == 'Handbuch'  Element Text Should Be  css:h3.title a span  Handbuch zum Mitgliederbereich
  Run Keyword If  '${PAGE}' == 'Aktivitaeten'  Element Text Should Be  css:h2.title  Alle Aktivitäten
  Run Keyword If  '${PAGE}' == 'Private-Nachrichten'  Element Should Be Visible  class:elgg-form-messages-process
  Run Keyword If  '${PAGE}' == 'Einstellungen'  Element Should Be Visible  class:elgg-page-context-settings

I Am On Mobile
  [Documentation]  A standardized way of checking if we're on an expected page on mobile
  [Arguments]  ${PAGE}

  Run Keyword If  '${PAGE}' == 'Homepage'  Element Should Be Visible  css:.elgg-page-body input[name="username"]
  Run Keyword If  '${PAGE}' == 'Startpage'  Element Should Be Visible  class:nav-toggle
  Run Keyword If  '${PAGE}' == 'Spielerliste'  Element Text Should Be  css:h2.title  Alle Mitglieder  
  Run Keyword If  '${PAGE}' == 'Termine'  Element Text Should Be  css:h2.title  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Paged'  Element Text Should Be  css:h2.title  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Agenda'  Check Termine Agenda  
  Run Keyword If  '${PAGE}' == 'Termine-Full'  Element Text Should Be  css:h2.title  Alle Events
  Run Keyword If  '${PAGE}' == 'Termine-ICal-Export'  Element Text Should Be  css:div.nav li.elgg-state-selected span  Exportieren
  Run Keyword If  '${PAGE}' == 'Forum'  Element Text Should Be  css:.elgg-layout-title .title  Forum
  Run Keyword If  '${PAGE}' == 'Umfragen'  Element Should Be Visible  jquery:a.is-active  span:contains(Gruppen-Umfragen)
  Run Keyword If  '${PAGE}' == 'Handbuch'  Element Text Should Be  css:h3.title a span  Handbuch zum Mitgliederbereich
  Run Keyword If  '${PAGE}' == 'Aktivitaeten'  Element Text Should Be  css:h2.title  Alle Aktivitäten
  Run Keyword If  '${PAGE}' == 'Private-Nachrichten'  Element Should Be Visible  class:elgg-form-messages-process
  Run Keyword If  '${PAGE}' == 'Einstellungen'  Element Should Be Visible  class:elgg-page-context-settings

Check Termine Agenda
  [Documentation]  Special keyword for checking wether we're on the Agenda page
  ${title} =  Get Text  css:h2.title
  Should Start With  ${title}  Alle Events (