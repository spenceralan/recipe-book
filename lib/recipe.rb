class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags
  validates :name, length: { maximum: 50 }

  before_save :capitalize_title
end


private

def capitalize_title
  self.name = name.split.map(&:capitalize).join(" ")
end
