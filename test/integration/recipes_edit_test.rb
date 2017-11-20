require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

def setup
  @chef = Chef.create!(chefname: "Deanna", email: "deanna@example.com")
  @recipe = @chef.recipes.create(name: "soup", description: "cook meat and veg")
end

test "reject invalid recipe update" do
  get edit_recipe_path(@recipe)
  assert_template 'recipes/edit'
  patch recipe_path(@recipe), params: {recipe: {name: " ", description: "some description"} }
  assert_template 'recipes/edit'
  assert_select 'h2.panel-title'
  assert_select 'div.panel-body'
end

test "successfully update a recipe" do
  get edit_recipe_path(@recipe)
  assert_template 'recipes/edit'
  updated_name = "updated recipe name"
  updated_description = "updated recipe description"
  patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description } }
  assert_redirected_to @recipe
  #follow_redirect!
  assert_not flash.empty?
  @recipe.reload
  assert_match updated_name, @recipe.name
  assert_match updated_description, @recipe.description
end

test "successfully delete a recipe" do
  get recipe_path(@recipe)
  assert_template 'recipes/show'
  assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete Recipe"
  assert_difference 'Recipe.count', -1 do
    delete recipe_path(@recipe)
  end
  assert_redirected_to recipes_path
  assert_not flash.empty?
end






end
