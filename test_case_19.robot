*** Settings ***
Library  Selenium2Library
Library    String
Documentation  Invaild checkout without input information
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
Invaild checkout without input information
  Add product into cart and checkout  ${username}  ${password}  
  
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

Checkout and Get error warning
  [Documentation]  Checkout step by step without input information
  Click Element    xpath=//*[@id="checkout"]
  Wait Until Element Is Visible    xpath=//*[@id="first-name"]
  Submit Form
  Element Text Should Be    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3    Error: First Name is required

Add product into cart and checkout
  [Documentation]  Add product into cart and checkout without input information 
  [Arguments]  ${username}  ${password}  
  Login    ${username}    ${password}
  Add a product into cart and Verify
  Checkout and Get error warning  