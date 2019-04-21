*** Settings ***

Documentation   Member list features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Forum.robot

Suite Teardown  Teardown Application

*** Test Cases ***

Page Is Available
    Forum.Go to Page  %{TEST_BASEURL}     %{TEST_BROWSER}    %{TEST_USERNAME}    %{TEST_PASSWORD}

Features are Available
    Check Posts
    Check Pagination
    Create New Post
    Edit Post
    Delete Post