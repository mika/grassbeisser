from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

class GroveIo(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "https://grove.io/login/?next=/organizations/ORGA/settings/billing"
        self.verificationErrors = []
    
    def test_grove_io(self):
        driver = self.driver
        driver.get(self.base_url + "/login/?next=/organizations/ORGA/settings/billing")
        driver.find_element_by_name("username").clear()
        driver.find_element_by_name("username").send_keys("USERNAME")
        driver.find_element_by_name("password").clear()
        driver.find_element_by_name("password").send_keys("PASSWORD")
        driver.find_element_by_css_selector("input.send-button").click()
        driver.find_element_by_link_text("Settings").click()
        driver.find_element_by_link_text("Organizations").click()
        driver.find_element_by_link_text("Manage").click()
        driver.find_element_by_link_text("Organization settings").click()
        driver.find_element_by_link_text("exact:Delete this organization?").click()
        driver.find_element_by_id("delete-button").click()
        driver.find_element_by_link_text("exact:Delete your account?").click()
        driver.find_element_by_css_selector("input[type=\"submit\"]").click()
        driver.find_element_by_link_text("Settings").click()
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
