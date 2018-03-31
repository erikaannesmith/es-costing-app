require 'rails_helper'

RSpec.describe Client, type: :model do
  it "client#index" do
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
    client_3 = Client.create(name: "Esby",
                          email: "esby@esby.com")
    
    expect(user.clients.count).to eq(2)
    expect(client_1.name).to eq("Stone Cold Fox")
    expect(client_1.email).to eq("stone@stone.com")
    expect(client_2.name).to eq("Novella Royalle")
    expect(client_2.email).to eq("novella@novella.com")
  end
end
