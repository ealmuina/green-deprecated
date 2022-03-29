require "test_helper"

class NodesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get nodes_new_url
    assert_response :success
  end
end
