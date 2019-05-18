*** Settings ***

Documentation   Activity strem features
Library         SeleniumLibrary
Library         String
Library         OperatingSystem
Library         DateTime
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot
Resource        ../Constants.robot

*** Keywords ***

Go to Page
    [Arguments]                 ${URL}                  ${BROWSER}      ${USERNAME}     ${PASSWORD}
    HomePage.Go to Page         ${URL}                  ${BROWSER}
    HomePage.Login              ${USERNAME}             ${PASSWORD}
    Go To                       ${URL}/activity
    I Am On                     Aktivitaeten
    Take Current Screenshot     aktivitaeten

Check Items
    ${ITEMS} =                          Get Element Count       css:div.elgg-inner>div.elgg-list-container>ul.elgg-list>li.elgg-item

    Should Be Equal As Integers         ${ITEMS}                ${EXPECTED_ACTIVITY_STREAM_ITEMS}
    Click Element                       css:a.elgg-after
    Wait Until Element Is Not Visible   class:elgg-spinner
    
    ${ITEMS_20} =                       Get Element Count       css:div.elgg-inner>div.elgg-list-container>ul.elgg-list>li.elgg-item

    Should Be Equal As Integers         ${ITEMS + 20}           ${ITEMS_20}