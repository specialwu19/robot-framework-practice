*** Settings ***
Library  Selenium2Library
Library    String
Resource  keywords/keywords.robot
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
  Add a product into cart and Verify  //*[@id="add-to-cart-sauce-labs-backpack"]  //*[@id="item_4_title_link"]/div  1  //*[@id="item_4_title_link"]/div
  Checkout and Get error warning  