** Settings **

Documentation                   The site calendar in full view
Resource                        ../../Constants.robot
Library                         SeleniumLibrary

** Keywords **

Check Features
    Click Element               css:a[data-menu-item-name=format_full]
    I Am On                     Termine-Full
    Take Current Screenshot     termine-full
    Full.Check Calendar Entries

Check Calendar Entries
    Wait Until Element Is Visible   css:a.fc-event
    ${calendarEntries} =            Get Element Count                                   css:a.fc-event
    Should Be True                  ${calendarEntries} > ${EXPECTED_CALENDAR_ENTRIES}