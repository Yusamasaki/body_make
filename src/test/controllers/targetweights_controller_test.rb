require 'test_helper'

class TargetweightsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get targetweights_new_url
    assert_response :success
  end

end
