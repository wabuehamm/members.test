*** Settings ***

Documentation  Direct message features (Desktop)

Resource  ../../pages/Utils.robot
Resource  ../../pages/PrivateNachrichten.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Page Is Available
  PrivateNachrichten.Go to Page

Features are Available
  Send Direct Message
  Receive Reply
  Delete Direct Message
