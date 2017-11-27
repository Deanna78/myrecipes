require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com",
                      password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Soup", description: "cook meat and veg", chef: @chef, group: "Mains")
    @recipe2 = @chef.recipes.build(name: "Pork Ribs", description: "marinade ribs and then fry", group: "Mains")
    @recipe2.save
    @recipe3 = @chef.recipes.create(name: "Fish Soup", description: "boil fish with veg stock", group: "Mains")


    # @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
    #                     password: "password", password_confirmation: "password")
    # @recipe = Recipe.create(name: "vegetable saute", description: "great vegetable sautee", chef: @chef)
    # @recipe2 = @chef.recipes.build(name: "chicken saute",
    #                       description: "great chicken dish")
    # @recipe2.save

  end


   test "should get chefs show" do
     get chef_path(@chef)
     assert_template 'chefs/show'
     assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
     assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
     assert_match @recipe.description, response.body
     assert_match @recipe2.description, response.body
     assert_match @chef.chefname, response.body
   end



end
