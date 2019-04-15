*** Settings ***

Documentation   Calendar features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Termine.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    Termine.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}
    Take Current Screenshot  termine

Features are Available
    Check Paged Features
    Check Agenda Features
    Check Full Features