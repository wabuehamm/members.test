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
  Click Element  jquery:span:contains(Gruppenumfragen)

Check Polls
  [Documentation]  Check the existing polls
  ${posts} =  Get Element Count  class:elgg-item
  Should Be True  ${posts} >= ${EXPECTED_POLL_POSTS}

Create New Poll
  [Documentation]  Create a new poll
  Click Element  css:li[data-menu-item=add]
  Check Edit Form
  Input Text  name:title  Testpoll

  # Use Javascript to work around ckeditor
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].insertText('This is a Testpoll')

  Input Text  name:tags  test

  Input Text  name:answers[0][label]  First Choice
  Input Text  name:answers[1][label]  Second Choice

  ${TODAY} =  Get Current Date  result_format=%Y-%m-%d
  Input Text  class:elgg-input-date  ${TODAY}

  Click Element  css:.elgg-layout-content .elgg-button-submit
  Check Created Poll

Check Edit Form
  [Documentation]  Check the edit form for validity
  Element Should Be Visible  name:title
  
  Wait Until Element Is Visible  tag:iframe
  Element Should Be Visible  tag:iframe
  Page Should Contain Element  name:description

  Element Should Be Visible  name:tags
  Page Should Contain Element  name:close_date
  Element Should Be Visible  css:.elgg-layout-content .elgg-button-submit
  Take Current Screenshot  umfragen-edit

Select Test Poll
  [Documentation]  Select a poll we're testing with
  [Arguments]  ${TITLE}
  Go To Umfragen
  Click Element  jquery:.elgg-listing-summary-title:contains(${TITLE}) a

Check Created Poll
  [Documentation]  Check the created poll for validity
  Select Test Poll  Testpoll
  Take Current Screenshot  umfragen-poll-created

  Element Text Should Be  class:elgg-heading-main  Testpoll
  
  Element Text Should Be  css:.elgg-output p  This is a Testpoll

  Element Should Be Visible  jquery:label:contains("First Choice")
  Element Should Be Visible  jquery:label:contains("Second Choice")
  Element Should Be Visible  css:.elgg-layout-content .elgg-button-submit

Edit Poll
  [Documentation]  Check the workflow for editing a poll
  Select Test Poll  Testpoll

  Click Element  css:li[data-menu-item=entity-menu-toggle]
  Wait Until Element Is Visible  css:li[data-menu-item=edit]
  Click Element  css:li[data-menu-item=edit]
  
  Input Text  name:title  Testpoll2

  Wait Until Element Is Visible  tag:iframe

  Select Frame  tag:iframe
  Wait Until Element Contains  css:body.cke_editable p  This is a Testpoll
  Unselect Frame  

  # Use Javascript to work around ckeditor
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].setData('')
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].insertText('This is a Testpoll2')

  Input Text  name:tags  test2

  ${TODAY} =  Get Current Date
  ${TOMORROW} =  Add Time To Date  ${TODAY}  1 day  %Y-%m-%d
  
  Clear Element Text  class:elgg-input-date
  Input Text  class:elgg-input-date  ${TOMORROW}

  Input Text  name:answers[0][label]  First Choice2
  Input Text  name:answers[1][label]  Second Choice2
  Input Text  name:answers[2][label]  Third Choice

  Click Element  css:.elgg-layout-content .elgg-button-submit
  
  Check Edited Poll

Check Edited Poll
  [Documentation]  Check the edited poll for validity
  Select Test Poll  Testpoll2
  Take Current Screenshot  umfragen-poll-edited

  Element Text Should Be  class:elgg-heading-main  Testpoll2
  
  Element Text Should Be  css:.elgg-output p  This is a Testpoll2

  Element Should Be Visible  jquery:label:contains("First Choice2")
  Element Should Be Visible  jquery:label:contains("Second Choice2")
  Element Should Be Visible  jquery:label:contains("Third Choice")
  Element Should Be Visible  css:.elgg-layout-content .elgg-button-submit

Vote
  [Documentation]  Check the workflow for voting for a poll
  Select Test Poll  Testpoll2
  Click Element  jquery:label:contains("First Choice2")
  Click Element  css:.elgg-layout-content .elgg-button-submit

  Select Test Poll  Testpoll2
  Element Should Be Visible  class:poll-result-chart
  Element Should Be Visible  css:li[data-menu-item=results]
  Element Should Be Visible  css:li[data-menu-item=vote_form]

  Click Element  css:li[data-menu-item=vote_form]
  Element Should Be Visible  jquery:label:contains("First Choice2")
  Element Should Be Visible  jquery:label:contains("Second Choice2")
  Element Should Be Visible  jquery:label:contains("Third Choice")

  ${selectedValue} =  Get Value  jquery:input[name=vote]:eq(0)
  Radio Button Should Be Set To  vote  ${selectedValue}

Delete Poll
  [Documentation]  Check deleting a poll
  Select Test Poll  Testpoll2

  Click Element  css:li[data-menu-item=entity-menu-toggle]
  Wait Until Element Is Visible  css:li[data-menu-item=delete]
  Click Element  css:li[data-menu-item=delete]

  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  Go To Umfragen
  Page Should Not Contain Element  jquery:h3.title a:contains(Testpoll2)
