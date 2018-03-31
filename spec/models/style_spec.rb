require 'rails_helper'

RSpec.describe Style, type: :model do
  it "Style model" do
    auth = {
      provider: "google",
      uid: "0123456789",
      info: {
        email: "erikaannesmith@gmail.com",
        first_name: "Erika",
        last_name: "Smith"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now
      }
    }

    User.update_or_create(auth)

    user = User.first

    client_1 = Client.create(name: "Stone Cold Fox",
                             email: "stone@stone.com",
                             user_id: user.id)
    client_2 = Client.create(name: "Novella Royalle",
                             email: "novella@novella.com",
                             user_id: user.id)

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

    expect(client_1.styles.count).to eq(2)
    expect(style_1.name).to eq("Belle Top")
    expect(style_1.amount).to eq(40)
    expect(style_1.cost).to eq(10.0)
    expect(style_1.season).to eq("SS16")
    expect(style_1.client).to eq(client_1)
  end
end
