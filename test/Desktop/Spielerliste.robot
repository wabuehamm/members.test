*** Settings ***

Documentation   Member list features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Spielerliste.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    Spielerliste.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}

Features are Available
    Check Memberlist
    Check Pagination
    Check Search Feature