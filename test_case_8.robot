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
Scrolling page
  [Documentation]  Scrolling home page
  [Arguments]  ${x_coordinate}  ${y_coordinate}
  Execute JavaScript    window.scrollTo(${x_coordinate}, ${y_coordinate});
  Sleep    0.5

Home page with default arragement of name(A to Z) change to price(low to high) and Verify
  [Documentation]  SEE home page with default arragement of name(A to Z) change to price low to high and Verify
  Wait Until Element Is Visible    xpath=//*[@id="header_container"]/div[2]/div/span/select
  Click Element    xpath=//*[@id="header_container"]/div[2]/div/span/select
  Click Element    xpath=//*[@id="header_container"]/div[2]/div/span/select/option[3]
  ${arragement_name}  Get Element Attribute  xpath=//*[@id="header_container"]/div[2]/div/span/select/option[3]  value
  Should Be Equal    ${arragement_name}  lohi


Products's price is arragement of price(low to high) and Verify
  [Documentation]  check the price of the first and the last prodcut is arragement of price(low to high)
  ${first_product}  Get Text    xpath=//*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div
  ${first_product_price}  Get Substring    ${first_product}    1  5
  ${last_product}  Get Text    xpath=//*[@id="inventory_container"]/div/div[6]/div[2]/div[2]/div
  ${last_product_price}  Get Substring    ${last_product}    1  6
  ${compare}  Evaluate  ${first_product_price} < ${last_product_price}
  Should Be True    ${compare}
  

Browse product
  [Documentation]  Browse product
  [Arguments]  ${username}  ${password}
  Login  ${username}  ${password}
  Scrolling page  0    document.body.scrollHeight
  Scrolling page  0    0
  Home page with default arragement of name(A to Z) change to price(low to high) and Verify
  Products's price is arragement of price(low to high) and Verify
