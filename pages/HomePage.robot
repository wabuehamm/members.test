*** Settings ***

Documentation  Login page features
Library  SeleniumLibrary
Library  MobileUtils
Resource  PageIdentification.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  [Arguments]  ${URL}  ${BROWSER}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Open Emulated Mobile Browser  Galaxy S5
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Go To  ${URL}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Open Browser  ${URL}  ${BROWSER}
  Set Window Size  1024  768
  
  I Am On  Homepage
  Take Current Screenshot  login

Handle Messages
  [Documentation]  Handle the display of messages, which might get between our clicks
  ${MESSAGES} =  Get Element Count  class:elgg-message
  Run Keyword If  ${MESSAGES} > 0  Run Keyword And Ignore Error  Click Element  class:elgg-message
  Run Keyword If  ${MESSAGES} > 0  Wait Until Element Is Not Visible  class:elgg-message

Login
  [Documentation]  Log into the site when we're on the login page
  [Arguments]  ${USERNAME}  ${PASSWORD}
  Input Text  css:.elgg-page-body input[name="username"]  ${USERNAME}
  Input Password  css:.elgg-page-body input[name="password"]  ${PASSWORD}
  Submit Form  css:.elgg-page-body .elgg-form-login
  I Am On  Startpage
  Handle Messages

Logout
  [Documentation]  Logout of the site
  Handle Messages
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Click Element  jquery:a[data-menu-item-name="global"]
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Click Element  css:${parentBar} a[data-menu-item-name="logout"]
  I Am On  Homepage
  
