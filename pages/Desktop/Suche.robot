*** Settings ***

Documentation   Search page features
Library         SeleniumLibrary
Resource        HomePage.robot

*** Keywords ***

Go to Page
    [Arguments]                 ${URL}                  ${BROWSER}      ${USERNAME}     ${PASSWORD}
    HomePage.Go to Page         ${URL}                  ${BROWSER}
    HomePage.Login              ${USERNAME}             ${PASSWORD}

Search For Events

    Input Text                  jquery:.elgg-page-topbar .elgg-menu-item-search input[name=q]   Rollenverteilung
    Submit Form                 css:.elgg-page-topbar .elgg-menu-item-search form

    Take Current Screenshot     suche-termin

    Click Element               css:a[data-menu-item-name="item:object:event_calendar"]
    ${events} =                 Get Element Count                                               css:.search-list li
    Should Be True              ${events} >= 1

Search For Forum Posts

    Input Text                  jquery:.elgg-page-topbar .elgg-menu-item-search input[name=q]   Rollenverteilung
    Submit Form                 css:.elgg-page-topbar .elgg-menu-item-search form

    Take Current Screenshot     suche-forum

    Click Element               css:a[data-menu-item-name="item:object:discussion"]
    ${events} =                 Get Element Count                                               css:.search-list li
    Should Be True              ${events} >= 1

Search For People

    Input Text                  jquery:.elgg-page-topbar .elgg-menu-item-search input[name=q]   Hesse
    Submit Form                 css:.elgg-page-topbar .elgg-menu-item-search form

    Take Current Screenshot     suche-mitglieder

    Click Element               css:a[data-menu-item-name="item:user"]
    ${events} =                 Get Element Count                                               css:.search-list li
    Should Be True              ${events} >= 1