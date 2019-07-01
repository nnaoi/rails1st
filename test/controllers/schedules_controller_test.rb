require 'test_helper'

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get schedules_top_url
    assert_response :success
  end

end
