*** Settings ***

Documentation   Poll features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Umfragen.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    Umfragen.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}

Features are Available
    Check Polls
    Create New Poll
    Edit Poll
    Vote
    Delete Poll