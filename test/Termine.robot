*** Settings ***

Documentation  Calendar features

Resource  ../pages/Utils.robot
Resource  ../pages/Termine.robot
Resource  ../pages/Termine/Agenda.robot
Resource  ../pages/Termine/Full.robot
Resource  ../pages/Termine/Paged.robot

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