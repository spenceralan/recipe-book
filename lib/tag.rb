class Tag < ActiveRecord::Base
  has_many :recipe_tags
  has_many :recipes, through: :recipe_tags
  validates :name, length: { maximum: 20 }
end
