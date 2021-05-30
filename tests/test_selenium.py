from selenium import webdriver


def test_selenium():
    browser = webdriver.Firefox(
        executable_path="./node_modules/geckodriver/bin/geckodriver")
    browser.get('https://google.com')
    browser.quit()
