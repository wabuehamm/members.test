** Settings **

Documentation                   The site calendar in paged view
Library                         SeleniumLibrary

** Keywords **

Check Features
    Click Element               css:a[data-menu-item-name=format_paged]
    I Am On                     Termine-Paged
    Take Current Screenshot     termine-paged
    Check Calendar Entries

Check Calendar Entries
    ${calendarEntries} =    Get Element Count  css:table.event_calendar_paged_table tr
    Should Be True          ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}