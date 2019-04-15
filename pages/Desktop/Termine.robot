*** Settings ***

Documentation   Calendar page features
Library         SeleniumLibrary
Library         String
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot

*** Keywords ***

Go to Page
    [Arguments]         ${URL}      ${BROWSER}      ${USERNAME}     ${PASSWORD}
    HomePage.Go to Page  ${URL}  ${BROWSER}
    HomePage.Login  ${USERNAME}  ${PASSWORD}
    Go To Menu  Termine
    I Am On  Termine

Check Paged Features
    Click Element               css:a[data-menu-item-name=format_paged]
    I Am On                     Termine-Paged
    Take Current Screenshot     termine-paged
    Check Paged Calendar Entries

Check Paged Calendar Entries
    ${calendarEntries} =    Get Element Count  css:table.event_calendar_paged_table tr
    Should Be True          ${calendarEntries} > 10

Check Agenda Features
    Click Element               css:a[data-menu-item-name=format_agenda]
    I Am On                     Termine-Agenda
    Take Current Screenshot     termine-agenda
    Check Agenda Calendar Entries

Check Agenda Calendar Entries
    ${calendarEntries} =    Get Element Count  css:div.event_calendar_agenda table
    Should Be True          ${calendarEntries} > 10

Check Full Features
    Click Element               css:a[data-menu-item-name=format_full]
    I Am On                     Termine-Full
    Take Current Screenshot     termine-full
    Check Full Calendar Entries

Check Full Calendar Entries
    Log                     Check full calendar entries skipped.    level=WARN
