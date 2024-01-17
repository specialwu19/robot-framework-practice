*** Settings ***
Library  Selenium2Library

*** Keywords ***
Login
  [Documentation]  Login
  [Arguments]  ${username}  ${password}
  Wait Until Element Is Visible  xpath=//*[@id="user-name"]
  Input Text  xpath=//*[@id="user-name"]  ${username}
  Input Text  xpath=//*[@id="password"]  ${password}
  Submit form
  Sleep  2