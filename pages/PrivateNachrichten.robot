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
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  css:${parentBar} li[data-menu-item="messages"]
  Click Element  css:${parentBar} li[data-menu-item="messages"]

Send Direct Message
  [Documentation]  Check the workflow for sending a direct message
  Click Element  css:li[data-menu-item="add"]
  Check Edit Form
  Input Text  css:div[data-name="recipients"] input  %{MEMBERS_TEST_SECOND_USER_DISPLAYNAME} 
  Wait Until Element Is Visible  css:ul.ui-autocomplete > li  timeout=60s

  Press Keys  css:div[data-name="recipients"] input  DOWN  TAB

  Input Text  name:subject  Testdm

  Wait Until Element Is Visible  tag:iframe

  Select Frame  tag:iframe
  Wait Until Element Is Visible  css:body.cke_editable
  Unselect Frame
  
  # Use Javascript to work around ckeditor
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].insertText('This is a test direct message')

  Submit Form  class:elgg-form-messages-send

  Homepage.Logout
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To Private Nachrichten

  Element Should Be Visible  jquery:.messages-container .elgg-item h3.elgg-listing-summary-title:contains(Testdm)

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Receive Reply
  [Documentation]  Check the workflow for sending and receiving a reply
  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To Private Nachrichten

  Click Element  jquery:.messages-container .elgg-item h3.elgg-listing-summary-title:contains(Testdm) a
  Click Element  css:li[data-menu-item=reply]

  Wait Until Element Is Visible  tag:iframe

  Select Frame  tag:iframe
  Wait Until Element Is Visible  css:body.cke_editable
  Unselect Frame

  # Use Javascript to work around ckeditor
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].insertText('This is a test reply')

  Submit Form  id:messages-reply-form

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

  Go To Private Nachrichten

  Element Should Be Visible  jquery:.elgg-listing-summary-content:contains("This is a test reply")

Delete Direct Message
  [Documentation]  Delete a direct message
  Go To Private Nachrichten
  Click Element  jquery:.messages-container .elgg-item h3.elgg-listing-summary-title:contains("RE: Testdm") a

  Click Element  css:.elgg-listing-full-header li[data-menu-item=entity-menu-toggle]
  Wait Until Element Is Visible  css:#ui-id-1 li[data-menu-item=delete]
  Click Element  css:li[data-menu-item="delete"]
  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_SECOND_USERNAME}  %{MEMBERS_TEST_SECOND_PASSWORD}

  Go To Private Nachrichten
  Click Element  jquery:.messages-container .elgg-item h3.elgg-listing-summary-title:contains(Testdm) a

  Click Element  css:.elgg-listing-full-header li[data-menu-item=entity-menu-toggle]
  Wait Until Element Is Visible  css:#ui-id-1 li[data-menu-item=delete]
  Click Element  css:li[data-menu-item="delete"]
  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  HomePage.Logout
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Check Edit Form
  [Documentation]  Check the edit form for validity
  Element Should Be Visible  css:div[data-name="recipients"]
  Page Should Contain Element  name:match_on
  Element Should Be Visible  name:subject

  Wait Until Element Is Visible  tag:iframe
  Select Frame  tag:iframe
  Wait Until Element Is Visible  css:body.cke_editable
  Unselect Frame  

  Element Should Be Visible  css:.elgg-layout-content .elgg-button-submit
  Take Current Screenshot  private-nachrichten-edit