*** Settings ***
Library  Selenium2Library
Library    String
Resource  keywords/keywords.robot
Documentation  Vaild checkout
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce
${first_name}  Janice
${last_name}  Wu
${postal_code}  412

*** Test Cases ***
Vaild checkout
  Add product into cart and checkout  ${username}  ${password}  ${first_name}  ${last_name}  ${postal_code}
  
*** Keywords ***
Checkout complete and Verify
  [Documentation]  Checkout complete and Verify
  Wait Until Element Is Visible    xpath=//*[@id="item_4_title_link"]/div
  Element Text Should Be    xpath=//*[@id="item_4_title_link"]/div    Sauce Labs Backpack
  ${product_price}  Get price and Convert to number    //*[@id="checkout_summary_container"]/div/div[1]/div[3]/div[2]/div[2]/div
  ${item_price}  Get price and Convert to number    //*[@id="checkout_summary_container"]/div/div[2]/div[6]
  ${tax_price}  Get price and Convert to number    //*[@id="checkout_summary_container"]/div/div[2]/div[7]
  ${total_price}  Get price and Convert to number    //*[@id="checkout_summary_container"]/div/div[2]/div[8]
  ${checkout_price}  Evaluate    ${item_price}+${tax_price}
  Click Element    xpath=//*[@id="finish"]
  Element Text Should Be    xpath=//*[@id="checkout_complete_container"]/h2    Thank you for your order!
  Should Be Equal    ${product_price}    ${item_price}
  Should Be Equal As Numbers    ${total_price}    ${checkout_price}  Tolerance=0.01

Add product into cart and checkout
  [Documentation]  Add product into cart and checkout complete
  [Arguments]  ${username}  ${password}  ${first_name}  ${last_name}  ${postal_code}
  Login    ${username}    ${password}
  Add a product into cart and Verify  //*[@id="add-to-cart-sauce-labs-backpack"]  //*[@id="item_4_title_link"]/div  1  //*[@id="item_4_title_link"]/div
  Checkout  ${first_name}  ${last_name}  ${postal_code}
  Checkout complete and Verify
