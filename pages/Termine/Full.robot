** Settings **

Documentation  The site calendar in full view
Resource  ../Constants.robot
Library  SeleniumLibrary
Library  DateTime
Library  TermineUtils

** Keywords **

Check Features
  [Documentation]  Check the full view features
  Click Element  css:a[data-menu-item-name=format_full]
  I Am On  Termine-Full
  Take Current Screenshot  termine-full
  Full.Check Calendar Entries
  Check Full Layout
  Full.Check Filter
  Check Controls

Check Calendar Entries
  [Documentation]  Check the existing calendar entries
  Wait Until Element Is Visible  css:a.fc-event
  ${calendarEntries} =  Get Element Count  css:a.fc-event
  Should Be True  ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}

Check Full Layout
  [Documentation]  Check the full view layout
  Element Should Be Visible  css: span.fc-button-prev
  Element Should Be Visible  css: span.fc-button-next
  Element Should Be Visible  css: span.fc-button-today
  Element Should Be Visible  css: span.fc-button-month
  Element Should Be Visible  css: span.fc-button-agendaWeek
  Element Should Be Visible  css: span.fc-button-agendaDay

Check Filter
  [Documentation]  Check using a filter
  Log  Skipped because of existing bug to switch  level=WARN

Check Controls
  [Documentation]  Check using the date selector
  # Month
  ${titleDate} =  Current Month
  Element Text Should Be  css:span.fc-header-title h2  ${titleDate}

  Click Element  css:span.fc-button-prev
  ${titleDateLastMonth} =  Last Month
  Element Text Should Be  css:span.fc-header-title h2  ${titleDateLastMonth}
  
  Click Element  css:span.fc-button-next
  Element Text Should Be  css:span.fc-header-title h2  ${titleDate}

  # Week
  Click Element  css:span.fc-button-agendaWeek
  Click Element  css:span.fc-button-today
  ${titleDateWeekSpan} =  Week Span
  Element Text Should Be  css:span.fc-header-title h2  ${titleDateWeekSpan}

  Click Element  css:span.fc-button-prev
  ${titleDateLastWeekSpan} =  Week Span  -1
  Element Text Should Be  css:span.fc-header-title h2  ${titleDateLastWeekSpan}

  Click Element  css:span.fc-button-next
  Element Text Should Be  css:span.fc-header-title h2  ${titleDateWeekSpan}

  # Day
  Click Element  css:span.fc-button-agendaDay
  Click Element  css:span.fc-button-today

  ${titleDateDay} =  Day Format
  Element Text Should Be  css:span.fc-header-title h2  ${titleDateDay}

  Click Element  css:span.fc-button-prev

  ${titleDatePrevDay} =  Day Format  -1
  Element Text Should Be  css:span.fc-header-title h2  ${titleDatePrevDay}

  Click Element  css:span.fc-button-next
  Element Text Should Be  css:span.fc-header-title h2  ${titleDateDay}