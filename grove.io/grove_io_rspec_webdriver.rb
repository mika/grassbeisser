require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "GroveIo" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://grove.io/login/?next=/organizations/ORGA/settings/billing"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_grove_io" do
    @driver.get(@base_url + "/login/?next=/organizations/ORGA/settings/billing")
    @driver.find_element(:name, "username").clear
    @driver.find_element(:name, "username").send_keys "USERNAME"
    @driver.find_element(:name, "password").clear
    @driver.find_element(:name, "password").send_keys "PASSWORD"
    @driver.find_element(:css, "input.send-button").click
    @driver.find_element(:link, "Settings").click
    @driver.find_element(:link, "Organizations").click
    @driver.find_element(:link, "Manage").click
    @driver.find_element(:link, "Organization settings").click
    @driver.find_element(:link, "exact:Delete this organization?").click
    @driver.find_element(:id, "delete-button").click
    @driver.find_element(:link, "exact:Delete your account?").click
    @driver.find_element(:css, "input[type=\"submit\"]").click
    @driver.find_element(:link, "Settings").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
end
