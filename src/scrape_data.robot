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
    Execute Manual Step    Please enter the customer id and hit coninue
    Select login Frame
    Select Checkbox  name=chkrsastu
    Unselect Frame
    Execute Manual Step    Please enter your credentials and login
    Welcome Page Should Be Open

Go to bank statement page
    sleep   3s
    select frame      xpath:/html/frameset/frameset/frame
    current frame should contain    Enquire
    click element     xpath://*[@id="enquirytab"]
    click element    xpath://*[@id="SIN_nohref"]/a/span
    unselect frame
    sleep   3s
    Fill in data

Download report
    sleep   3s
    select frame   xpath:/html/frameset/frameset/frameset/frame[1]
    #${source} =   Get Source
    #log   ${source}
    select from list by value   name=fldFormatType   C
    click element    xpath:/html/body/form/table[10]/tbody/tr[2]/td/a/img
    unselect frame


*** Keywords ***
Select login frame
    Wait Until Element Is Visible    login_page
    Select Frame    login_page

Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Welcome to HDFC Bank NetBanking

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
    select from list by value   name:cmbNbrStmt   10
    click element   xpath:/html/body/form/table[1]/tbody/tr[7]/td/a
    unselect frame

Welcome Page Should Be Open
    Select Frame   xpath:/html/frameset/frame
    Current frame should contain    SARATH M
    Unselect frame
