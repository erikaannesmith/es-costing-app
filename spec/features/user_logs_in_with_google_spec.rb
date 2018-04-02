require 'rails_helper'

describe "User logs in" do
  it "using Google OAuth2" do
    stub_omniauth
    visit root_path

    click_on(class: 'google-lgn-btn')
    expect(page).to have_content("Erika")
    expect(page).to have_link("Log Out")
    click_link "Log Out"
    expect(page).not_to have_content("Erika")
  end
end