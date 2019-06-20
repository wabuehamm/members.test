** Settings **

Documentation  The site calendar in paged view
Resource  ../Constants.robot
Library  SeleniumLibrary

** Keywords **

Check Features
  [Documentation]  Check the paged view features
  Click Element  css:a[data-menu-item-name=format_paged]
  I Am On  Termine-Paged
  Take Current Screenshot  termine-paged
  Paged.Check Calendar Entries
  Paged.Check Pagination
  Add Event To Personal Calendar
  Paged.Check Filter

Check Calendar Entries
  [Documentation]  Check the existing calendar entries
  ${calendarEntries} =  Get Element Count  css:table.event_calendar_paged_table tr
  Should Be True  ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}

Check Pagination
  [Documentation]  Check the pagination features
  ${pages} =  Get Element Count  css:ul.elgg-pagination li
  Should Be True  ${pages} > 4
  Paged.Go To Next Page

Go To Next Page
  [Documentation]  Check going to the next page
  ${firstEventStartDate} =  Get Text  jquery:table.event_calendar_paged_table tbody tr td.event_calendar_paged_date:eq(1)
  Click Element  jquery: ul.elgg-pagination li:last a
  ${firstEventStartDateNextPage} =  Get Text  jquery:table.event_calendar_paged_table tbody tr td.event_calendar_paged_date:eq(1)
  Should Be True  '${firstEventStartDate}' != '${firstEventStartDateNextPage}'

Add Event To Personal Calendar
  [Documentation]  Check the workflow for adding an event to the personal calendar
  Click Element  jquery:.elgg-page-body div.nav-left a:eq(1)
  ${entries}  Get Element Count  css:table.event_calendar_paged_table tr
  Click Element  jquery:.elgg-page-body div.nav-left a:eq(0)
  Click Element  jquery:table.event_calendar_paged_table tr td input.event_calendar_paged_checkbox:eq(0)
  Wait Until Element Is Visible  jquery:li.elgg-state-success:contains(Das Event wurde zu Deinem persönlichen Kalender hinzugefügt.)
  Click Element  jquery:.elgg-page-body div.nav-left a:eq(1)
  ${entriesAfterAdd}  Get Element Count  css:table.event_calendar_paged_table tr
  Should Be True  ${entries} < ${entriesAfterAdd}
  Click Element  jquery:table.event_calendar_paged_table tr td input.event_calendar_paged_checkbox:eq(0)
  Wait Until Element Is Visible  jquery:li.elgg-state-success:contains(Das Event wurde aus Deinem persönlichen Kalender entfernt.)

Check Filter
  [Documentation]  Check using a filter
  ${entries}  Get Element Count  css:table.event_calendar_paged_table tr
  Select From List By Value  id:event-calendar-region  Arbeitseinsatz
  ${filteredEntries}  Get Element Count  css:table.event_calendar_paged_table tr
  Should Be True  ${entries} > ${filteredEntries}
