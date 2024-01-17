*** Settings ***
Library  Selenium2Library
Resource  keywords/keywords.robot
Documentation  Invalid Login user with invaild input
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  password

*** Test Cases ***
Invalid Login user with invaild input
  Login and Verify    ${username}    ${password}

*** Keywords ***
Login Verify
  [Documentation]  Login Fail and see Warning
  Wait Until Element Is Visible    xpath=//*[@id="login_button_container"]/div/form/div[3]/h3
  Element Text Should Be    xpath=//*[@id="login_button_container"]/div/form/div[3]/h3    Epic sadface: Username and password do not match any user in this service

Login and Verify
  [Documentation]  Login Fail and Verify
  [Arguments]  ${user}  ${pass}
  Login    ${user}    ${pass}
  Login Verify