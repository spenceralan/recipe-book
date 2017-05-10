require "spec_helper"

describe "Recipe" do
  describe '#ingredients' do
    it "tells which ingredients are associated with this recipe" do
      test_ingredient = Ingredient.create({name: 'meat'})
      test_recipe = Recipe.create({name: 'Raw Meat Platter'})
      test_recipe.ingredients.push(test_ingredient)
      expect(test_recipe.ingredients).to eq([test_ingredient])
    end
  end

  describe '#tags' do
    it "tells which tags are associated with this recipe" do
      test_tag = Tag.create({name: "yum-e"})
      test_ingredient = Ingredient.create({name: 'meat'})
      test_recipe = Recipe.create({name: 'Raw Meat Platter'})
      test_recipe.ingredients.push(test_ingredient)
      test_recipe.tags.push(test_tag)
      expect(test_recipe.tags).to eq([test_tag])
    end
  end

end

describe "Ingredient" do

  describe '#recipes' do
    it "tells which recipes are associated with this ingredient" do
      test_ingredient = Ingredient.create({name: 'meat'})
      test_recipe = Recipe.create({name: 'Raw Meat Platter'})
      test_recipe.ingredients.push(test_ingredient)
      expect(test_ingredient.recipes).to eq([test_recipe])
    end
  end

end

describe "Tag" do

  describe '#recipes' do
    it "tells which recipes are associated with this tag" do
      test_tag = Tag.create({name: "yum-e"})
      test_recipe = Recipe.create({name: 'Raw Meat Platter'})
      test_recipe.tags.push(test_tag)
      expect(test_tag.recipes).to eq([test_recipe])
    end
  end

end
