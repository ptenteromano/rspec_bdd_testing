require 'rails_helper'

# create two articles to display
# list the two articles
#
# expect the titles and bodies to be present
RSpec.feature "listing articles" do

  before do
    # no need to log in
    john = User.create(email: "john@example.com", password: 'password')
    @article1 = Article.create(title: "First article", body: "first body", user: john)
    @article2 = Article.create(title: "Second article", body: "first body", user: john)
  end

  scenario "display index with two articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "a user has no articles" do
    Article.delete_all

    visit "/"

    expect(page).to_not have_content(@article1.title)
    expect(page).to_not have_content(@article1.body)
    expect(page).to_not have_content(@article2.title)
    expect(page).to_not have_content(@article2.body)
    expect(page).to_not have_link(@article1.title)
    expect(page).to_not have_link(@article2.title)

    within("h1#no-articles") do
      expect(page).to have_content("No articles created")
    end
  end

end