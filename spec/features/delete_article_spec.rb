require 'rails_helper'

RSpec.feature "Delete Article" do

  before do
    @article = Article.create(title: "Title one", body: "This is the body")
  end

  scenario "User deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article was successfully deleted")
    expect(page.current_path).to eq(articles_path)
  end

end