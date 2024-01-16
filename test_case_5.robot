*** Settings ***
Library  Selenium2Library
Documentation  Invalid Login user with locked user
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  locked_out_user
${password}  secret_sauce

*** Test Cases ***
Invalid Login user with locked user
  Login and Verify    ${username}    ${password}

*** Keywords ***
Login
  [Documentation]  Login
  [Arguments]  ${user}  ${pass}
  Wait Until Element Is Visible    xpath=//*[@id="user-name"]
  Input Text    xpath=//*[@id="user-name"]    ${user}
  Input Text    xpath=//*[@id="password"]    ${pass}
  Submit Form
  Sleep    2

Login Verify
  [Documentation]  Login Fail and see Warning
  Wait Until Element Is Visible    xpath=//*[@id="login_button_container"]/div/form/div[3]/h3
  Element Text Should Be    xpath=//*[@id="login_button_container"]/div/form/div[3]/h3    Epic sadface: Sorry, this user has been locked out.

Login and Verify
  [Documentation]  Login Fail and Verify
  [Arguments]  ${user}  ${pass}
  Login    ${user}    ${pass}
  Login Verify