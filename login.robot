*** Settings ***
Documentation    Test suite for OrangeHRM login functionality
Library          SeleniumLibrary
Suite Setup      Open Browser To Login Page
Suite Teardown   Close Browser
Test Setup       Go To Login Page

*** Variables ***
${URL}           https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}       Chrome
${VALID_USER}    Admin
${VALID_PASS}    admin123
${INVALID_USER}  WrongUser
${INVALID_PASS}  wrongpass

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    name=username    30s

Go To Login Page
    Go To    ${URL}
    Wait Until Page Contains Element    name=username    30s
    Wait Until Element Is Visible    name=username    30s

Input Credentials
    [Arguments]    ${username}    ${password}
    Input Text    name=username    ${username}
    Input Text    name=password    ${password}
    Click Button    css=button[type='submit']

*** Test Cases ***
Valid Login
    Input Credentials    ${VALID_USER}    ${VALID_PASS}
    Wait Until Element Is Visible    css=.oxd-topbar-header-title    30s
    Element Text Should Be    css=.oxd-topbar-header-title    Dashboard

Invalid Login
    Input Credentials    ${INVALID_USER}    ${INVALID_PASS}
    Wait Until Element Is Visible    css=.oxd-alert-content-text    30s
    Element Text Should Be    css=.oxd-alert-content-text    Invalid credentials