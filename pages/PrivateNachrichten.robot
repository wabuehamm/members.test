*** Settings ***

Documentation  Direct message page features
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
  Go To Private Nachrichten
  I Am On  Private-Nachrichten
  Take Current Screenshot  private-nachrichten

Go To Private Nachrichten
  [Documentation]  Go to the direct message feature
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Click Element  css:${parentBar} a[data-menu-item-name="messages"]

Send Direct Message
  [Documentation]  Check the workflow for sending a direct message
  Click Element  css:a[data-menu-item-name="add"]
  Check Edit Form
  Input Text  css:div[data-name="recipients"] input  %{MEMBERS_TEST_SECOND_USER_DISPLAYNAME} 
  Wait Until Element Is Visible  css:ul.ui-autocomplete > li  timeout=60s

  Press Keys  css:div[data-name="recipients"] input  DOWN  TAB

  Input Text  name:subject  Testdm
  
  # Use Javascript to work around tinymce editor
  Execute Javascript  $('textarea[name=body]').text('This is a test direct message')

  Submit Form  class:elgg-form-messages-send

  Homepage.Logout
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To Private Nachrichten

  Element Should Be Visible  jquery:.messages-container .elgg-item h3.title:contains(Testdm)

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Receive Reply
  [Documentation]  Check the workflow for sending and receiving a reply
  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To Private Nachrichten

  Click Element  jquery:.messages-container .elgg-item h3.title:contains(Testdm) a

  # Use Javascript to work around tinymce editor
  Execute Javascript  $('textarea[name=body]').text('This is a test reply')

  Submit Form  id:messages-reply-form

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

  Go To Private Nachrichten

  Element Should Be Visible  jquery:.elgg-listing-summary-inline-content:contains("This is a test reply")

Delete Direct Message
  [Documentation]  Delete a direct message
  Go To Private Nachrichten
  Click Element  jquery:h3.title:contains("RE: Testdm") a
  Click Element  css:a[data-menu-item-name="delete"]
  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To Private Nachrichten
  Click Element  jquery:h3.title:contains("Testdm") a
  Click Element  css:a[data-menu-item-name="delete"]
  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Check Edit Form
  [Documentation]  Check the edit form for validity
  Element Should Be Visible  css:div[data-name="recipients"]
  Element Should Be Visible  name:match_on
  Element Should Be Visible  name:subject
  Page Should Contain Element  name:body
  Element Should Be Visible  class:elgg-button-submit
  Take Current Screenshot  private-nachrichten-edit