*** Settings ***

Documentation   Bulletin board page features
Library         SeleniumLibrary
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot
Resource        ../Constants.robot

*** Keywords ***

Go to Page
    [Arguments]                 ${URL}          ${BROWSER}      ${USERNAME}     ${PASSWORD}
    HomePage.Go to Page         ${URL}          ${BROWSER}
    HomePage.Login              ${USERNAME}     ${PASSWORD}
    Go To Menu                  Forum
    I Am On                     Forum
    Take Current Screenshot     forum

Check Posts
    ${posts} =                      Get Element Count   class:elgg-item
    Should Be Equal As Integers     ${posts}            ${EXPECTED_FORUM_POSTS}

Check Pagination
    ${pages} =                          Get Element Count                           css:ul.elgg-pagination li
    Should Be True                      ${pages} > 4
    
    ${topPostTitle} =                   Get Text                                    jquery:.elgg-item+.elgg-discoverable h3 .elgg-anchor-label:eq(0)

    Click Element                       css:a.elgg-next
    Wait Until Element Is Visible       class:elgg-spinner
    Wait Until Element Is Not Visible   class:elgg-spinner
    ${topPostTitleNext} =               Get Text                                    jquery:.elgg-item+.elgg-discoverable h3 .elgg-anchor-label:eq(0)

    Should Be True                      '${topPostTitle}' != '${topPostTitleNext}'