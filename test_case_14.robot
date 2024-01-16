*** Settings ***
Library  Selenium2Library
Documentation  Vaild add two products into cart and remove one by one
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
Vaild add two products into cart and remove
  Add products into cart and remove  ${username}  ${password}
  
*** Keywords ***
Login
  [Documentation]  Login
  [Arguments]  ${username}  ${password}
  Wait Until Element Is Visible    xpath=//*[@id="user-name"]
  Input Text    xpath=//*[@id="user-name"]    ${username}
  Input Text    xpath=//*[@id="password"]    ${password}
  Submit Form
  Sleep    2

Add a product into cart and Verify
  [Documentation]  Add a product into cart and Verify by cart's quantity and product's title
  Wait Until Element Is Visible    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]
  Click Element    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]
  Click Element    xpath=//*[@id="add-to-cart-sauce-labs-bike-light"]
  ${homepage_porduct_title_1}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  ${homepage_porduct_title_2}  Get Text    xpath=//*[@id="item_0_title_link"]/div
  ${cart_quantity}  Element Text Should Be    xpath=//*[@id="shopping_cart_container"]/a/span    2
  Click Element    xpath=//*[@id="shopping_cart_container"]
  ${cart_product_title_1}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  ${cart_product_title_2}  Get Text    xpath=//*[@id="item_0_title_link"]/div
  Should Be Equal    ${homepage_porduct_title_1}    ${cart_product_title_1}
  Should Be Equal    ${homepage_porduct_title_2}    ${cart_product_title_2}

Remove prdouct from cart and Verify
  [Documentation]  Remove prdouct from cart and Verify by cart quantity
  Click Element    xpath=//*[@id="remove-sauce-labs-backpack"]
  Click Element    xpath=//*[@id="remove-sauce-labs-bike-light"]
  ${cart_quantity}   Get Text  xpath=//*[@id="shopping_cart_container"]/a
  Should Be Empty    ${cart_quantity}

Add products into cart and remove
  [Documentation]  Add products into cart and remove
  [Arguments]  ${username}  ${password}
  Login    ${username}    ${password}
  Add a product into cart and Verify
  Remove prdouct from cart and Verify
