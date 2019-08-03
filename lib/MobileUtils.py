from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

class MobileUtils:
    def get_emulated_mobile_capabilities(self, device):
        mobile_emulation = { "deviceName": device }
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_experimental_option("mobileEmulation", mobile_emulation)

        return chrome_options.to_capabilities()