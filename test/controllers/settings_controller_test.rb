require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get group" do
    get settings_group_url
    assert_response :success
  end

end
