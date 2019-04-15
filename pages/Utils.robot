** Settings **

Library         SeleniumLibrary

** Keywords **

Teardown Application
    Close All Browsers

Take Current Screenshot
    [Arguments]     ${PAGE}
    Set Screenshot Directory  screenshots
    Capture Page Screenshot  filename=page-${PAGE}-current.png
