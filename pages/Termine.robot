*** Settings ***

Documentation  Calendar page features
Library  SeleniumLibrary
Library  String
Library  OperatingSystem
Resource  PageIdentification.robot
Resource  HomePage.robot
Resource  BasicNavigation.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}
  Go To Menu  Termine
  I Am On  Termine
  Take Current Screenshot  termine

Check Ical Export Feature
  [Documentation]  Check the workflow for exporting events via iCal
  Click Element  css:li[data-menu-item=ical_export]
  I Am On  Termine-ICal-Export
  Take Current Screenshot  termine-ical-export
  Select From List By Value  name:filter  all
  Clear Element Text  name:start_date
  Press Keys  name:start_date  2018-01-01
  Clear Element Text  name:end_date
  Press Keys  name:end_date  2018-12-31
  Submit Form  class:elgg-form-event-calendar-export
  Wait Until Created  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  Sleep  10 seconds  reason=Wait for the file to be downloaded
  File Should Not Be Empty  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  ${export} =  Get File  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  Should Contain  ${export}  Abschlussfahrt
  Remove File  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  Go To Menu  Termine
  I Am On  Termine

Check Basic Calendar Features
  [Documentation]  Check the basic calendar workflow
  Create New Event
  Check Created Event
  Edit Event
  Check Edited Event
  Delete Event

Check Edit Form
  [Documentation]  Check the edit form for validity
  Element Should Be Visible  name:title
  Element Should Be Visible  name:venue
  Element Should Be Visible  name:tags
  Element Should Be Visible  name:schedule_type
  Element Should Be Visible  name:start_date
  Element Should Be Visible  name:start_time_hour
  Element Should Be Visible  name:start_time_minute
  Element Should Be Visible  name:end_date
  Element Should Be Visible  name:end_time_hour
  Element Should Be Visible  name:end_time_minute
  Element Should Be Visible  name:region
  Element Should Not Be Visible  name:long_description
  Element Should Be Visible  css:li[data-menu-item=embed]
  Take Current Screenshot  termine-edit

Create New Event
  [Documentation]  Check the workflow for creating a new event
  Click Element  css:li[data-menu-item=add]
  Check Edit Form
  Press Keys  name:title  Testevent
  Press Keys  name:venue  Bühne
  Press Keys  name:tags  test
  Select Radio Button  schedule_type  fixed
  Clear Element Text  name:start_date
  Press Keys  name:start_date  2018-01-01
  Select From List By Value  name:start_time_hour  10
  Select From List By Value  name:start_time_minute  0
  Clear Element Text  name:end_date
  Press Keys  name:end_date  2018-01-01
  Select From List By Value  name:end_time_hour  10
  Select From List By Value  name:end_time_minute  30
  Select From List By Value  name:region  Workshop

  # Use Javascript to work around tinymce editor
  Execute Javascript  $('textarea[name=long_description]').text('Just a test')

  Click Element  name:submit

Select Test Event
  [Documentation]  Go to an event we're testing with
  [Arguments]  ${EVENTNAME}  ${DATE}
  Go To  %{MEMBERS_TEST_BASEURL}/event_calendar/list/${DATE}/day/all
  ${eventCount} =  Get Element Count  jquery:td.event_calendar_paged_title a:contains(${EVENTNAME})
  Should Be Equal As Numbers  ${eventCount}  1
  Click Element  jquery:td.event_calendar_paged_title a:contains(${EVENTNAME})

Check Created Event
  [Documentation]  Check the created event for validity
  Select Test Event  Testevent  2018-1-1

  Take Current Screenshot  termine-event-created
  Element Should Contain  css:h3.title a span.elgg-anchor-label  Testevent
  
  ${timeOfEvent} =  Get Element Count  jquery:div.mts:contains(Wann: 10:00 - 10:30, 1 Jan 2018)
  Should Be Equal As Integers  ${timeOfEvent}  1  

  ${locationOfEvent} =  Get Element Count  jquery:div.mts:contains(Ort: Bühne)
  Should Be Equal As Integers  ${locationOfEvent}  1

  ${typeOfEvent} =  Get Element Count  jquery:div.mts:contains(Art: Workshop)
  Should Be Equal As Integers  ${typeOfEvent}  1
  
  Element Should Contain  css:div.mtm p  Just a test

Edit Event
  [Documentation]  Test the workflow for editing an event
  Select Test Event  Testevent  2018-1-1

  Click Element  css:a.elgg-object-menu-toggle
  Wait Until Element Is Visible  css:li[data-menu-item=edit]
  Click Element  css:li[data-menu-item=edit]

  Check Edit Form

  Press Keys  name:title  2
  Press Keys  name:venue  2
  Press Keys  name:tags  2
  Select Radio Button  schedule_type  fixed
  Clear Element Text  name:start_date 
  Press Keys  name:start_date  2018-01-02
  Select From List By Value  name:start_time_hour  11
  Select From List By Value  name:start_time_minute  15
  Clear Element Text  name:end_date  
  Press Keys  name:end_date  2018-01-02
  Select From List By Value  name:end_time_hour  12
  Select From List By Value  name:end_time_minute  45
  Select From List By Value  name:region  Arbeitseinsatz

  # Use Javascript to work around tinymce editor
  Execute Javascript  $('textarea[name=long_description]').text('Just a test2')

  Click Element  name:submit

Check Edited Event
  [Documentation]  Check the edited event for validity
  Select Test Event  Testevent2  2018-1-2
  Take Current Screenshot  termine-event-edited

  Element Should Contain  css:h3.title a span.elgg-anchor-label  Testevent2
  
  ${timeOfEvent} =  Get Element Count  jquery:div.mts:contains(Wann: 11:15 - 12:45, 2 Jan 2018)
  Should Be Equal As Integers  ${timeOfEvent}  1  

  ${locationOfEvent} =  Get Element Count  jquery:div.mts:contains(Ort: Bühne2)
  Should Be Equal As Integers  ${locationOfEvent}  1

  ${typeOfEvent} =  Get Element Count  jquery:div.mts:contains(Art: Arbeitseinsatz)
  Should Be Equal As Integers  ${typeOfEvent}  1

  Element Should Contain  css:div.mtm p  Just a test2

Delete Event
  [Documentation]  Check deleting an event
  [Arguments]  ${EVENTNAME}=Testevent2  ${DATE}=2018-1-2
  Select Test Event  ${EVENTNAME}  ${DATE}

  Click Element  css:a.elgg-object-menu-toggle
  Wait Until Element Is Visible  css:li[data-menu-item=delete]
  Click Element  css:li[data-menu-item=delete]
  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  Go To  %{MEMBERS_TEST_BASEURL}/event_calendar/list/${DATE}/day/all
  ${eventCount} =  Get Element Count  jquery:td.event_calendar_paged_title a:contains(${EVENTNAME})
  Should Be Equal As Integers  ${eventCount}  0

Check Single Ical Export Feature
  [Documentation]  Check the feature for exporting a single event via iCal
  Create New Event
  Select Test Event  Testevent  2018-1-1
  Export Event As Ical
  Remove File  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  Delete Event  Testevent  2018-1-1

Export Event As Ical
  [Documentation]  Export a single event as an iCal file
  Click Element  css:a.elgg-object-menu-toggle
  Wait Until Element Is Visible  css:div.elgg-object-menu-popup li[data-menu-item=ical_export]
  Click Element  css:div.elgg-object-menu-popup li[data-menu-item=ical_export]
  Wait Until Created  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  Sleep  10 seconds  reason=Wait for the file to be downloaded
  File Should Not Be Empty  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  ${export} =  Get File  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics
  Should Contain  ${export}  Testevent

Check Ical Import Feature
  [Documentation]  Check the feature for importing iCal files
  Create New Event
  Select Test Event  Testevent  2018-1-1
  Export Event As Ical
  Delete Event  Testevent  2018-1-1
  
  Click Element  css:li[data-menu-item=ical_import]

  # Use Join Path to get the absolute path name, which only works with Input Text into a file selection
  ${uploadPath} =  Join Path  %{MEMBERS_TEST_DOWNLOAD_DIR}  Calendar.ics

  Input Text  name:ical_file  ${uploadPath}
  Submit Form  class:elgg-form-event-calendar-import
  Remove File  %{MEMBERS_TEST_DOWNLOAD_DIR}/Calendar.ics

  Select Test Event  Testevent  2018-1-1
  Delete Event  Testevent  2018-1-1
