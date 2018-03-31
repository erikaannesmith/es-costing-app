require 'rails_helper'

describe "User interacts with styles" do
  it "They can see all styles for a client" do
    stub_omniauth
    visit root_path
    click_on "Sign in with Google"
    user = User.first
    client_1 = Client.create(name: "Stone Cold Fox",
                             email: "stone@stone.com",
                             user: user)
    client_2 = Client.create(name: "Novella Royalle",
                             email: "novella@novella.com",
                             user: user)
    style_1 = Style.create(name: "Belle Top",
                           amount: 40,
                           cost: 10.0,
                           season: "SS16",
                           client: client_1)
    style_2 = Style.create(name: "Amy Shorts",
                           amount: 50,
                           cost: 20.0,
                           season: "SS17",
                           client: client_1)
    style_3 = Style.create(name: "Mandy Top",
                           amount: 60,
                           cost: 30.0,
                           season: "SS18",
                           client: client_2)
    
    visit user_client_path(client_1)

    expect(page).to have_content(style_1.name)
    expect(page).to have_content(style_1.amount)
    expect(page).to have_content(style_1.cost)
    expect(page).to have_content(style_1.season)
    expect(page).to have_content(style_2.name)
    expect(page).to have_content(style_2.amount)
    expect(page).to have_content(style_2.cost)
    expect(page).to have_content(style_2.season)
    expect(page).not_to have_content(style_3.name)
    expect(page).not_to have_content(style_3.amount)
    expect(page).not_to have_content(style_3.cost)
    expect(page).not_to have_content(style_3.season)
  end

  it "They can see an individual style" do
    stub_omniauth
    visit root_path
    click_on "Sign in with Google"
    user = User.first
    client_1 = Client.create(name: "Stone Cold Fox",
                             email: "stone@stone.com",
                             user: user)
    client_2 = Client.create(name: "Novella Royalle",
                             email: "novella@novella.com",
                             user: user)
    style_1 = Style.create(name: "Belle Top",
                           amount: 40,
                           cost: 10.0,
                           season: "SS16",
                           client: client_1)
    
    visit root_path
    click_on client_1.name
    click_on style_1.name

    expect(current_path).to eq(user_client_style_path(style_1))
    expect(page).to have_content(style_1.name)
    expect(page).to have_content(style_1.amount)
    expect(page).to have_content(style_1.cost)
    expect(page).to have_content(style_1.season)
  end
end