** Settings **

Documentation                   The site calendar in paged view
Resource                        ../../Constants.robot
Library                         SeleniumLibrary

** Keywords **

Check Features
    Click Element               css:a[data-menu-item-name=format_paged]
    I Am On                     Termine-Paged
    Take Current Screenshot     termine-paged
    Paged.Check Calendar Entries
    Check Pagination

Check Calendar Entries
    ${calendarEntries} =    Get Element Count  css:table.event_calendar_paged_table tr
    Should Be True          ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}

Check Pagination
    ${pages} =              Get Element Count  css:ul.elgg-pagination li
    Should Be True          ${pages} > ${MINIMUM_CALENDAR_PAGES}
    Go To Next Page

Go To Next Page
    ${firstEventStartDate} =            Get Text                                jquery:table.event_calendar_paged_table tbody tr td.event_calendar_paged_date:eq(1)
    Click Element                       jquery: ul.elgg-pagination li:last a
    ${firstEventStartDateNextPage} =    Get Text                                jquery:table.event_calendar_paged_table tbody tr td.event_calendar_paged_date:eq(1)
    Should Be True                      '${firstEventStartDate}' != '${firstEventStartDateNextPage}'
