require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com",
                        password: "password", password_confirmation: "password")
    @chef1 = Chef.create!(chefname: "Max", email: "max@example.com",
                        password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "John", email: "john@example.com",
                                            password: "password", password_confirmation: "password", admin: true)
  end

  test "reject invalid update" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: " ", email: "deanna@example.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully update/edit a chef" do
    sign_in_as(@chef, "password")
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

  test "accept edit attempt by admin" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Sue", email: "sue@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Sue", @chef.chefname
    assert_match "sue@example.com", @chef.email
  end

  test "accept edit attempt by non-admin" do
    sign_in_as(@chef1, "password")
    updated_name = "Joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Deanna", @chef.chefname
    assert_match "deanna@example.com", @chef.email
  end


end
