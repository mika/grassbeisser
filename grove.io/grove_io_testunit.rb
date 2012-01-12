require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"

class grove.io < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "https://grove.io/login/?next=/organizations/ORGA/settings/billing",
      :timeout_in_second => 60

    @selenium.start_new_browser_session
  end
  
  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
  
  def test_grove.io
    @selenium.open "/login/?next=/organizations/ORGA/settings/billing"
    @selenium.type "name=username", "USERNAME"
    @selenium.type "name=password", "PASSWORD"
    @selenium.click "css=input.send-button"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=Settings"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=Organizations"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=Manage"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=Organization settings"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=exact:Delete this organization?"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "id=delete-button"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=exact:Delete your account?"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "css=input[type=\"submit\"]"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=Settings"
    @selenium.wait_for_page_to_load "30000"
  end
end
