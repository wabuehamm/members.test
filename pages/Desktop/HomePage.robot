*** Settings ***

Documentation   Login page features
Library         SeleniumLibrary
Resource        PageIdentification.robot

*** Keywords ***

Go to Page
    [Arguments]         ${URL}      ${BROWSER}
    Open Browser        ${URL}      ${BROWSER}
    I Am On  Homepage
    Take Current Screenshot  login

Login
    [Arguments]         ${USERNAME}     ${PASSWORD}
    Input Text          css:.elgg-page-body input[name="username"]   ${USERNAME}
    Input Password      css:.elgg-page-body input[name="password"]   ${PASSWORD}
    Submit Form         css:.elgg-page-body .elgg-form-login
    I Am On             Startpage

Logout
    Click Element                       class:elgg-message 
    Wait Until Element Is Not Visible   class:elgg-message
    Click Element                       css:.elgg-page-topbar a[data-menu-item-name="global"]
    Click Element                       css:.elgg-page-topbar a[data-menu-item-name="logout"]
    I Am On                             Homepage

