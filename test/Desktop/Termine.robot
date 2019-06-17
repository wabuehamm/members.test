*** Settings ***

Documentation  Calendar features (Desktop)

Resource  ../../pages/Utils.robot
Resource  ../../pages/desktop/Termine.robot
Resource  ../../pages/desktop/Termine/Agenda.robot
Resource  ../../pages/desktop/Termine/Full.robot
Resource  ../../pages/desktop/Termine/Paged.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Page Is Available
  Termine.Go to Page

Features are Available
  Paged.Check Features
  Agenda.Check Features
  Full.Check Features
  Check Ical Export Feature
  Check Basic Calendar Features
  Check Single Ical Export Feature
  Check Ical Import Feature