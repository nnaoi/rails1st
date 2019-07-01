require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get members" do
    get groups_members_url
    assert_response :success
  end

end
