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

Checkout
  [Documentation]  Checkout step by step
  [Arguments]  ${first_name}  ${last_name}  ${postal_code}
  Click Element    xpath=//*[@id="checkout"]
  Wait Until Element Is Visible    xpath=//*[@id="first-name"]
  Input Text    xpath=//*[@id="first-name"]    ${first_name}
  Input Text    xpath=//*[@id="last-name"]    ${last_name}
  Input Text    xpath=//*[@id="postal-code"]    ${postal_code}
  Submit Form
  Sleep    1

Get price and Convert to number
  [Documentation]  Get price and Convert to number
  [Arguments]  ${xpath}
  ${product_price}  Get Text    xpath=${xpath}
  ${product_price}  Set Variable  ${product_price.split("$")}
  ${product_price}  Set Variable  ${product_price[-1]}
  ${product_price}  Convert To Number    ${product_price}
  [Return]  ${product_price}
