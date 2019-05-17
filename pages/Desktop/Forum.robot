*** Settings ***

Documentation   Bulletin board page features
Library         SeleniumLibrary
Library         String
Library         OperatingSystem
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot
Resource        ../Constants.robot

*** Variables ***

${NOTIFICATION_PATHS}       ""
${BASE_URL}                 ""

*** Keywords ***

Go to Page
    [Arguments]                 ${URL}                  ${BROWSER}      ${USERNAME}     ${PASSWORD}     ${P_NOTIFICATION_PATHS}
    Set Suite Variable          ${NOTIFICATION_PATHS}   ${P_NOTIFICATION_PATHS}
    Set Suite Variable          ${BASE_URL}             ${URL}
    HomePage.Go to Page         ${URL}                  ${BROWSER}
    HomePage.Login              ${USERNAME}             ${PASSWORD}
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

Create New Post
    Clean Notifications
    Click Element                       css:a[data-menu-item-name=add]
    Check Edit Form
    Input Text                          name:title                                                  Testpost

    # Use Javascript to work around tinymce editor
    Execute Javascript                  $('textarea[name=description]').text('This is a Testpost')

    Input Text                          name:tags                                                   test
    Submit Form                         class:elgg-form-discussion-save
    Check Created Post
    Notifications Should Exist

Check Edit Form
    Element Should Be Visible           name:title
    Element Should Be Visible           tag:iframe
    Page Should Contain Element         name:description
    Element Should Be Visible           name:tags
    Element Should Be Visible           name:status
    Element Should Be Visible           css:input.elgg-button-submit
    Take Current Screenshot             forum-edit

Select Test Post
    [Arguments]                         ${TITLE}
    Go To Menu                          Forum
    Click Element                       jquery:h3.title a:contains(${TITLE})

Check Created Post
    Select Test Post                    Testpost
    Take Current Screenshot             forum-post-created

    Element Text Should Be              css:h3.title a span                         Testpost
    Element Text Should Be              css:div.elgg-listing-summary-body p         This is a Testpost
    Element Text Should Be              css:div.elgg-tag a span                     test

Edit Post
    Select Test Post                    Testpost

    Click Element                       css:a[data-menu-item-name=edit]
    Input Text                          name:title                                                      Testpost2
    
    # Use Javascript to work around tinymce editor
    Execute Javascript                  $('textarea[name=description]').text('This is a Testpost2')
    
    Input Text                          name:tags                                                       test2
    Submit Form                         class:elgg-form-discussion-save
    
    Check Edited Post

Check Edited Post
    Select Test Post                    Testpost2

    Take Current Screenshot             forum-post-edited

    Element Text Should Be              css:h3.title a span                         Testpost2
    Element Text Should Be              css:div.elgg-listing-summary-body p         This is a Testpost2
    Element Text Should Be              css:div.elgg-tag a span                     test2

Like Post
    Select Test Post    Testpost2
    ${likesText} =      Get Text                                css:li.elgg-menu-item-likes-count a span
    ${matches} =        Get Regexp Matches                      ${likesText}                                ([0-9]+) gefällt        1
    ${likes} =          Set Variable                            ${matches}[0]
    

    Click Element                   css:a[data-menu-item-name=likes]
    Wait Until Element Is Visible   css:li.elgg-state-success
    ${likesText} =                  Get Text                                css:li.elgg-menu-item-likes-count a         # The span is removed when the like button is clicked
    ${matches} =                    Get Regexp Matches                      ${likesText}                                ([0-9]+) gefällt        1
    Should Be True                  ${matches}[0] == ${likes} + 1

Comment Post
    Clean Notifications
    Go To Menu                          Forum
    ${comments} =                       Execute Javascript      $('a[data-menu-item-name=comments]', $('.title:contains(Testpost2))').parent().parent().parent()).length
    Should Be Equal As Integers         ${comments}             0
    
    Select Test Post                    Testpost2
    Execute Javascript                  $('textarea[name=description]').text('This is a Testcomment')
    Submit Form                         class:elgg-form-discussion-reply-save

    Element Should Be Visible           jquery:.elgg-comments li p:contains(This is a Testcomment)

    Go To Menu                          Forum
    ${comments} =                       Execute Javascript      $('a[data-menu-item-name=comments]', $('.title:contains(Testpost2))').parent().parent().parent()).length
    Should Be Equal As Integers         ${comments}             1

    Notifications Should Exist

Delete Post
    Select Test Post                    Testpost2
    Click Element                       css:a[data-menu-item-name=delete]
    Alert Should Be Present             Bist Du sicher, dass Du diesen Eintrag löschen willst?

    Go To Menu                          Termine
    Page Should Not Contain Element     jquery:h3.title a:contains(Testpost2)

Clean Notifications
    ${CURRENT_URL} =    Get Location  
    Go To               ${BASE_URL}/cron/minute
    Remove File         ${NOTIFICATION_PATHS}/*.txt
    Go To               ${CURRENT_URL}

Notifications Should Exist
    ${CURRENT_URL} =    Get Location  
    Go To               ${BASE_URL}/cron/minute
    File Should Exist   ${NOTIFICATION_PATHS}/*.txt
    Go To               ${CURRENT_URL}
