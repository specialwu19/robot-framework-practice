*** Settings ***
Library  Selenium2Library
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
Login
  [Documentation]  Login
  [Arguments]  ${username}  ${password}
  Wait Until Element Is Visible    xpath=//*[@id="user-name"]
  Input Text    xpath=//*[@id="user-name"]    ${username}
  Input Text    xpath=//*[@id="password"]    ${password}
  Submit Form
  Sleep    2

Scrolling page
  [Documentation]  Scrolling home page
  [Arguments]  ${x_coordinate}  ${y_coordinate}
  Execute JavaScript    window.scrollTo(${x_coordinate}, ${y_coordinate});
  Sleep    0.5

Go into product's own page and Product Verify
  [Documentation]  Go into product's own page by click title and check the prdouct titles are equal
  Wait Until Element Is Visible    xpath=//*[@id="item_4_title_link"]
  ${homepage_porduct_title}   Get Text    xpath=//*[@id="item_4_title_link"]
  Click Element    xpath=//*[@id="item_4_title_link"]
  sleep  0.5
  ${ownpage_product_title}  Get Text    xpath=//*[@id="inventory_item_container"]/div/div/div[2]/div[1]
  Should Be Equal    ${homepage_porduct_title}    ${ownpage_product_title}
  
Browse product
  [Documentation]  Browse product
  [Arguments]  ${username}  ${password}
  Login  ${username}  ${password}
  Scrolling page  0    document.body.scrollHeight
  Scrolling page  0    0
  Go into product's own page and Product Verify