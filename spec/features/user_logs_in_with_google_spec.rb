require 'rails_helper'

describe "User logs in" do
  it "using Google OAuth2" do
    stub_omniauth
    visit root_path

    expect(page).to have_link("Sign in with Google")
    click_link "Sign in with Google"
    expect(page).to have_content("Erika Smith")
    expect(page).to have_link("Logout")
    click_link "Logout"
    expect(page).not_to have_content("Erika Smith")
    expect(page).to have_content("Sign in with Google")
  end
end