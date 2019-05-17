*** Settings ***

Documentation   Poll features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Handbuch.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    Handbuch.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}
    