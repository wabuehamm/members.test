*** Settings ***

Documentation   Activity stream features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Aktivitaeten.robot

Suite Teardown  Teardown Application
Suite Setup     Tearup Application

*** Test Cases ***

Page Is Available
    Aktivitaeten.Go to Page

Features Are Available
    Aktivitaeten.Check Items