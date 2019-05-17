*** Settings ***

Documentation   Handbuch page features
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
    Go To Menu                  Handbuch
    I Am On                     Handbuch
    Take Current Screenshot     handbuch
