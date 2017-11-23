require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest

def setup

end

test "should get signup path" do
  get signup_path
  assert_response :success
end





end
