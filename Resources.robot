



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
${cardNumber}    5678901234565678
${cardCVC}    678
@{expectedList}    //img[@src='/webpage/img/modelX.png']    //img[@src='/webpage/img/passengerIcon.png']    //td[normalize-space()='Model X']    //td[normalize-space()='Tesla']


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
    [Tags]    createExistingUserDDT
    Click Button    //button[@id='createUser']
    [Arguments]    ${firstname}  ${surname}  ${number}  ${email}  ${password}
    Input Text        //input[@id='name']    ${firstname}
    Input Text    //input[@id='last']    ${surname}
    Input Text    //input[@id='phone']   ${number}
    Input Text    //input[@id='emailCreate']  ${email}
    Input Text   //input[@id='confirmEmail']  ${email}
    Input Text    //input[@id='passwordCreate']  ${password}
    Input Text    //input[@id='confirmPassword']    ${password}
    Click Button  //button[@id='create']


    Page Should Contain Element    //label[@id='signInError']

User Is Logged In And On Homepage
    [Documentation]    logs in to website
    [Tags]    vg_test
    Input Text    ${emailInput}    ${email}
    Input Password    ${passwordInput}    ${password}
    Click Button    ${loginButton}
    Page Should Contain Element    //button[@id='mypage']

User Chooses Date And Clicks On Continue

    [Documentation]    chooses the current date
    [Tags]    VG_test

    Click Button    //button[@id='reset']
    Click Button    //button[@id='continue']
    Page Should Contain Element    //button[@id='backToDateButton']

User Chooses A Car And Inputs Information
    [Documentation]    User chooses a car without any requirments and clicks book and inputs information and click continue
    [Tags]    VG_test
    Click Button    //tbody/tr[13]/td[5]/form[1]/input[4]
    Input Text    //input[@id='cardNum']    ${cardNumber}
    Input Text    //input[@id='fullName']    ${name}

    Select From List By Label    //select[@title='Year']    2025

    Input Text    //input[@id='cvc']    ${cardCVC}
    Click Button    //button[@id='confirm']

User Should Have A Car Booked
    [Documentation]    Checks if the car with correct license number is booked
    [Tags]    VG_test
    Page Should Contain Element      //h1[@id='questionTextSmall']
    Click Button    //div[@id='backToStart']//button[@id='mypage']
    Page Should Contain Element    //td[@id='licenseNumber1']

User Chooses A Filter

    [Documentation]    chooses a filter option
    [Tags]    filterTest
   Click Element        //span[normalize-space()='Passengers']
   Click Element       //label[@for='ms-opt-6']
   Click Element        //div[@id='ms-list-1']//button[@type='button']
   Click Element        //label[@for='ms-opt-3']

A car should appear

    [Documentation]    checks if the correct car is shown
    [Tags]    filterTest
   ${elements}  Get Webelements    css:.card-title
   Run Keyword And Return Status    Should Contain  ${elements}    ${expectedList}

User Has Booked A Car
    [Documentation]    Checks if user has booked a car
    Click Button    //button[@id='mypage']
    Page Should Contain Element    //button[@id='unBook1']

User Clicks On Cancel Booking
    [Documentation]    Cancels the cars booking
    Click Button    //button[@id='unBook1']
    Handle Alert


Users Car Booking Should Be Cancelled

    Page Should Not Contain Element    //td[@id='licenseNumber1']

