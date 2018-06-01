require 'rails_helper'

# visit root page
# click on new article link
# fill in title
# fill in body
# create article
#
# Expectations:
# article has been created
# articles path


RSpec.feature "creating articles" do
  scenario "user creates a new article" do
    visit "/"     # sign for root

    click_link "New Article"

    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"

    click_button "Create Article"

    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
  end

  scenario "user fails to create a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Create Article"

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end

