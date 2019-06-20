*** Settings ***

Documentation  Member list features

Resource  ../../pages/Utils.robot
Resource  ../../pages/Spielerliste.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Page Is Available
  Spielerliste.Go to Page

Features are Available
  Check Memberlist
  Check Pagination
  Check Search Feature