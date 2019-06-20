*** Settings ***

Documentation  Settings features (Desktop)

Resource  ../../pages/Utils.robot
Resource  ../../pages/desktop/Einstellungen.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Page Is Available
  Einstellungen.Go to Page

Features are Available
  Einstellungen.Check Change Password
  Einstellungen.Check E-Mailadress
  Einstellungen.Check Profile
  Einstellungen.Check Other Profile
  
  Einstellungen.Change Profile