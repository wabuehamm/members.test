*** Settings ***

Documentation  Basic navigation structure
Library  SeleniumLibrary

*** Keywords ***

Menu Should Exist
  [Documentation]  A standardized way to check wether a menu is available
  [Arguments]  ${MENUNAME}
  Element Should Be Visible  jquery:.elgg-page-topbar a.elgg-menu-content span:contains(${MENUNAME})

Go To Menu
  [Documentation]  Select a specific menu item
  [Arguments]  ${MENUNAME}
  Click Element  jquery:a[data-menu-item-name="global"]
  Click Element  jquery:.elgg-page-topbar a.elgg-menu-content span:contains(${MENUNAME})

Search Is Available
  [Documentation]  Check, wether the search feature is available
  Element Should Be Visible  css:.elgg-page-topbar input[name="q"]  

Settings Are Available
  [Documentation]  Check, wether the settings menu is available
  Page Should Contain Element  css:a[data-menu-item-name="usersettings"]

Homepage Link Is Available
  [Documentation]  Check, wether the homepage link is available
  Element Should Be Visible  css:div.elgg-topbar-logo
