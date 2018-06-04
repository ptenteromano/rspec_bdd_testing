require 'rails_helper'

RSpec.feature "showing an article" do

  before do
    john = User.create(email: "john@example.com", password: 'password')
    login_as(john)
    @article1 = Article.create(title: "Article title", body: "this is the body", user: john)
  end

  scenario "user views a specific article" do
    visit '/'

    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))

  end

end