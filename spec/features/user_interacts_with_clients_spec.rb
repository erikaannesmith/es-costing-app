require 'rails_helper'

describe "User interacts with clients" do  
  it "They see a client index after logging in" do
    stub_omniauth
    visit root_path
    click_on(class: 'google-lgn-btn')
    user = User.first
    client_1 = Client.create(name: "Stone Cold Fox",
                             email: "stone@stone.com",
                             user: user)
    client_2 = Client.create(name: "Novella Royalle",
                             email: "novella@novella.com",
                             user: user)
    visit root_path

    expect(page).to have_content("Erika")
    expect(page).to have_content(client_1.name.upcase)
    expect(page).to have_content(client_1.email)
    expect(page).to have_content(client_2.name.upcase)
    expect(page).to have_content(client_2.email)
  end

  it "They can create a new client" do
    stub_omniauth
    visit root_path
    click_on(class: 'google-lgn-btn')    
    
    user = User.first
    
    expect(user.clients.count).to eq(0)

    click_on "+"

    expect(current_path).to eq(new_user_client_path)

    fill_in "client[name]", with: "Novella Royalle"
    fill_in "client[email]", with: "novella@novella.com"

    click_on "CREATE CLIENT"

    expect(current_path).to eq(user_client_path(Client.first))
    expect(user.clients.count).to eq(1)
    expect(page).to have_content("Novella Royalle")
    expect(page).to have_content("novella@novella.com")
    expect(page).to have_content("Novella Royalle has been created!")
  end

  it "They can edit a client" do
    stub_omniauth
    visit root_path
    click_on(class: 'google-lgn-btn')    
    
    user = User.first
    client_1 = Client.create(name: "Stone Cold Fox",
                             email: "stone@stone.com",
                             user: user)

    visit user_client_path(client_1)

    expect(page).to have_content("Stone Cold Fox")

    click_on "Edit Client"

    expect(current_path).to eq(edit_user_client_path(client_1))

    fill_in "client[email]", with: "fox@fox.com"

    click_on "UPDATE CLIENT"

    expect(current_path).to eq(user_client_path(client_1))
    expect(page).to have_content("#{client_1.name} has been updated!")
    expect(page).to have_content("fox@fox.com")
    expect(page).not_to have_content("stone@stone.com")
  end
end