*** Settings ***

Documentation   Member list features (Desktop)

Resource        ../../pages/Utils.robot
Resource        ../../pages/desktop/Forum.robot

Suite Teardown  Teardown Application
Suite Setup     Tearup Application

*** Test Cases ***

Page Is Available
    Forum.Go to Page

Features are Available
    Check Posts
    Check Pagination
    Create New Post
    Edit Post
    Like Post
    Delete Post