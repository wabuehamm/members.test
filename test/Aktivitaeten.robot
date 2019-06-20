*** Settings ***

Documentation  Activity stream features

Resource  ../../pages/Utils.robot
Resource  ../../pages/Aktivitaeten.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Page Is Available
  Aktivitaeten.Go to Page

Features Are Available
  Aktivitaeten.Check Items