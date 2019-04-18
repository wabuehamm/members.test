*** Settings ***

Documentation   Calendar features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Termine.robot
Resource        ../../pages/desktop/Termine/Agenda.robot
Resource        ../../pages/desktop/Termine/Full.robot
Resource        ../../pages/desktop/Termine/Paged.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    ${downloadDir} =    Get Environment Variable    TEST_DOWNLOAD_DIR  default=~/Downloads
    Termine.Go to Page  %{TEST_BASEURL}             %{TEST_BROWSER}    %{TEST_USERNAME}     %{TEST_PASSWORD}     ${downloadDir}

Features are Available
    Paged.Check Features
    Agenda.Check Features
    Full.Check Features
    Check Ical Export Feature
    Check Basic Calendar Features