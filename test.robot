*** Settings ***
Documentation    test for Infotiv rental website
Library    SeleniumLibrary
Suite Setup    setup

*** Variables ***
${url}    https://rental20.infotiv.net/
${email}    bosse@gmail.com
${password}    bosseisthebest123
${emailInput}    //input[@id='email']
${passwordInput}    //input[@id='password']
${loginButton}    //button[@id='login']
${name}        Bosse
${lastName}    Boss
${phoneNumber}    0758934567



*** Test Cases ***
Create New User
    Input Information    ${name}  ${lastName}  ${phoneNumber}  ${email}  ${password}

Scenario: Log in with valid email and password
    Given  User already exist and is on homepage
    When User Inputs Email '${email}' And Password '${password}'
    Then User Should Be Logged in
Scenario: Log in with invalid email and password
    Given User is on homepage
    When User Inputs Invalid email and password
    Then User Should Not Be Logged In


*** Keywords ***
setup
    [Documentation]    starts the browser, makes the browser fullscreen and goes to infotiv rental website
    [Tags]    setup
    Open Browser    browser=Chrome
    Maximize Browser Window
    Go To    ${url}
    Set Selenium Speed    1

User already exist and is on homepage
    [Documentation]    checks if user is on homepage
    [Tags]    LogIn
    Page Should Contain Element    //button[@id='continue']

User Inputs email '${email}' and password '${password}'
    [Documentation]    logs in to the website
    [Tags]    LogIn
    Input Text    ${emailInput}    ${email}
    Input Password    ${passwordInput}    ${password}
    Click Button    ${loginButton}

User Should Be Logged In
    [Documentation]    checks if logout button is visible
    [Tags]    LogIn
    Page Should Contain Button        //button[@id='logout']
    
User Inputs Invalid email and password
    [Documentation]    logs in with wrong email and password
    [Tags]    LogIn
    Input Text    ${emailInput}    fel@gmail.com
    Input Password    ${passwordInput}    12345678
    Click Button    ${loginButton}

User is on homepage
    [Documentation]    checks if user is on homepage
    [Tags]    LogIn
    Page Should Contain Element    //button[@id='continue']

User Should Not Be Logged In
    [Documentation]    checks if wrong password popup appears
    [Tags]    LogIn
    Page Should Contain Element    //label[@id='signInError']

Input Information
    [Documentation]    test creating existing user in DDT format
    [Tags]    createUserDDT
    Click Button    //button[@id='createUser']
    [Arguments]    ${firstname}  ${surname}  ${number}  ${email}  ${password}
    Input Text        //input[@id='name']    ${firstname}
    Input Text    //input[@id='last']    ${surname}
    Input Text    //input[@id='phone']   ${number}
    Input Text    //input[@id='emailCreate']  ${email}
    Input Text   //input[@id='confirmEmail']  ${email}
    Input Text    //input[@id='passwordCreate']  ${password}
    Input Text    //input[@id='confirmPassword']    ${password}

    Page Should Contain Element    //label[@id='signInError']
    
