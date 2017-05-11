ENV["RACK_ENV"] = "test"

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Recipe.all.each do |d|
      d.destroy
    end
    Ingredient.all.each do |d|
      d.destroy
    end
    Tag.all.each do |d|
      d.destroy
    end
    RecipeTag.all.each do |d|
      d.destroy
    end
    RecipeIngredient.all.each do |d|
      d.destroy
    end
  end
end
