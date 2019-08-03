*** Settings ***

Documentation  Basic site features

Resource  ../pages/Utils.robot
Resource  ../pages/HomePage.robot
Resource  ../pages/BasicNavigation.robot

Suite Teardown  Teardown Application
Suite Setup  Tearup Application

*** Test Cases ***

Site Is Available
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}

Login Is Possible
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}

Menu Is Complete
  Menu Should Exist  Spielerliste
  Menu Should Exist  Termine
  Menu Should Exist  Forum
  Menu Should Exist  Handbuch

Important Elements Exist
  Search Is Available
  Settings Are Available
  Homepage Link Is Available

Logout Is Possible
  Logout