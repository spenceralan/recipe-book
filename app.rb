require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "./lib/ingredient"
require "./lib/recipe"
require "./lib/tag"
require "pry"

get "/" do
  @recipes = Recipe.all
  @ingredients = Ingredient.all
  @tags = Tag.all
  erb :index
end

get "/recipes/add" do
  erb :recipe_add
end

post "/recipes/add" do
  recipe_name = params['recipe-name']
  recipe_instructions = params['recipe-instructions']
  recipe_rating = params['recipe-rating'].to_i
  new_recipe = Recipe.create({name: recipe_name, instructions: recipe_instructions, rating: recipe_rating})
  redirect "/recipes/#{new_recipe.id}"
end

get '/recipes/:id' do
  recipe_id = params['id']
  @recipe = Recipe.find(recipe_id)
  erb :recipe
end

get '/recipes/:id/edit' do
  recipe_id = params['id']
  @recipe = Recipe.find(recipe_id)
  erb :recipe_edit
end

patch '/recipes' do
  recipe_id = params['recipe-id']
  recipe_name = params['recipe-name']
  recipe_instructions = params['recipe-instructions']
  recipe_rating = params['recipe-rating'].to_i
  recipe = Recipe.find(recipe_id)
  recipe = Recipe.update({name: recipe_name, instructions: recipe_instructions, rating: recipe_rating})
  redirect "/recipes/#{recipe_id}"
end

delete '/recipes' do
  recipe_id = params['recipe-id']
  recipe = Recipe.find(recipe_id)
  recipe.destroy
  redirect '/'
end

get "/ingredients/add" do
  @ingredients = Ingredient.all
  erb :ingredient_add
end

post "/ingredients" do
  ingredient = params.fetch("ingredient-name")
  Ingredient.create({name: ingredient})
  redirect back
end

get "/ingredients/:id" do
  ingredient_id = params.fetch("id")
  @ingredient = Ingredient.find(ingredient_id)
  erb :ingredient_edit
end

patch "/ingredients" do
  ingredient_id = params.fetch("ingredient-id")
  ingredient_name = params.fetch("ingredient-name")
  ingredient = Ingredient.find(ingredient_id)
  ingredient.update({name: ingredient_name})
  redirect "/"
end

delete "/ingredients" do
  ingredient_id = params.fetch("ingredient-id")
  ingredient = Ingredient.find(ingredient_id)
  ingredient.destroy
  redirect "/"
end

get "/tags/add" do
  @tags = Tag.all
  erb :tag_add
end

post "/tags" do
  tag = params.fetch("tag-name")
  Tag.create({name: tag})
  redirect back
end

get "/tags/:id" do
  tag_id = params.fetch("id")
  @tag = Tag.find(tag_id)
  erb :tag_edit
end

patch "/tags" do
  tag_id = params.fetch("tag-id")
  tag_name = params.fetch("tag-name")
  tag = Tag.find(tag_id)
  tag.update({name: tag_name})
  redirect "/"
end

delete "/tags" do
  tag_id = params.fetch("tag-id")
  tag = Tag.find(tag_id)
  tag.destroy
  redirect "/"
end
