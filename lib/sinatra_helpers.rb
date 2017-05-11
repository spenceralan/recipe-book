
require "sinatra/base"

module Sinatra
  module Capture_checked_items
    def capture_boxes
      params.fetch("ingredients", []).each do |ingredient|
        new_recipe.ingredients.push(Ingredient.find(ingredient['id']))
      end
      params.fetch("tags", []).each do |tag|
        new_recipe.tags.push(Tag.find(tag['id']))
      end
    end
  end
  helpers Capture_checked_items
end
