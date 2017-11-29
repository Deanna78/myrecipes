require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com",
                        password: "password", password_confirmation: "password")
  end

  test "reject invalid update" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: " ", email: "deanna@example.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully update a chef" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    # updated_chefname = "Deanna1"
    # updated_email = "deanna1@example.com"
    # patch chef_path(@chef), params: { chef: { chefname: updated_chefname, email: updated_email } }
    patch chef_path(@chef), params: { chef: { chefname: "Deanna1", email: "deanna1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    # assert_match updated_chefname, @chef.chefname
    # assert_match updated_email, @chef.email
    assert_match "Deanna1", @chef.chefname
    assert_match "deanna1@example.com", @chef.email
  end





end
