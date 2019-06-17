*** Settings ***

Documentation   Search features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Suche.robot

Suite Teardown  Teardown Application
Suite Setup     Tearup Application

*** Test Cases ***

Features are Available
    Suche.Go To Page
    Search For Events
    Search For Forum Posts
    Search For People