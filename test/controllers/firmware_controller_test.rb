require "test_helper"

class FirmwareControllerTest < ActionDispatch::IntegrationTest
  test "should get download" do
    get firmware_download_url
    assert_response :success
  end
end
