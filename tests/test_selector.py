from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys


driver = webdriver.Firefox(
    executable_path="./node_modules/geckodriver/bin/geckodriver")
driver.get("https://netbanking.hdfcbank.com/netbanking/")


def test_selector():
    # driver.maximize_window()
    driver.switch_to_frame("login_page")
    try:
        inputElement = driver.find_element_by_name("fldLoginUserId")
        inputElement.send_keys("<user_id>")
        inputElement.send_keys(Keys.ENTER)
    except NoSuchElementException as e:
        print(e)
    # driver.quit()
