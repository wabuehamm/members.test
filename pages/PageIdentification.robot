*** Settings ***

Documentation  Identification on which page we are
Library  SeleniumLibrary
Library  Dialogs

*** Keywords ***

I Am On
  [Documentation]  A standardized way of checking if we're on an expected page
  [Arguments]  ${PAGE}

  Wait Until Element Is Not Visible  class:elgg-spinner

  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  I Am On Desktop  ${PAGE}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  I Am On Mobile  ${PAGE}

I Am On Desktop
  [Documentation]  A standardized way of checking if we're on an expected page on desktop
  [Arguments]  ${PAGE}
  
  Run Keyword If  '${PAGE}' == 'Homepage'  Element Should Be Visible  css:.elgg-page-body input[name="username"]
  Run Keyword If  '${PAGE}' == 'Startpage'  Element Should Be Visible  css:div.elgg-nav-logo
  Run Keyword If  '${PAGE}' == 'Spielerliste'  Element Text Should Be  css:h2.elgg-heading-main  Alle Mitglieder  
  Run Keyword If  '${PAGE}' == 'Termine'  Element Text Should Be  css:h2.elgg-heading-main  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Paged'  Element Text Should Be  css:h2.elgg-heading-main  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Agenda'  Check Termine Agenda  
  Run Keyword If  '${PAGE}' == 'Termine-Full'  Element Text Should Be  css:h2.elgg-heading-main  Alle Events
  Run Keyword If  '${PAGE}' == 'Termine-ICal-Export'  Element Text Should Be  css:li.elgg-state-selected span  Exportieren
  Run Keyword If  '${PAGE}' == 'Forum'  Element Text Should Be  class:elgg-heading-main  Diskussionen
  Run Keyword If  '${PAGE}' == 'Umfragen'  Element Text Should Be  css:h2.elgg-heading-main  Umfragen von Forum
  Run Keyword If  '${PAGE}' == 'Handbuch'  Element Text Should Be  css:h2.elgg-heading-main  Handbuch zum Mitgliederbereich
  Run Keyword If  '${PAGE}' == 'Aktivitaeten'  Element Text Should Be  css:h2.elgg-heading-main  Alle Aktivitäten
  Run Keyword If  '${PAGE}' == 'Private-Nachrichten'  Element Should Be Visible  class:elgg-form-messages-process
  Run Keyword If  '${PAGE}' == 'Einstellungen'  Element Should Be Visible  class:elgg-form-usersettings-save

I Am On Mobile
  [Documentation]  A standardized way of checking if we're on an expected page on mobile
  [Arguments]  ${PAGE}

  Run Keyword If  '${PAGE}' == 'Homepage'  Element Should Be Visible  css:.elgg-page-body input[name="username"]
  Run Keyword If  '${PAGE}' == 'Startpage'  Element Should Be Visible  css:div.elgg-nav-logo
  Run Keyword If  '${PAGE}' == 'Spielerliste'  Element Text Should Be  css:h2.elgg-heading-main  Alle Mitglieder  
  Run Keyword If  '${PAGE}' == 'Termine'  Element Text Should Be  css:h2.elgg-heading-main  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Paged'  Element Text Should Be  css:h2.elgg-heading-main  Alle bevorstehenden Events
  Run Keyword If  '${PAGE}' == 'Termine-Agenda'  Check Termine Agenda  
  Run Keyword If  '${PAGE}' == 'Termine-Full'  Element Text Should Be  css:h2.elgg-heading-main  Alle Events
  Run Keyword If  '${PAGE}' == 'Termine-ICal-Export'  Element Text Should Be  css:li.elgg-state-selected span  Exportieren
  Run Keyword If  '${PAGE}' == 'Forum'  Element Text Should Be  class:elgg-heading-main  Diskussionen
  Run Keyword If  '${PAGE}' == 'Umfragen'  Element Text Should Be  css:h2.elgg-heading-main  Umfragen von Forum
  Run Keyword If  '${PAGE}' == 'Handbuch'  Element Text Should Be  css:h2.elgg-heading-main  Handbuch zum Mitgliederbereich
  Run Keyword If  '${PAGE}' == 'Aktivitaeten'  Element Text Should Be  css:h2.elgg-heading-main  Alle Aktivitäten
  Run Keyword If  '${PAGE}' == 'Private-Nachrichten'  Element Should Be Visible  class:elgg-form-messages-process
  Run Keyword If  '${PAGE}' == 'Einstellungen'  Element Should Be Visible  class:elgg-form-usersettings-save

Check Termine Agenda
  [Documentation]  Special keyword for checking wether we're on the Agenda page
  ${elgg-heading-main} =  Get Text  css:h2.elgg-heading-main
  Should Start With  ${elgg-heading-main}  Alle Events (