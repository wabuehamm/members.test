*** Settings ***

Documentation   Members list page features
Library         SeleniumLibrary
Library         String
Resource        PageIdentification.robot
Resource        HomePage.robot
Resource        BasicNavigation.robot

*** Keywords ***

Go to Page
    [Arguments]         ${URL}      ${BROWSER}      ${USERNAME}     ${PASSWORD}
    HomePage.Go to Page  ${URL}  ${BROWSER}
    HomePage.Login  ${USERNAME}  ${PASSWORD}
    Go To Menu  Spielerliste
    I Am On  Spielerliste

Check Search Feature
    Element Should Be Visible  member_query

Check Memberlist
    ${listElements} =               Get Element Count       css:.elgg-item-user
    Should Be Equal As Numbers      ${listElements}         10
    ${numberOfMembers} =            Get Text                css:.elgg-form-members-search p.elgg-text-help
    ${members} =                    Get Regexp Matches      ${numberOfMembers}      Gesamtzahl der Mitglieder: ([0-9]+)     1
    Should Be True                  ${members}[0] > 300


Check Pagination
    Element Should Be Visible  class:elgg-pagination
    ${pages} =                 Get Element Count        css:ul.elgg-pagination li
    Should Be True             ${pages} > 5