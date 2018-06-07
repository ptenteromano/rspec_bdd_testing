require 'rails_helper'

RSpec.feature 'Adding reviews to Articles' do
  before do
    @fred = User.create(email: "fred@example.com", password: 'password')
    @john = User.create(email: "john@example.com", password: 'password')
    @article = Article.create(title: "First article", body: "first body", user: @john)
  end

  scenario 'Permits signed in user to add comment' do
    login_as @fred
    visit '/'

    click_link @article.title

    fill_in "New Comment", with: "Amazing article!"
    click_button "Add Comment"

    expect(page).to have_content "Comment has been created"
    expect(page).to have_content "Amazing article!"
    expect(current_path).to eq(article_path(@article.id))
  end

end

