class Order < ApplicationRecord
  belongs_to :user
  has_one :process_order, class_name: 'Order',
                          dependent: :destroy

  enum status: { pending: 0, delivered: 1, canceled: 2, delivering: 3 }

  validates :code, :collect_zip, :collect_number, :width, :height, :depth, :weight,
            :deliv_reipient, :deliv_zip, :km_dist, presence: true

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
