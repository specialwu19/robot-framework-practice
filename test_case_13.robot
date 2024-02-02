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
Add products into cart
  [Documentation]  Add products into cart and remove
  [Arguments]  ${username}  ${password}
  Login    ${username}    ${password}
  Add a product into cart and Verify  //*[@id="add-to-cart-sauce-labs-backpack"]  //*[@id="item_4_title_link"]/div  1  //*[@id="item_4_title_link"]/div

