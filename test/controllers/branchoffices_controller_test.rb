require "test_helper"

class BranchofficesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get branchoffices_home_url
    assert_response :success
  end
end
