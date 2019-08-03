from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

class DesktopUtils:
    def open_desktop_browser(self, browser):
        seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
        if browser == "chrome":
            chrome_options = webdriver.ChromeOptions()
            chrome_options.add_argument("--headless")
            driver = webdriver.Chrome(desired_capabilities = chrome_options.to_capabilities())
            return seleniumlib._cache.register(driver, "Remote")
        else:
            return None