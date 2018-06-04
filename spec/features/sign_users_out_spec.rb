require 'rails_helper'

RSpec.feature "Signout Users" do

  before do
    @john = Users.create!(email: "john@example.com", password: "password")
    vist "/"
    click_link "Sign In"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
  end

  scenario do
    visit "/"

    click_link "Sign Out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_content("Sign Out")
  end


end