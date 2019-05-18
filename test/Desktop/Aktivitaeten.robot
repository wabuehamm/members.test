*** Settings ***

Documentation   Activity stream features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Aktivitaeten.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    Aktivitaeten.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}

Features Are Available
    Aktivitaeten.Check Items