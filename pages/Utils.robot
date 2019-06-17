** Settings **

Library  SeleniumLibrary
Library  OperatingSystem

** Keywords **

Check Environment
  [Documentation]  Check, if all required environment variables are set
  Environment Variable Should Be Set  MEMBERS_TEST_BASEURL
  Environment Variable Should Be Set  MEMBERS_TEST_BROWSER
  Environment Variable Should Be Set  MEMBERS_TEST_USERNAME
  Environment Variable Should Be Set  MEMBERS_TEST_PASSWORD
  Environment Variable Should Be Set  MEMBERS_TEST_NOTIFICATION_PATH
  Environment Variable Should Be Set  MEMBERS_TEST_SECOND_USERNAME
  Environment Variable Should Be Set  MEMBERS_TEST_SECOND_PASSWORD
  Environment Variable Should Be Set  MEMBERS_TEST_SECOND_USER_DISPLAYNAME
  Environment Variable Should Be Set  MEMBERS_TEST_DOWNLOAD_DIR
  Environment Variable Should Be Set  MEMBERS_TEST_EMBED_IMAGE

Tearup Application
  [Documentation]  Tasks when starting the tests
  Check Environment

Teardown Application
  [Documentation]  Tasks when stopping the tests
  Close All Browsers

Take Current Screenshot
  [Documentation]  A standardized way of taking a current labeled screenshot
  [Arguments]  ${PAGE}
  Set Screenshot Directory  screenshots-current
  Capture Page Screenshot  filename=page-${PAGE}.png

Clean Notifications
  [Documentation]  Purge the file notifications directory prior notification tests
  [Arguments]  ${BASE_URL}  ${NOTIFICATION_PATHS}
  ${CURRENT_URL} =  Get Location  
  Go To  ${BASE_URL}/cron/minute
  Remove File  ${NOTIFICATION_PATHS}/*.txt
  Go To  ${CURRENT_URL}

Notifications Should Exist
  [Documentation]  Check, wether notifications would have been sent
  [Arguments]  ${BASE_URL}  ${NOTIFICATION_PATHS}
  ${CURRENT_URL} =  Get Location  
  Go To  ${BASE_URL}/cron/minute
  File Should Exist  ${NOTIFICATION_PATHS}/*.txt
  Go To  ${CURRENT_URL}