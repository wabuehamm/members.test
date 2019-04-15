*** Settings ***

Documentation   Calendar page features
Library         SeleniumLibrary
Library         String
Library         OperatingSystem
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot

*** Variables ***

${BASE_URL}
${DOWNLOAD_DIR}

*** Keywords ***

Go to Page
    [Arguments]         ${URL}      ${BROWSER}      ${USERNAME}     ${PASSWORD}     ${P_DOWNLOAD_DIR}
    Set Suite Variable          ${BASE_URL}         ${URL}
    Set Suite Variable          ${DOWNLOAD_DIR}     ${P_DOWNLOAD_DIR}
    HomePage.Go to Page         ${URL}              ${BROWSER}
    HomePage.Login              ${USERNAME}         ${PASSWORD}
    Go To Menu                  Termine
    I Am On                     Termine
    Take Current Screenshot     termine

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
    Log                         TODO: Check full calendar entries skipped.    level=WARN

Check Ical Export Feature
    Click Element               css:a[data-menu-item-name=ical_export]
    I Am On                     Termine-ICal-Export
    Take Current Screenshot     termine-ical-export
    Select From List By Value   name:filter                             all
    Clear Element Text          name:start_date
    Press Keys                  name:start_date                         2018-01-01
    Clear Element Text          name:end_date
    Press Keys                  name:end_date                           2018-12-31
    Submit Form                 class:elgg-form-event-calendar-export
    Wait Until Created          ${DOWNLOAD_DIR}/Calendar.ics
    Sleep                       10 seconds                              reason=Wait for the file to be downloaded
    File Should Not Be Empty    ${DOWNLOAD_DIR}/Calendar.ics
    ${export} =                 Get File                                ${DOWNLOAD_DIR}/Calendar.ics
    Should Contain              ${export}                               Abschlussfahrt
    Remove File                 ${DOWNLOAD_DIR}/Calendar.ics
    Go To Menu  Termine
    I Am On  Termine

Check Basic Calendar Features
    Click Element                   css:a[data-menu-item-name=add]
    Element Should Be Visible       name:title
    Element Should Be Visible       name:venue
    Element Should Be Visible       name:tags
    Element Should Be Visible       name:schedule_type
    Element Should Be Visible       name:start_date
    Element Should Be Visible       name:start_time_hour
    Element Should Be Visible       name:start_time_minute
    Element Should Be Visible       name:end_date
    Element Should Be Visible       name:end_time_hour
    Element Should Be Visible       name:end_time_minute
    Element Should Be Visible       name:region
    Element Should Not Be Visible   name:long_description
    Element Should Be Visible       css:a[data-menu-item-name=embed]

    Press Keys                      name:title                          Testevent
    Press Keys                      name:venue                          Bühne
    Press Keys                      name:tags                           test
    Select Radio Button             schedule_type                       fixed
    Press Keys                      name:start_date                     2018-01-01
    Select From List By Value       name:start_time_hour                10
    Select From List By Value       name:start_time_minute              0
    Press Keys                      name:end_date                       2018-01-01
    Select From List By Value       name:end_time_hour                  10
    Select From List By Value       name:end_time_minute                30
    Select From List By Value       name:region                         Workshop
    Press Keys                      name:long_description               Just a test
    Submit Form                     name:event_calendar_edit

    Go To                           ${BASE_URL}/event_calendar/list/2018-1-1/day/all
    Get Element Count               jquery:td.event_calendar_paged_title a:contains(Testevent)
    Click Element                   jquery:td.event_calendar_paged_title a:contains(Testevent)
    Element Should Contain          h3.title a span.elgg-anchor-label                           Testevent
    Element Should Contain          div.mts                                                     <label>Wann: </label>10:00 - 10:30, 1 Jan 2018
    Element Should Contain          div.mts                                                     <label>Ort: </label>Bühne
    Element Should Contain          div.mts                                                     <label>Art: </label>Workshop
    Element Should Contain          div.mtm p                                                   Just a test
