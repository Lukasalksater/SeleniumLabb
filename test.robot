*** Settings ***
Documentation    test for Infotiv rental website
Library    SeleniumLibrary
Suite Setup    setup
Resource    Resources.robot



*** Test Cases ***
Create Existing User
    Input Information    ${name}  ${lastName}  ${phoneNumber}  ${email}  ${password}

Scenario: Log in with valid email and password
    Given User Already Exist And Is On Homepage
    When User Inputs Email '${email}' And Password '${password}'
    Then User Should Be Logged In
Scenario: Log in with invalid email and password
    Given User is on homepage
    When User Inputs Invalid email and password
    Then User Should Not Be Logged In
Scenario: Renting a car
    Given User Is Logged In And On Homepage
    When User Chooses Date And Clicks On Continue
    And User Chooses A Car And Inputs Information
    Then User Should Have A Car Booked
Scenario: Filtering Cars While Booking
    Given User Is On Homepage
    When User Chooses Date And Clicks On Continue
    And User Chooses A Filter
    Then A car should appear
Scenario: Unbooking A Car (Only works if you run renting a car first)
    Given User Is Logged In And On Homepage
    And User Has Booked A Car
    When User Clicks On Cancel Booking
    Then Users Car Booking Should Be Cancelled





