require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

def setup
  @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com")
  @recipe = @chef.recipes.create(name: "soup", description: "cook meat and veg")
  @recipe2 = @chef.recipes.build(name: "pork ribs", description: "marinade ribs and then fry")
  @recipe2.save
  @recipe3 = @chef.recipes.create(name: "fish soup", description: "boil fish with veg stock")
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
  # assert_match @recipe.name, response.body
  assert_match @recipe.description, response.body
  assert_match @chef.chefname, response.body
end

test "create new valid recipe" do
  get new_recipe_path
  assert_template 'recipes/new'
  name_of_recipe = "potjie"
  description_of_recipe = "brown meat, add veggies, cook slowly over coals, add beer or wine as needed"
  assert_difference 'Recipe.count', 1 do
    post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_recipe }}
  end
  follow_redirect!
  assert_match name_of_recipe.capitalize, response.body
  assert_match description_of_recipe, response.body
end


test "reject invalid recipe submission" do
  get new_recipe_path
  assert_template 'recipes/new'
  assert_no_difference 'Recipe.count' do
    post recipes_path, params: {recipe: {name: " ", description: " "} }
  end
  assert_template 'recipes/new'
  assert_select 'h2.panel-title'
  assert_select 'div.panel-body'
end






end