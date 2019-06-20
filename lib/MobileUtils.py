from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

class MobileUtils:
    def open_emulated_mobile_browser(self, device):
        seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
        mobile_emulation = { "deviceName": device }
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_experimental_option("mobileEmulation", mobile_emulation)
        driver = webdriver.Chrome(desired_capabilities = chrome_options.to_capabilities())
        return seleniumlib._cache.register(driver, "Remote")