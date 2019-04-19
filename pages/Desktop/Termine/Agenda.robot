** Settings **

Documentation                   The site calendar in agenda view
Resource                        ../../Constants.robot
Library                         SeleniumLibrary

** Keywords **

Check Features
    Click Element               css:a[data-menu-item-name=format_agenda]
    I Am On                     Termine-Agenda
    Take Current Screenshot     termine-agenda
    Agenda.Check Calendar Entries

Check Calendar Entries
    ${calendarEntries} =    Get Element Count  css:div.event_calendar_agenda table
    Should Be True          ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}