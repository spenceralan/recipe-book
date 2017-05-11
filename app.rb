require "bundler/setup"
require "pry"
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

helpers do

  def simple_format(text)
    text.gsub("\n", "<br>")
  end

  def capture_boxes(recipe)
    params.fetch("ingredients", []).each do |ingredient|
      recipe.ingredients.push(Ingredient.find(ingredient['id']))
    end
    params.fetch("tags", []).each do |tag|
      recipe.tags.push(Tag.find(tag['id']))
    end
  end

end

get "/" do
  @recipes = Recipe.all
  @ingredients = Ingredient.all
  @tags = Tag.all
  erb :index
end

get "/search" do
  @search = params['search']
  @results = Recipe.where("upper(name) like ?", "%#{@search.upcase}%")
  erb :search
end

get "/search/sort-az" do
  @search = params['search']
  results = Recipe.where("upper(name) like ?", "%#{@search.upcase}%")
  @results = results.sort{ |recipe1, recipe2| recipe1.name.downcase <=> recipe2.name.downcase }
  erb :search
end

get "/search/sort-rating" do
  @search = params['search']
  results = Recipe.where("upper(name) like ?", "%#{@search.upcase}%")
  @results = results.sort{ |recipe1, recipe2| recipe2.rating <=> recipe1.rating }
  erb :search
end

get "/recipes/add" do
  @recipes = Recipe.all
  @ingredients = Ingredient.all
  @tags = Tag.all
  erb :recipe_add
end

post "/recipes/add" do
  recipe_name = params['recipe-name']
  recipe_instructions = params['recipe-instructions']
  recipe_rating = params['recipe-rating'].to_i
  new_recipe = Recipe.create({name: recipe_name, instructions: recipe_instructions, rating: recipe_rating})
  capture_boxes(new_recipe)
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
  recipe.update({name: recipe_name, instructions: recipe_instructions, rating: recipe_rating})
  recipe.ingredients.clear
  recipe.tags.clear
  capture_boxes(recipe)
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
  @message = "Add a Tag"
  @tags = Tag.all
  erb :tag_add
end

post "/tags" do
  tag = params.fetch("tag-name")
  @tags = Tag.all
  if Tag.create({name: tag}).valid?
    @message = "Tag added!"
  else
    @message = "Tag must be less than 20 characters!"
  end
  erb :tag_add
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
