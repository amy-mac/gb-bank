class Transaction < ApplicationRecord
  belongs_to :member

  validates :description, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validate :date_must_be_in_past

  def date_must_be_in_past
    return unless date

    if date >= Time.zone.tomorrow
      errors.add(:date, I18n.t('activerecord.errors.messages.no_date_in_future'))
    end
  end
end
