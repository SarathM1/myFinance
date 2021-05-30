#!/usr/bin/env python
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from sensitive_data import bank_url, customer_id
from selenium.common.exceptions import NoSuchElementException
import sys

# create firefox webdriver and WebDriverWait
browser = webdriver.Firefox()
wait = WebDriverWait(browser, 10)

timeout = 3
client_id_selector = 'input_password'


def login(user_argument, password_argument):
    # navigate to page
    browser.get(bank_url)

    import time
    time.sleep(timeout)

    try:
        cid_selector = browser.find_element_by_name('fldLoginUserId')
        cid_selector.send_keys(user_argument)
    except NoSuchElementException as e:
        print(e)
        browser.quit()

    # locate and click the login button
    # login_page_button = browser.find_element_by_xpath(login_page_selector)
    # if not found(browser, login_page_button, "button to reach login"):
    # return
    # login_page_button.click()

    # select elements of login form, fill them out and submit form,
    # user provided arguments used to authenticate
    # username = wait.until(EC.element_to_be_clickable((By.ID, user_id)))
    # password = wait.until(EC.element_to_be_clickable((By.ID, password_id)))
    # if not found(browser, username, "username"):
    # return
    # if not found(browser, password, "password"):
    # return

    # send credentials to form and submit
    # username.send_keys(user_argument)
    # password.send_keys(password_argument)
    # login_submit_button = browser.find_element_by_xpath(login_form_selector)
    # if not found(browser, login_submit_button, "button to submit login form"):
    # return
    # login_submit_button.click()
    # filter_transactions()


def main():
    """TODO: Docstring for main.
    :returns: TODO

    """
    user_argument = customer_id
    pwd_argument = ''
    login(user_argument, pwd_argument)


if __name__ == '__main__':
    main()
