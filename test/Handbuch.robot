*** Settings ***

Documentation  Poll features

Resource  ../../pages/Utils.robot
Resource  ../../pages/Handbuch.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Page Is Available
  Handbuch.Go to Page
  