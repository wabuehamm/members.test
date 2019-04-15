*** Settings ***

Documentation   Identification on which page we are
Library         SeleniumLibrary

*** Keywords ***

I Am On
    [Arguments]     ${PAGE}
    Run Keyword If  '${PAGE}' == 'Homepage'         Element Should Be Visible   css:.elgg-page-body input[name="username"]
    Run Keyword If  '${PAGE}' == 'Startpage'        Element Should Be Visible   css:a[data-menu-item-name="profile"]
    Run Keyword If  '${PAGE}' == 'Spielerliste'     Element Text Should Be      css:h2.title    Alle Mitglieder   
    Run Keyword If  '${PAGE}' == 'Termine'          Element Text Should Be      css:h2.title    Alle bevorstehenden Events
    Run Keyword If  '${PAGE}' == 'Termine-Paged'    Element Text Should Be      css:h2.title    Alle bevorstehenden Events
    Run Keyword If  '${PAGE}' == 'Termine-Agenda'   Check Termine Agenda
    Run Keyword If  '${PAGE}' == 'Termine-Full'     Element Text Should Be      css:h2.title    Alle Events

Check Termine Agenda
    ${title} =          Get Text    css:h2.title
    Should Start With   ${title}    Alle Events (