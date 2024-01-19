*** Settings ***
Library  Selenium2Library
Resource  keywords/keywords.robot
Documentation  Vaild add product into cart by its own page and remove
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
Vaild add products into cart and remove
  Add products into cart and remove  ${username}  ${password}
  
*** Keywords ***
Remove prdouct from cart and Verify
  [Documentation]  Remove prdouct by its own page and Verify with cart quantity
  Click Element    xpath=//*[@id="continue-shopping"]
  Click Element    xpath=//*[@id="item_4_img_link"]/img
  Click Element    xpath=//*[@id="remove-sauce-labs-backpack"]
  ${cart_quantity}   Get Text  xpath=//*[@id="shopping_cart_container"]/a
  Should Be Empty    ${cart_quantity}

Add products into cart and remove
  [Documentation]  Add products into cart and remove
  [Arguments]  ${username}  ${password}
  Login    ${username}    ${password}
  Add a product into cart and Verify  //*[@id="add-to-cart-sauce-labs-backpack"]  //*[@id="item_4_title_link"]/div  1  //*[@id="item_4_title_link"]/div
  Remove prdouct from cart and Verify
