*** Settings ***
Library  Selenium2Library
Library    String
Resource  keywords/keywords.robot
Documentation  Vaild browse products
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
Vaild browse products
  Browse product  ${username}  ${password}

*** Keywords ***
Home page with default arragement of name(A to Z) change to Z to A and Verify
  [Documentation]  SEE home page with default arragement of name(A to Z) change to Z to A and Verify
  Wait Until Element Is Visible    xpath=//*[@id="header_container"]/div[2]/div/span/select
  Click Element    xpath=//*[@id="header_container"]/div[2]/div/span/select
  Click Element    xpath=//*[@id="header_container"]/div[2]/div/span/select/option[2]
  ${arragement_name}  Get Element Attribute  xpath=//*[@id="header_container"]/div[2]/div/span/select/option[2]  value
  Should Be Equal    ${arragement_name}  za

Products's titles are arragement of name(A to Z) and Verify
  [Documentation]  Check the first letter of the first and the last prodcut's title is arragement of name(A to Z)
  ${first_product}  Get Text    xpath=//*[@id="item_3_title_link"]/div
  ${first_product_first_letter}  Get Substring  ${first_product}  0  1
  ${last_product}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  ${last_product_first_letter}  Get Substring  ${last_product}  0  1
  ${compare}  Evaluate  "${first_product_first_letter}" > "${last_product_first_letter}"
  Should Be True    ${compare}

Browse product
  [Documentation]  Browse product
  [Arguments]  ${username}  ${password}
  Login  ${username}  ${password}
  Scrolling page  0    document.body.scrollHeight
  Scrolling page  0    0
  Home page with default arragement of name(A to Z) change to Z to A and Verify
  Products's titles are arragement of name(A to Z) and Verify
