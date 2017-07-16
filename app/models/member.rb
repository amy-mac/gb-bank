class Member < ApplicationRecord
  has_many :transactions

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
