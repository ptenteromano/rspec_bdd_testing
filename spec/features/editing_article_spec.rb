require 'rails_helper'

RSpec.feature "Editing an Article" do

  before do
    @article1 = Article.create(title: "Article title", body: "this is the body")
  end

  scenario "User edits an article" do
    visit '/'

    click_link @article1.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated body of article"

    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article1))
  end

  scenario "User fails to update an article" do
    visit "/"

    click_link @article1.title
    click_link "Edit Article"

    fill_in "Title", with: " "
    fill_in "Body", with: "Updated body of article"

    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article1))
  end

end
