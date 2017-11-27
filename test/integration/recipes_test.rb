require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

def setup
  @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com",
                    password: "password", password_confirmation: "password")
  @recipe = Recipe.create(name: "Soup", description: "cook meat and veg", chef: @chef, group: "Mains")
  @recipe2 = @chef.recipes.build(name: "Pork Ribs", description: "marinade ribs and then fry", group: "Mains")
  @recipe2.save
  @recipe3 = @chef.recipes.create(name: "Fish Soup", description: "boil fish with veg stock", group: "Mains")


#  @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
#                      password: "password", password_confirmation: "password")
#  @recipe = Recipe.create(name: "vegetable saute", description: "great vegetable sautee", chef: @chef)
#  @recipe2 = @chef.recipes.build(name: "chicken saute",
#                        description: "great chicken dish")
#  @recipe2.save
end


  test "should show recipes index page" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_select "a[href=?]", recipe_path(@recipe3), text: @recipe3.name
  end

  test "recipe name failure" do
        get recipes_path
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
    assert_match @recipe3.name, response.body
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    #assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    assert_match @recipe.group, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit Recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete Recipe"
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "potjie"
    description_of_recipe = "brown meat, add veggies, cook slowly over coals, add beer or wine as needed"
    group_of_recipe = "Mains"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_recipe, group: group_of_recipe }}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end


  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ", description: " ", group: " "} }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end


end
