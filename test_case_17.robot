*** Settings ***
Library  Selenium2Library
Library    String
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
  ${homepage_porduct_title}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  ${cart_quantity}  Element Text Should Be    xpath=//*[@id="shopping_cart_container"]/a/span    1
  Click Element    xpath=//*[@id="shopping_cart_container"]
  ${cart_product_title}  Get Text    xpath=//*[@id="item_4_title_link"]/div
  Should Be Equal    ${homepage_porduct_title}    ${cart_product_title}

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

Checkout complete and Verify
  [Documentation]  Checkout complete and Verify
  Wait Until Element Is Visible    xpath=//*[@id="item_4_title_link"]/div
  Element Text Should Be    xpath=//*[@id="item_4_title_link"]/div    Sauce Labs Backpack
  ${product_price}  Get Text    xpath=//*[@id="checkout_summary_container"]/div/div[1]/div[3]/div[2]/div[2]/div
  ${product_price}  Get Substring    ${product_price}    1  6  
  ${product_price}  Convert To Number    ${product_price}

  ${item_price}  Get Text    xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[6]
  ${item_price}  Get Substring    ${item_price}    13  18
  ${item_price}  Convert To Number    ${item_price}

  ${tax_price}  Get Text    xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[7]
  ${tax_price}  Get Substring    ${tax_price}    6  10
  ${tax_price}  Convert To Number    ${tax_price}

  ${total_price}  Get Text    xpath=//*[@id="checkout_summary_container"]/div/div[2]/div[8]
  ${total_price}  Get Substring    ${total_price}    8  13
  ${total_price}  Convert To Number    ${total_price}

  ${checkout_price}  Evaluate    ${item_price}+${tax_price}

  Click Element    xpath=//*[@id="finish"]
  Element Text Should Be    xpath=//*[@id="checkout_complete_container"]/h2    Thank you for your order!
  Should Be Equal    ${product_price}    ${item_price}
  Should Be Equal As Numbers    ${total_price}    ${checkout_price}  Tolerance=0.01




Add product into cart and checkout
  [Documentation]  Add product into cart and checkout complete
  [Arguments]  ${username}  ${password}  ${first_name}  ${last_name}  ${postal_code}
  Login    ${username}    ${password}
  Add a product into cart and Verify
  Checkout  ${first_name}  ${last_name}  ${postal_code}
  Checkout complete and Verify
