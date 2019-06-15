** Settings **

Library         SeleniumLibrary
Library         OperatingSystem

** Keywords **

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