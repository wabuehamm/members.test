*** Settings ***

Documentation   Search features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Suche.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Features are Available
    Suche.Go To Page            %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}
    Search For Events
    Search For Forum Posts
    Search For People