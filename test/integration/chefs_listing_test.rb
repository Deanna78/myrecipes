require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com",
                        password: "password", password_confirmation: "password")
    @chef1 = Chef.create!(chefname: "Deanna1", email: "deanna1@example.com",
                        password: "password", password_confirmation: "password")
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


end
