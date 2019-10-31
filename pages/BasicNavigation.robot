*** Settings ***

Documentation  Basic navigation structure
Library  SeleniumLibrary

*** Keywords ***

Menu Should Exist
  [Documentation]  A standardized way to check wether a menu is available
  [Arguments]  ${MENUNAME}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Element Should Be Visible  jquery:${parentBar} a.elgg-menu-content span:contains(${MENUNAME})
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Not Visible  class:elgg-page-navbar

Go To Menu
  [Documentation]  Select a specific menu item
  [Arguments]  ${MENUNAME}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Mouse Over  css:li[data-menu-item=account]
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(${MENUNAME})
  Click Element  jquery:${parentBar} a.elgg-menu-content span:contains(${MENUNAME})
  
Search Is Available
  [Documentation]  Check, wether the search feature is available
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Element Should Be Visible  css:${parentBar} input[name="q"]  
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:elgg-nav-button
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Not Visible  class:elgg-page-navbar

Settings Are Available
  [Documentation]  Check, wether the settings menu is available
  Page Should Contain Element  css:li[data-menu-item="usersettings"]

Homepage Link Is Available
  [Documentation]  Check, wether the homepage link is available
  Element Should Be Visible  css:h1.elgg-heading-site a
