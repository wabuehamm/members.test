*** Settings ***

Documentation   Direct message features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/PrivateNachrichten.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    PrivateNachrichten.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}      %{TEST_SECOND_USER}     %{TEST_SECOND_PASSWORD}     %{TEST_SECOND_USER_DISPLAYNAME}

Features are Available
    Send Direct Message
    Receive Reply
    Delete Direct Message
