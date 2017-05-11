require "spec_helper"

describe Recipe do
  it { should have_many :ingredients }
  it { should have_many :tags }
  it { should_not allow_value("blahblah" * 10).for(:name) }
  it { is_expected.to callback(:capitalize_title).before(:save) }
end

describe Tag do
  it { should have_many :recipes }
  it { should_not allow_value("blahblah" * 10).for(:name) }
end

describe Ingredient do
  it { should have_many :recipes }
  it { should_not allow_value("blahblah" * 10).for(:name) }
end

describe RecipeIngredient do
  it { should belong_to :recipe }
  it { should belong_to :ingredient }
end

describe RecipeTag do
  it { should belong_to :recipe }
  it { should belong_to :tag }
end
