*** Settings ***

Documentation  Login page features
Library  SeleniumLibrary
Library  MobileUtils
Resource  PageIdentification.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  [Arguments]  ${URL}  ${BROWSER}
  ${capa} =   Get Emulated Mobile Capabilities  Galaxy S5
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Open Browser   ${URL}  browser=chrome  desired_capabilities=${capa}  remote_url=%{MEMBERS_TEST_SELENIUM_URL}  
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Open Browser   ${URL}  browser=chrome  remote_url=%{MEMBERS_TEST_SELENIUM_URL}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Set Window Size  1400  768
  
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
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Mouse Over  css:li[data-menu-item=account]
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  class:.elgg-nav-collapse
  Click Element  css:${parentBar} li[data-menu-item="logout"]
  I Am On  Homepage
  
