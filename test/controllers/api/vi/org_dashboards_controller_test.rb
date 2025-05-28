require "test_helper"

class Api::V1::OrgDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_vi_org_dashboards_show_url
    assert_response :success
  end
end
