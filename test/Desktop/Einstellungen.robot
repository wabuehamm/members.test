*** Settings ***

Documentation   Settings features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Einstellungen.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    Einstellungen.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}   %{TEST_NOTIFICATIONS_PATH}

Features are Available
    Einstellungen.Check Change Password
    Einstellungen.Check E-Mailadress