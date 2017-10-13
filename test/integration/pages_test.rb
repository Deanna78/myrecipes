require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest

  test "Should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

end

# test "the truth" do
#   assert true
# end
