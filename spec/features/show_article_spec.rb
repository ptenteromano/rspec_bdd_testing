require 'rails_helper'

RSpec.feature "Showing an article" do

  before do
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @john = User.create(email: "john@example.com", password: 'password')
    @article1 = Article.create(title: "Article title", body: "this is the body", user: @john)
  end

  scenario 'Non signed in user cannot see edit/delete buttons' do
    visit '/'

    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))

    expect(page).to_not have_link("Delete Article")
    expect(page).to_not have_link("Edit Article")
  end


  scenario 'Non owner cannot see edit/delete buttons' do
    login_as @fred
    visit '/'

    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))

    expect(page).to_not have_link("Delete Article")
    expect(page).to_not have_link("Edit Article")
  end

  scenario 'Article owner can see edit/delete buttons' do
    login_as @john
    visit '/'

    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))

    expect(page).to have_link('Delete Article')
    expect(page).to have_link('Edit Article')
  end

end