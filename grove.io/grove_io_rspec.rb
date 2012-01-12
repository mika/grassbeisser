require "rubygems"
gem "rspec"
gem "selenium-client"
require "selenium/client"
require "selenium/rspec/spec_helper"
require "spec/test/unit"

describe "grove.io" do
  attr_reader :selenium_driver
  alias :page :selenium_driver

  before(:all) do
    @verification_errors = []
    @selenium_driver = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "https://grove.io/login/?next=/organizations/ORGA/settings/billing",
      :timeout_in_second => 60
  end

  before(:each) do
    @selenium_driver.start_new_browser_session
  end
  
  append_after(:each) do
    @selenium_driver.close_current_browser_session
    @verification_errors.should == []
  end
  
  it "test_grove.io" do
    page.open "/login/?next=/organizations/ORGA/settings/billing"
    page.type "name=username", "USERNAME"
    page.type "name=password", "PASSWORD"
    page.click "css=input.send-button"
    page.wait_for_page_to_load "30000"
    page.click "link=Settings"
    page.wait_for_page_to_load "30000"
    page.click "link=Organizations"
    page.wait_for_page_to_load "30000"
    page.click "link=Manage"
    page.wait_for_page_to_load "30000"
    page.click "link=Organization settings"
    page.wait_for_page_to_load "30000"
    page.click "link=exact:Delete this organization?"
    page.wait_for_page_to_load "30000"
    page.click "id=delete-button"
    page.wait_for_page_to_load "30000"
    page.click "link=exact:Delete your account?"
    page.wait_for_page_to_load "30000"
    page.click "css=input[type=\"submit\"]"
    page.wait_for_page_to_load "30000"
    page.click "link=Settings"
    page.wait_for_page_to_load "30000"
  end
end
