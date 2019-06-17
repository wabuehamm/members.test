** Settings **

Documentation  The site calendar in agenda view
Resource  ../../Constants.robot
Library  SeleniumLibrary

** Keywords **

Check Features
  [Documentation]  Check features of the agenda view
  Click Element  css:a[data-menu-item-name=format_agenda]
  I Am On  Termine-Agenda
  Take Current Screenshot  termine-agenda
  Agenda.Check Calendar Entries
  Agenda.Check Pagination
  Agenda.Switch Display Type
  Agenda.Check Filter

Check Calendar Entries
  [Documentation]  Check the existing calendar entries
  ${calendarEntries} =  Get Element Count  css:div.event_calendar_agenda table
  Should Be True  ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}

Check Pagination
  [Documentation]  Check the pagination features
  Select From List By Value  class:ui-datepicker-month  0
  Select From List By Value  class:ui-datepicker-year  2019
  ${pages} =  Get Element Count  css:ul.elgg-pagination li
  Should Be True  ${pages} > 2
  Agenda.Go To Next Page

Go To Next Page
  [Documentation]  Check switching to the next page
  ${firstEventStartDate} =  Get Text  jquery:div.event_calendar_agenda_date_section div.event_calendar_agenda_date:eq(0)
  Click Element  jquery: ul.elgg-pagination li:last a
  ${firstEventStartDateNextPage} =  Get Text  jquery:div.event_calendar_agenda_date_section div.event_calendar_agenda_date:eq(0)
  Should Be True  '${firstEventStartDate}' != '${firstEventStartDateNextPage}'

Switch Display Type
  [Documentation]  Check switching the display type
  Log  Skipped because of existing bug to switch  level=WARN

Check Filter
  [Documentation]  Check using the filter
  Log  Skipped because of existing bug to switch  level=WARN