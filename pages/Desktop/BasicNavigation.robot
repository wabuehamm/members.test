*** Settings ***

Documentation  Basic navigation structure
Library  SeleniumLibrary

*** Keywords ***

Menu Should Exist
  [Documentation]  A standardized way to check wether a menu is available
  [Arguments]  ${MENUNAME}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Element Should Be Visible  jquery:${parentBar} a.elgg-menu-content span:contains(${MENUNAME})

Go To Menu
  [Documentation]  Select a specific menu item
  [Arguments]  ${MENUNAME}
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "desktop"  Click Element  jquery:a[data-menu-item-name="global"]
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Click Element  jquery:${parentBar} a.elgg-menu-content span:contains(${MENUNAME})

Search Is Available
  [Documentation]  Check, wether the search feature is available
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Click Element  class:nav-toggle
  Run Keyword If  "%{MEMBERS_TEST_VIEW_TYPE}" == "mobile"  Wait Until Element Is Visible  jquery:${parentBar} a.elgg-menu-content span:contains(Handbuch)
  Element Should Be Visible  css:${parentBar} input[name="q"]  

Settings Are Available
  [Documentation]  Check, wether the settings menu is available
  Page Should Contain Element  css:a[data-menu-item-name="usersettings"]

Homepage Link Is Available
  [Documentation]  Check, wether the homepage link is available
  Element Should Be Visible  css:div.elgg-topbar-logo
