class Member < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: -150.00 }

  default_scope { order(:name) }

  def update_balance(amount)
    self.balance += amount
    self.valid?
  end
end
