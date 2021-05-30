#!/usr/bin/env robot
*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library           Dialogs
#Suite Teardown    Close Browser


*** Variables ***
${LOGIN URL}      https://netbanking.hdfcbank.com/netbanking/
${BROWSER}        firefox

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Select login Frame
    Input Customer ID
    Input Password
    Select Checkbox  name=chkrsastu
    Submit Credentials
    Unselect Frame
    #Welcome Page Should Be Open

Go to bank statement page
    sleep   3s
    select frame      xpath:/html/frameset/frameset/frame
    ${source} =   Get Source
    log   ${source}
    current frame should contain    Enquire
    click element     xpath://*[@id="enquirytab"]
    click element    xpath://*[@id="SIN_nohref"]/a/span
    unselect frame
    sleep   3s
    Fill in data

Download report
    sleep   5s
    select frame   xpath:/html/frameset/frameset/frameset/frame[1]
    select from list by value   /html/body/form/table[6]/tbody/tr[1]/td[2]/select   C
    click element    xpath:/html/body/form/table[6]/tbody/tr[2]/td/a/img
    unselect frame


*** Keywords ***
Select login frame
    Wait Until Element Is Visible    login_page
    Select Frame    login_page

Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Welcome to HDFC Bank NetBanking

Input Customer ID
    ${customer_id}=  Get Value From User   Enter the customer id   hidden= True
    Input Text     name=fldLoginUserId    ${customer_id}
    Press Keys     fldLoginUserId   RETURN

Input Password
    ${password}=  Get Value From User   Enter the IPIN   hidden= True
    Wait Until Element Is Visible    fldPassword
    Input Text     fldPassword   ${password}

Submit Credentials
    Execute Manual Step    Please complete the CAPTCHA portion of the form.
    Press Keys     fldPassword   RETURN

Fill in data
    select frame           xpath:/html/frameset/frameset/frameset/frame[1]
    select from list by value   name:selAccttype  SCA
    Execute Manual Step    Please select the account
    click element   xpath://*[@id="hideradio"]/span
    Input text      frmDatePicker   01/05/2021
    Input text      toDatePicker    30/05/2021
    select from list by value   name:cmbNbrStmt   40
    click element   xpath:/html/body/form/table[1]/tbody/tr[7]/td/a
    unselect frame


Welcome Page Should Be Open
    Select Frame   class:gbx-installed
    Select Frame   name:common_menu1
    Current frame should contain    SARATH M
    Unselect frame
    Unselect frame
