require "capybara/rspec"
require "spec_helper"
require "./app"
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe("the recipe add page", {:type => :feature}) do
  it("allows the user to create a new recipe") do
    visit("/")
    click_link("Add Recipe")
    fill_in("recipe-name", :with => "G-mas famous duck stuff")
    fill_in("recipe-instructions", :with => "G-mas is famous for this here duck stuff")
    select('1', :from => 'recipe-rating')
    click_button("Add Recipe")
    expect(page).to have_content("G-mas Famous Duck Stuff")
    expect(page).to have_content("G-mas is famous for this here duck stuff")
  end
end

describe("the recipe page", {:type => :feature}) do
  it("allows the user to navigate to the recipe page") do
    Recipe.create({name: "It could be different", instructions: "Cook eet", rating: "5"})
    visit("/")
    click_link("It Could Be Different")
    expect(page).to have_content("It Could Be Different")
  end
end

describe("the edit recipe page", {:type => :feature}) do
  it("allows the user to edit a recipe") do
    Recipe.create({name: "It could be different", instructions: "Cook eet", rating: "5"})
    visit("/")
    click_link("It Could Be Different")
    click_link("Edit Recipe")
    fill_in("recipe-name", :with => "it is different")
    click_button('Update Recipe')
    expect(page).to have_content("It Is Different")
  end
end

describe("the edit recipe page", {:type => :feature}) do
  it("allows the user to delete a recipe") do
    Recipe.create({name: "It could be different", instructions: "Cook eet", rating: "5"})
    visit("/")
    click_link("It Could Be Different")
    click_link("Edit Recipe")
    click_button('Delete Recipe')
    expect(page).not_to have_content("It Is Different")
  end
end

describe("the index page", {:type => :feature}) do
  it("allows the user to create a new recipe") do
    visit("/")
    click_link("Add Recipe")
    fill_in("recipe-name", :with => "G-mas famous duck stuff")
    fill_in("recipe-instructions", :with => "G-mas is famous for this here duck stuff")
    select('1', :from => 'recipe-rating')
    click_button("Add Recipe")
    expect(page).to have_content("G-mas Famous Duck Stuff")
    expect(page).to have_content("G-mas is famous for this here duck stuff")
  end
end
