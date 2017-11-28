require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com",
                        password: "password", password_confirmation: "password")
  end

  test "reject invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "deanna@dnarix.com"  } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid signup" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Deanna1 ", email: "deanna1@dnarix.com"  } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Deanna1", @chef.chefname
    assert_match "deanna1@dnarix.com", @chef.email
  end



end
