require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com",
                        password: "password", password_confirmation: "password")
    @chef1 = Chef.create!(chefname: "Max", email: "max@example.com",
                        password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "John", email: "john@example.com",
                                            password: "password", password_confirmation: "password", admin: true)
  end

  test "should show chefs index page" do
    get chefs_path
    assert_response :success
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname
    assert_select "a[href=?]", chef_path(@chef1), text: @chef1.chefname
  end

  test "should delete a chef" do
    sign_in_as(@admin_user, "password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef1)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

end
