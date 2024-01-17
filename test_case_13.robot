*** Settings ***
Library  Selenium2Library
Resource  keywords/keywords.robot
Documentation  Vaild add product into cart
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
Vaild add products into cart
  Add products into cart  ${username}  ${password}
  
*** Keywords ***
Add a product into cart and Verify
  [Documentation]  Add a product into cart and Verify by cart's quantity and product's title
  Wait Until Element Is Visible    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]
  Click Element    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]
  ${homepage_porduct_title}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  ${cart_quantity}  Element Text Should Be    xpath=//*[@id="shopping_cart_container"]/a/span    1
  Click Element    xpath=//*[@id="shopping_cart_container"]
  ${cart_product_title}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  Should Be Equal    ${homepage_porduct_title}    ${cart_product_title}


Add products into cart
  [Documentation]  Add products into cart and remove
  [Arguments]  ${username}  ${password}
  Login    ${username}    ${password}
  Add a product into cart and Verify
