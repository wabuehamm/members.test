*** Settings ***

Documentation   Basic site features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/HomePage.robot
Resource        ../../pages/desktop/BasicNavigation.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Site Is Available
    HomePage.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    
    Take Current Screenshot  login

Login Is Possible
    Login             %{TEST_USERNAME}    %{TEST_PASSWORD}

Menu Is Complete
    Menu Should Exist  Spielerliste
    Menu Should Exist  Termine
    Menu Should Exist  Forum
    Menu Should Exist  Handbuch

Important Elements Exist
    Search Is Available
    Settings Are Available
    Homepage Link Is Available

Logout Is Possible
    Logout