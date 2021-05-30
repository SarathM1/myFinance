#!/usr/bin/env robot
*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library           Dialogs
Library           DateTime
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
    click element    css:.formtable > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(1) > a:nth-child(1) > img:nth-child(1)
    unselect frame


*** Keywords ***
get date range
    ${cur_date} =   Get Current Date   result_format=datetime
    ${first day} =  set variable   01/${cur_date.month}/${cur_date.year}
    ${last day} =   set variable   ${cur_date.day}/${cur_date.month}/${cur_date.year}
    ${last day} =   Convert Date   ${last day}    date_format=%d/%m/%Y     result_format=%d/%m/%Y
    ${first day} =   Convert Date   ${first day}    date_format=%d/%m/%Y   result_format=%d/%m/%Y
    [return]   ${first day}   ${last day}



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
    ${first day}   ${last day} =   get date range
    Input text      frmDatePicker   ${first day}
    Input text      toDatePicker    ${last day}
    select from list by value   name:cmbNbrStmt   10
    click element   xpath:/html/body/form/table[1]/tbody/tr[7]/td/a
    unselect frame

Welcome Page Should Be Open
    Select Frame   xpath:/html/frameset/frame
    Current frame should contain    SARATH M
    Unselect frame
