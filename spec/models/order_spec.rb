require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      user = User.create(name: 'User', email: 'user@email.com', password: 'pwd123456')
      order = Order.create!(collect_zip: 11_256_360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas',
                    collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12_365_480,
                    deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                    user: user)

      expect(order.valid?).to be true
      expect(order.collect_zip).to eq 11_256_360
      expect(order.collect_street).to eq 'Rua um dois três'
      expect(order.collect_number).to eq 205
      expect(order.collect_nhood).to eq 'Laranjeiras'
      expect(order.collect_city).to eq 'Condongas'
      expect(order.collect_state).to eq 'MS'
      expect(order.width).to eq 10
      expect(order.height).to eq 12
      expect(order.depth).to eq 13
      expect(order.weight).to eq 82
      expect(order.deliv_reipient).to eq 'Um Dois Três de Oliveira Quatro'
      expect(order.deliv_zip).to eq 12_365_480
      expect(order.deliv_street).to eq 'Rua Condongueira'
      expect(order.deliv_number).to eq 105
      expect(order.deliv_nhood).to eq 'Canelas'
      expect(order.deliv_city).to eq 'Jocacia'
      expect(order.deliv_state).to eq 'MT'
      expect(order.km_dist).to eq 102
      expect(order.user).to eq user
      expect(order.status).to eq 'pending'
      expect(order.code.size).to eq 15
      expect(order.user.email).to eq 'user@email.com'
      expect(order.user.name).to eq 'User'
    end
  end
end
