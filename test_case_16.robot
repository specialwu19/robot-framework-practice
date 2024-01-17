*** Settings ***
Library  Selenium2Library
Resource  keywords/keywords.robot
Documentation  Vaild add products into cart and remove by its own page
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
Vaild add products into cart and remove
  Add products into cart and remove  ${username}  ${password}

*** Keywords ***
Add two product into cart and Verify
  [Documentation]  Add two product into cart by its own page and Verify by cart's quantity and product's title
  Wait Until Element Is Visible    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]
  Click Element    xpath=//*[@id="item_4_title_link"]/div
  Click Element    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]
  ${porduct_title_1}  Get Text    xpath=//*[@id="inventory_item_container"]/div/div/div[2]/div[1]
  Click Element    xpath=//*[@id="back-to-products"]
  Click Element    xpath=//*[@id="item_0_title_link"]/div
  Click Element    xpath=//*[@id="add-to-cart-sauce-labs-bike-light"]
  ${porduct_title_2}  Get Text    xpath=//*[@id="inventory_item_container"]/div/div/div[2]/div[1]
  ${cart_quantity}  Element Text Should Be    xpath=//*[@id="shopping_cart_container"]/a/span    2
  Click Element    xpath=//*[@id="shopping_cart_container"]
  ${cart_product_title_1}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  ${cart_product_title_2}  Get Text    xpath=//*[@id="item_0_title_link"]/div
  Should Be Equal    ${porduct_title_1}    ${cart_product_title_1}
  Should Be Equal    ${porduct_title_2}    ${cart_product_title_2}

Remove prdoucts from cart and Verify
  [Documentation]  Remove all prdoucts by its own page and Verify with cart quantity
  Click Element    xpath=//*[@id="continue-shopping"]
  Click Element    xpath=//*[@id="item_4_img_link"]/img
  Click Element    xpath=//*[@id="remove-sauce-labs-backpack"]
  Click Element    xpath=//*[@id="back-to-products"]
  Click Element    xpath=//*[@id="item_0_img_link"]/img
  Click Element    xpath=//*[@id="remove-sauce-labs-bike-light"]
  ${cart_quantity}   Get Text  xpath=//*[@id="shopping_cart_container"]/a
  Should Be Empty    ${cart_quantity}

Add products into cart and remove
  [Documentation]  Add products into cart and remove
  [Arguments]  ${username}  ${password}
  Login    ${username}    ${password}
  Add two product into cart and Verify
  Remove prdoucts from cart and Verify
