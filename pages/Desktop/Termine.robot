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
${EXPECTED_CALENDAR_ENTRIES}    10

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
    Should Be True          ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}

Check Agenda Features
    Click Element               css:a[data-menu-item-name=format_agenda]
    I Am On                     Termine-Agenda
    Take Current Screenshot     termine-agenda
    Check Agenda Calendar Entries

Check Agenda Calendar Entries
    ${calendarEntries} =    Get Element Count  css:div.event_calendar_agenda table
    Should Be True          ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}

Check Full Features
    Click Element               css:a[data-menu-item-name=format_full]
    I Am On                     Termine-Full
    Take Current Screenshot     termine-full
    Check Full Calendar Entries

Check Full Calendar Entries
    Wait Until Element Is Visible   css:a.fc-event
    ${calendarEntries} =            Get Element Count                                   css:a.fc-event
    Should Be True                  ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}

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
    Create New Event
    Check Created Event
    Edit Event
    Check Edited Event
    Delete Event

Check Edit Form
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

Create New Event
    Click Element                   css:a[data-menu-item-name=add]
    Check Edit Form
    Press Keys                      name:title                          Testevent
    Press Keys                      name:venue                          Bühne
    Press Keys                      name:tags                           test
    Select Radio Button             schedule_type                       fixed
    Clear Element Text              name:start_date
    Press Keys                      name:start_date                     2018-01-01
    Select From List By Value       name:start_time_hour                10
    Select From List By Value       name:start_time_minute              0
    Clear Element Text              name:end_date
    Press Keys                      name:end_date                       2018-01-01
    Select From List By Value       name:end_time_hour                  10
    Select From List By Value       name:end_time_minute                30
    Select From List By Value       name:region                         Workshop

    # Use Javascript to work around tinymce editor
    Execute Javascript              $('textarea[name=long_description]').text('Just a test')

    Submit Form                     name:event_calendar_edit

Select Test Event
    [Arguments]                     ${EVENTNAME}                                                    ${DATE}
    Go To                           ${BASE_URL}/event_calendar/list/${DATE}/day/all
    ${eventCount} =                 Get Element Count                                               jquery:td.event_calendar_paged_title a:contains(${EVENTNAME})
    Should Be Equal As Numbers      ${eventCount}                                                   1
    Click Element                   jquery:td.event_calendar_paged_title a:contains(${EVENTNAME})
    

Check Created Event
    Select Test Event               Testevent                                                   2018-1-1

    Element Should Contain          css:h3.title a span.elgg-anchor-label                       Testevent
    
    ${timeOfEvent} =                Get Element Count                                           jquery:div.mts:contains(Wann: 10:00 - 10:30, 1 Jan 2018)
    Should Be Equal As Integers     ${timeOfEvent}                                              1  

    ${locationOfEvent} =            Get Element Count                                           jquery:div.mts:contains(Ort: Bühne)
    Should Be Equal As Integers     ${locationOfEvent}                                          1

    ${typeOfEvent} =                Get Element Count                                           jquery:div.mts:contains(Art: Workshop)
    Should Be Equal As Integers     ${typeOfEvent}                                              1
    
    Element Should Contain          css:div.mtm p                                               Just a test

Edit Event
    Select Test Event               Testevent                               2018-1-1

    Click Element                   css:a.elgg-object-menu-toggle
    Wait Until Element Is Visible   css:a[data-menu-item-name=edit]
    Click Element                   css:a[data-menu-item-name=edit]

    Check Edit Form

    Press Keys                      name:title                              2
    Press Keys                      name:venue                              2
    Press Keys                      name:tags                               2
    Select Radio Button             schedule_type                           fixed
    Clear Element Text              name:start_date 
    Press Keys                      name:start_date                         2018-01-02
    Select From List By Value       name:start_time_hour                    11
    Select From List By Value       name:start_time_minute                  15
    Clear Element Text              name:end_date   
    Press Keys                      name:end_date                           2018-01-02
    Select From List By Value       name:end_time_hour                      12
    Select From List By Value       name:end_time_minute                    45
    Select From List By Value       name:region                             Arbeitseinsatz

    # Use Javascript to work around tinymce editor
    Execute Javascript              $('textarea[name=long_description]').text('Just a test2')

    Submit Form                     name:event_calendar_edit

Check Edited Event
    Select Test Event               Testevent2                                                  2018-1-2

    Element Should Contain          css:h3.title a span.elgg-anchor-label                       Testevent2
    
    ${timeOfEvent} =                Get Element Count                                           jquery:div.mts:contains(Wann: 11:15 - 12:45, 2 Jan 2018)
    Should Be Equal As Integers     ${timeOfEvent}                                              1  

    ${locationOfEvent} =            Get Element Count                                           jquery:div.mts:contains(Ort: Bühne2)
    Should Be Equal As Integers     ${locationOfEvent}                                          1

    ${typeOfEvent} =                Get Element Count                                           jquery:div.mts:contains(Art: Arbeitseinsatz)
    Should Be Equal As Integers     ${typeOfEvent}                                              1

    Element Should Contain          css:div.mtm p                                               Just a test2

Delete Event
    Select Test Event               Testevent2                                                  2018-1-2

    Click Element                   css:a.elgg-object-menu-toggle
    Wait Until Element Is Visible   css:a[data-menu-item-name=delete]
    Click Element                   css:a[data-menu-item-name=delete]
    Alert Should Be Present         Bist Du sicher, dass Du diesen Eintrag löschen willst?

    Go To                           ${BASE_URL}/event_calendar/list/2018-1-2/day/all
    ${eventCount} =                 Get Element Count                                               jquery:td.event_calendar_paged_title a:contains(Testevent2)
    Should Be Equal As Integers     ${eventCount}                                                   0