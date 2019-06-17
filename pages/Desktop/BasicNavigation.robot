*** Settings ***

Documentation  Basic navigation structure
Library  SeleniumLibrary

*** Keywords ***

Menu Should Exist
  [Arguments]  ${MENUNAME}
  Element Should Be Visible  jquery:.elgg-page-topbar a.elgg-menu-content span:contains(${MENUNAME})

Go To Menu
  [Arguments]  ${MENUNAME}
  Click Element  jquery:a[data-menu-item-name="global"]
  Click Element  jquery:.elgg-page-topbar a.elgg-menu-content span:contains(${MENUNAME})

Search Is Available
  Element Should Be Visible  css:.elgg-page-topbar input[name="q"]  

Settings Are Available
  Page Should Contain Element  css:a[data-menu-item-name="usersettings"]

Homepage Link Is Available
  Element Should Be Visible  css:div.elgg-topbar-logo
