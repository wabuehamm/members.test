*** Settings ***

Documentation  Poll features

Resource  ../../pages/Utils.robot
Resource  ../../pages/Umfragen.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Page Is Available
  Umfragen.Go to Page

Features are Available
  Check Polls
  Create New Poll
  Edit Poll
  Vote
  Delete Poll