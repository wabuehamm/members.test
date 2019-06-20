*** Settings ***

Documentation  Poll page features
Library  SeleniumLibrary
Library  String
Library  OperatingSystem
Library  DateTime
Resource  PageIdentification.robot
Resource  HomePage.robot
Resource  BasicNavigation.robot
Resource  Constants.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}
  Go To Umfragen
  I Am On  Umfragen
  Take Current Screenshot  umfragen

Go To Umfragen
  [Documentation]  Go to the poll features
  Go To Menu  Forum
  Click Element  jquery:span:contains(Gruppen-Umfragen)

Check Polls
  [Documentation]  Check the existing polls
  ${posts} =  Get Element Count  class:elgg-item
  Should Be True  ${posts} >= ${EXPECTED_POLL_POSTS}

Create New Poll
  [Documentation]  Create a new poll
  Click Element  css:a[data-menu-item-name=add]
  Check Edit Form
  Input Text  name:question  Testpoll

  # Use Javascript to work around tinymce editor
  Execute Javascript  $('textarea[name=description]').text('This is a Testpoll')

  Input Text  name:tags  test

  ${TODAY} =  Get Current Date  result_format=%Y-%m-%d
  Input Text  id:close_date  ${TODAY}

  Click Element  id:add-choice
  Input Text  name:choice_text_0  First Choice
  Click Element  id:add-choice
  Input Text  name:choice_text_1  Second Choice
  
  Click Element  name:submit
  Check Created Poll

Check Edit Form
  [Documentation]  Check the edit form for validity
  Element Should Be Visible  name:question
  Wait Until Element Is Visible  tag:iframe
  Page Should Contain Element  name:description
  Element Should Be Visible  name:tags
  Element Should Be Visible  id:close_date
  Element Should Be Visible  id:add-choice
  Element Should Be Visible  css:input.elgg-button-submit
  Take Current Screenshot  umfragen-edit

Select Test Poll
  [Documentation]  Select a poll we're testing with
  [Arguments]  ${TITLE}
  Go To Umfragen
  Click Element  jquery:h3.title a:contains(${TITLE})

Check Created Poll
  [Documentation]  Check the created poll for validity
  Select Test Poll  Testpoll
  Take Current Screenshot  umfragen-poll-created

  Element Text Should Be  css:h3.title a span  Testpoll
  
  Element Text Should Be  css:.elgg-inner > p  This is a Testpoll

  Element Should Be Visible  css:input[value="First Choice"]
  Element Should Be Visible  css:input[value="Second Choice"]
  Element Should Be Visible  class:poll-vote-button
  Element Should Be Visible  css:a.poll-show-link

Edit Poll
  [Documentation]  Check the workflow for editing a poll
  Select Test Poll  Testpoll

  Click Element  css:a.elgg-object-menu-toggle
  Wait Until Element Is Visible  css:a[data-menu-item-name=edit]

  Click Element  css:a[data-menu-item-name=edit]
  
  Input Text  name:question  Testpoll2

  # Use Javascript to work around tinymce editor
  Execute Javascript  $('textarea[name=description]').text('This is a Testpoll2')

  Input Text  name:tags  test2

  ${TODAY} =  Get Current Date
  ${TOMORROW} =  Add Time To Date  ${TODAY}  1 day  %Y-%m-%d
  
  Clear Element Text  id:close_date
  Input Text  id:close_date  ${TOMORROW}

  Input Text  name:choice_text_0  First Choice2
  Input Text  name:choice_text_1  Second Choice2
  Click Element  id:add-choice
  Input Text  name:choice_text_2  Third Choice
  Click Element  name:submit
  
  Check Edited Poll

Check Edited Poll
  [Documentation]  Check the edited poll for validity
  Select Test Poll  Testpoll2

  Take Current Screenshot  umfragen-poll-edited

  Element Text Should Be  css:h3.title a span  Testpoll2

  Element Text Should Be  css:.elgg-inner > p  This is a Testpoll2


  Element Should Be Visible  css:input[value="First Choice2"]
  Element Should Be Visible  css:input[value="Second Choice2"]
  Element Should Be Visible  css:input[value="Third Choice"]
  Element Should Be Visible  class:poll-vote-button
  Element Should Be Visible  css:a.poll-show-link

Vote
  [Documentation]  Check the workflow for voting for a poll
  Select Test Poll  Testpoll2
  Click Element  css:input[value="First Choice2"]
  Submit Form  class:elgg-form-poll-vote

  Select Test Poll  Testpoll2
  Element Should Be Visible  jquery:.poll_post p:contains(Deine Stimme wurde erfasst)
  Element Should Be Visible  jquery:.poll_post label:contains("First Choice2 (1)")
  Element Should Be Visible  jquery:.poll_post p:contains("Gesamtzahl der abgegebenen Stimmen: 1")

Delete Poll
  [Documentation]  Check deleting a poll
  Select Test Poll  Testpoll2

  Click Element  css:a.elgg-object-menu-toggle
  Wait Until Element Is Visible  css:a[data-menu-item-name=delete]

  Click Element  css:a[data-menu-item-name=delete]
  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  Go To Umfragen
  Page Should Not Contain Element  jquery:h3.title a:contains(Testpoll2)
