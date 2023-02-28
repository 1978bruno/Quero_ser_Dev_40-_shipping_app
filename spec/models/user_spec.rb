require 'rails_helper'

RSpec.describe User, type: :model do
  it 'deve ter um código' do
    user = User.create(name: 'User10', email: 'user10@email.com', password: 'password')

    expect(user.valid?).to be true
    expect(user.name).to eq 'User10'
    expect(user.email).to eq 'user10@email.com'
    expect(user.password).to eq 'password'
  end
end
