*** Settings ***

Documentation  Bulletin board page features
Library  SeleniumLibrary
Library  String
Resource  PageIdentification.robot
Resource  HomePage.robot
Resource  BasicNavigation.robot
Resource  Constants.robot
Resource  Utils.robot

*** Keywords ***

Go to Page
  [Documentation]  Check availability of the page
  HomePage.Go to Page  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_BROWSER}
  HomePage.Login  %{MEMBERS_TEST_USERNAME}  %{MEMBERS_TEST_PASSWORD}
  Go To Menu  Forum
  I Am On  Forum
  Take Current Screenshot  forum

Check Posts
  [Documentation]  Check the list of posts
  ${posts} =  Get Element Count  class:elgg-item-object-discussion
  Should Be Equal As Integers  ${posts}  ${EXPECTED_FORUM_POSTS}

Check Pagination
  [Documentation]  Check the pagination features
  ${pages} =  Get Element Count  css:ul.elgg-pagination li
  Should Be True  ${pages} > 4
  
  ${topPostTitle} =  Get Text  jquery:h3.elgg-listing-summary-title .elgg-anchor-label:eq(0)

  Click Element  jquery:a.elgg-anchor:contains(Weiter)
  ${topPostTitleNext} =  Get Text  jquery:h3.elgg-listing-summary-title .elgg-anchor-label:eq(0)

  Should Be True  '${topPostTitle}' != '${topPostTitleNext}'

  Take Current Screenshot  forum-nextpage

Create New Post
  [Documentation]  Check creating a new post
  Utils.Clean Notifications  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_NOTIFICATION_PATH}
  Click Element  css:li[data-menu-item=add]
  Check Edit Form
  Input Text  name:title  Testpost

  # Use Javascript to work around tinymce editor
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].insertText('This is a Testpost')

  Input Text  name:tags  test
  
  # Test embed feature
  Click Element  css:li[data-menu-item=embed]
  Wait Until Element Is Visible  jquery:span:contains("Datei hochladen")
  Click Element  jquery:span:contains("Datei hochladen")

  Wait Until Element Is Visible  name:upload
  Input Text  name:upload  %{MEMBERS_TEST_EMBED_IMAGE}
  Input Text  css:#cboxWrapper input[name="title"]  Testimage
  Submit Form  class:elgg-form-embed

  Wait Until Element Is Visible  jquery:h3:contains(Testimage)

  Click Element  jquery:h3:contains(Testimage)
  Wait Until Element Is Not Visible  css:#cboxWrapper
  Select Frame  class:cke_wysiwyg_frame
  Wait Until Element Is Visible  css:img[alt="Testimage"]
  Unselect Frame
  
  Submit Form  class:elgg-form-discussion-save
  Check Created Post
  Utils.Notifications Should Exist  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_NOTIFICATION_PATH}

Check Edit Form
  [Documentation]  Check editing a post
  Element Should Be Visible  name:title

  Wait Until Element Is Visible  tag:iframe

  Element Should Be Visible  tag:iframe
  Page Should Contain Element  name:description
  Element Should Be Visible  name:tags
  Element Should Be Visible  name:status
  Element Should Be Visible  css:button.elgg-button-submit
  Take Current Screenshot  forum-edit

Select Test Post
  [Documentation]  Go to one of the posts we're testing with
  [Arguments]  ${TITLE}
  Go To Menu  Forum
  Click Element  jquery:h3.elgg-listing-summary-title a:contains(${TITLE})

Check Created Post
  [Documentation]  Check the created post for validity
  Select Test Post  Testpost
  Take Current Screenshot  forum-post-created

  Element Text Should Be  css:h2.elgg-heading-main  Testpost
  Element Text Should Be  css:div.elgg-listing-full-body p  This is a Testpost
  Element Text Should Be  css:span.elgg-tag a span  test
  Element Should Be Visible  css:img[alt=Testimage]  

Edit Post
  [Documentation]  Check the workflow for editing a post
  Select Test Post  Testpost

  Click Element  css:li[data-menu-item=entity-menu-toggle]
  Wait Until Element Is Visible  css:li[data-menu-item=edit]
  Click Element  css:li[data-menu-item=edit]

  Wait Until Element Is Visible  tag:iframe

  Select Frame  tag:iframe
  Wait Until Element Contains  css:body.cke_editable p  This is a Testpost
  Unselect Frame  

  Input Text  name:title  Testpost2
  
  # Use Javascript to work around ckeditor
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].setData('')
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].insertText('This is a Testpost2')
  
  Input Text  name:tags  test2
  Submit Form  class:elgg-form-discussion-save
  
  Check Edited Post

Check Edited Post
  [Documentation]  Check the edited post for validity
  Select Test Post  Testpost2

  Take Current Screenshot  forum-post-edited

  Element Text Should Be  css:h2.elgg-heading-main  Testpost2
  Element Text Should Be  css:div.elgg-listing-full-body p  This is a Testpost2
  Element Text Should Be  css:span.elgg-tag a span  test2

Like Post
  [Documentation]  Check the workflow for liking a post
  Select Test Post  Testpost2

  Element Should Not Be Visible  css:li[data-menu-item=likes_count]

  Click Element  css:li[data-menu-item=likes]
  Wait Until Element Is Not Visible  class:elgg-spinner

  Select Test Post  Testpost2

  Wait Until Element Is Visible  css:li[data-menu-item=likes_count]
  Element Should Contain  css:li[data-menu-item=likes_count]  1 gefällt
  
  Take Current Screenshot  forum-liked-posts

Comment Post
  [Documentation]  Check commenting a post
  Utils.Clean Notifications  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_NOTIFICATION_PATH}
  Go To Menu  Forum

  Select Test Post  Testpost2
  
  ${comments} =  Get Element Count  class:elgg-item-object-comment
  Should Be Equal As Integers  ${comments}  0

  Wait Until Element Is Visible  tag:iframe

  Select Frame  tag:iframe
  Wait Until Element Is Visible  css:body.cke_editable
  Unselect Frame  
  
  Execute Javascript  CKEDITOR.instances[Object.keys(CKEDITOR.instances)[0]].insertText('This is a Testcomment')
  Submit Form  class:elgg-form-comment-save

  Wait Until Element Is Not Visible  class:elgg-spinner

  Element Should Be Visible  jquery:.elgg-item-object-comment p:contains(This is a Testcomment)

  ${comments} =  Get Element Count  class:elgg-item-object-comment
  Should Be Equal As Integers  ${comments}  1

  Utils.Notifications Should Exist  %{MEMBERS_TEST_BASEURL}  %{MEMBERS_TEST_NOTIFICATION_PATH}

  Take Current Screenshot  forum-commentedpost

Delete Post
  [Documentation]  Check deleting a post
  Go To Menu  Forum
  Element Should Be Visible  jquery:h3.elgg-listing-summary-title a:contains(Testpost2)

  Select Test Post  Testpost2

  Click Element  css:.elgg-listing-full-header li[data-menu-item=entity-menu-toggle]
  Wait Until Element Is Visible  css:#ui-id-1 li[data-menu-item=delete]
  Click Element  css:#ui-id-1 li[data-menu-item=delete]
  
  Alert Should Be Present  Bist Du sicher, dass Du diesen Eintrag löschen willst?

  Go To Menu  Forum
  Page Should Not Contain Element  jquery:h3.elgg-listing-summary-title a:contains(Testpost2)
