** Settings **

Library         SeleniumLibrary
Library         OperatingSystem

** Keywords **

Check Environment
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
    Check Environment

Teardown Application
    Close All Browsers

Take Current Screenshot
    [Arguments]     ${PAGE}
    Set Screenshot Directory  screenshots
    Capture Page Screenshot  filename=page-${PAGE}-current.png

Clean Notifications
    [Arguments]         ${BASE_URL}                     ${NOTIFICATION_PATHS}
    ${CURRENT_URL} =    Get Location  
    Go To               ${BASE_URL}/cron/minute
    Remove File         ${NOTIFICATION_PATHS}/*.txt
    Go To               ${CURRENT_URL}

Notifications Should Exist
    [Arguments]         ${BASE_URL}                     ${NOTIFICATION_PATHS}
    ${CURRENT_URL} =    Get Location  
    Go To               ${BASE_URL}/cron/minute
    File Should Exist   ${NOTIFICATION_PATHS}/*.txt
    Go To               ${CURRENT_URL}