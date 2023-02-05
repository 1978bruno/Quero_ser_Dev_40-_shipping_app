class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :costs
  has_many :deliv_terms
  has_many :orders

end
