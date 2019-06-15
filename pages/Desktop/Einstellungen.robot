*** Settings ***

Documentation   Einstellungen page features
Library         SeleniumLibrary
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot
Resource        ../Constants.robot
Resource        ../Utils.robot

*** Variables ***
${OLD_PASSWORD}                 ""
${SITE_URL}                     ""
${USED_BROWSER}                 ""
${USED_USERNAME}                ""
${NOTIFICATION_PATHS}           ""

*** Keywords ***

Go to Page
    [Arguments]                 ${URL}                  ${BROWSER}      ${USERNAME}     ${PASSWORD}     ${P_NOTIFICATION_PATHS}
    Set Suite Variable          ${NOTIFICATION_PATHS}   ${P_NOTIFICATION_PATHS}
    Set Suite Variable          ${OLD_PASSWORD}         ${PASSWORD}
    Set Suite Variable          ${SITE_URL}             ${URL}
    Set Suite Variable          ${USED_BROWSER}         ${BROWSER}
    Set Suite Variable          ${USED_USERNAME}        ${USERNAME}
    HomePage.Go to Page         ${URL}                  ${BROWSER}
    HomePage.Login              ${USERNAME}             ${PASSWORD}
    Go To Menu                  Einstellungen
    I Am On                     Einstellungen
    Take Current Screenshot     einstellungen

Check Change Password
    Go To Menu                  Einstellungen
    Input Text                  name:current_password               ${OLD_PASSWORD}
    Input Text                  name:password                       test12345
    Input Text                  name:password2                      test12345
    Submit Form                 class:elgg-form-usersettings-save
    HomePage.Logout
    Close Browser  

    HomePage.Go to Page         ${SITE_URL}                         ${USED_BROWSER}
    HomePage.Login              ${USED_USERNAME}                    test12345
    
    Go To Menu                  Einstellungen
    Input Text                  name:current_password               test12345
    Input Text                  name:password                       ${OLD_PASSWORD}
    Input Text                  name:password2                      ${OLD_PASSWORD}
    Submit Form                 class:elgg-form-usersettings-save
    HomePage.Logout
    Close Browser  

    HomePage.Go to Page         ${SITE_URL}                         ${USED_BROWSER}
    HomePage.Login              ${USED_USERNAME}                    ${OLD_PASSWORD}

Check E-Mailadress
    Go To Menu                          Einstellungen
    ${EMAILADRESS} =                    Get Value                           name:email

    Input Text                          name:email                          test@test.com
    Submit Form                         class:elgg-form-usersettings-save

    Element Attribute Value Should Be   name:email                          value           test@test.com

    Input Text                          name:email                          ${EMAILADRESS}
    Submit Form                         class:elgg-form-usersettings-save

    Element Attribute Value Should Be   name:email                          value           ${EMAILADRESS}