*** Settings ***

Documentation   Direct message page features
Library         SeleniumLibrary
Library         String
Library         OperatingSystem
Library         DateTime
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot
Resource        ../Constants.robot

*** Variables ***

${SECOND_USERNAME} =            ""
${SECOND_PASSWORD} =            ""
${SECOND_USER_DISPLAYNAME} =    ""
${FIRST_USERNAME} =             ""
${FIRST_PASSWORD} =             ""

*** Keywords ***

Go to Page
    [Arguments]                 ${URL}                          ${BROWSER}      ${USERNAME}     ${PASSWORD}     ${P_SECOND_USERNAME}      ${P_SECOND_PASSWORD}      ${P_SECOND_USER_DISPLAYNAME}
    Set Suite Variable          ${SECOND_USERNAME}              ${P_SECOND_USERNAME}
    Set Suite Variable          ${SECOND_PASSWORD}              ${P_SECOND_PASSWORD}
    Set Suite Variable          ${SECOND_USER_DISPLAYNAME}      ${P_SECOND_USER_DISPLAYNAME}
    Set Suite Variable          ${FIRST_USERNAME}               ${USERNAME}
    Set Suite Variable          ${FIRST_PASSWORD}               ${PASSWORD}
    HomePage.Go to Page         ${URL}                          ${BROWSER}
    HomePage.Login              ${USERNAME}                     ${PASSWORD}
    Go To Private Nachrichten
    I Am On                     Private-Nachrichten
    Take Current Screenshot     private-nachrichten

Go To Private Nachrichten
    Click Element               css:a[data-menu-item-name="messages"]

Send Direct Message
    Click Element                   css:a[data-menu-item-name="add"]
    Check Edit Form
    Input Text                      css:div[data-name="recipients"] input                               ${SECOND_USER_DISPLAYNAME}
    Wait Until Element Is Visible   css:ul.ui-autocomplete > li

    Press Keys                      css:div[data-name="recipients"] input                               DOWN                        TAB

    Input Text                      name:subject                                                        Testdm
    
    # Use Javascript to work around tinymce editor
    Execute Javascript              $('textarea[name=body]').text('This is a test direct message')

    Submit Form                     class:elgg-form-messages-send

    Homepage.Logout
    HomePage.Login                  ${SECOND_USERNAME}                                                  ${SECOND_PASSWORD}

    Go To Private Nachrichten

    Element Should Be Visible       jquery:.messages-container .elgg-item h3.title:contains(Testdm)

    HomePage.Logout
    HomePage.Login                  ${FIRST_USERNAME}                                                               ${FIRST_PASSWORD}

Receive Reply
    HomePage.Logout
    HomePage.Login                  ${SECOND_USERNAME}                                                              ${SECOND_PASSWORD}

    Go To Private Nachrichten

    Click Element                   jquery:.messages-container .elgg-item h3.title:contains(Testdm) a

    # Use Javascript to work around tinymce editor
    Execute Javascript              $('textarea[name=body]').text('This is a test reply')

    Submit Form                     id:messages-reply-form

    HomePage.Logout
    HomePage.Login                  ${FIRST_USERNAME}                                                               ${FIRST_PASSWORD}

    Go To Private Nachrichten

    Element Should Be Visible       jquery:.elgg-listing-summary-inline-content:contains("This is a test reply")

Delete Direct Message
    Go To Private Nachrichten
    Click Element                   jquery:h3.title:contains("RE: Testdm") a
    Click Element                   css:a[data-menu-item-name="delete"]
    Alert Should Be Present         Bist Du sicher, dass Du diesen Eintrag löschen willst?

    HomePage.Logout
    HomePage.Login                  ${SECOND_USERNAME}                                                              ${SECOND_PASSWORD}

    Go To Private Nachrichten
    Click Element                   jquery:h3.title:contains("Testdm") a
    Click Element                   css:a[data-menu-item-name="delete"]
    Alert Should Be Present         Bist Du sicher, dass Du diesen Eintrag löschen willst?

    HomePage.Logout
    HomePage.Login                  ${FIRST_USERNAME}                                                               ${FIRST_PASSWORD}

Check Edit Form
    Element Should Be Visible       css:div[data-name="recipients"]
    Element Should Be Visible       name:match_on
    Element Should Be Visible       name:subject
    Page Should Contain Element     name:body
    Element Should Be Visible       class:elgg-button-submit
    Take Current Screenshot         private-nachrichten-edit


