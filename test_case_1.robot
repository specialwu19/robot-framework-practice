*** Settings ***
Library  Selenium2Library
Resource  keywords/keywords.robot
Documentation  Valid Login user with correct input and Logout
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
Valid Login user with correct input and Logout
  Login and Logout  ${username}  ${password}

*** Keywords ***
Login Verify
  [Documentation]  Login Success and See Swag Labs logo
  Wait Until Element Is Visible  xpath=//*[@id="header_container"]/div[1]/div[2]/div
  Element Text Should be  xpath=//*[@id="header_container"]/div[1]/div[2]/div  Swag Labs

Logout
  [Documentation]  Logout
  Wait Until Element Is Visible  xpath=//*[@id="react-burger-menu-btn"]
  Click Button  xpath=//*[@id="react-burger-menu-btn"]
  Wait Until Element Is Visible  xpath=//*[@id="logout_sidebar_link"]
  Click Element  xpath=//*[@id="logout_sidebar_link"]
  Sleep  2

Logout Verify
  [Documentation]  Logout Success and See Login Button
  Wait Until Element Is Visible  id=login-button
  ${button_text}    Get Element Attribute  id=login-button  value
  Should Be Equal    ${button_text}    Login
  
Login and Logout
  [Documentation]  Login and Logout Success then Verify
  [Arguments]  ${username}  ${password}
  Login  ${username}  ${password}
  Login Verify
  Logout
  Logout Verify
