class Transaction < ApplicationRecord
  belongs_to :member

  validates :description, presence: true
  validates :amount, presence: true, numericality: true
  validates :date, presence: true
  validate :date_must_be_in_past
  validate :member_not_overdrawn?

  def date_must_be_in_past
    return unless date

    if date >= Time.zone.tomorrow
      errors.add(:date, I18n.t('activerecord.errors.messages.no_date_in_future'))
    end
  end

  def member_not_overdrawn?
    return unless member && amount

    unless member.update_balance(amount)
      errors.add(:member, I18n.t('activerecord.errors.messages.member_overdrawn')) unless errors[:member].present?
    end
  end

  after_create :save_member_balance

  def save_member_balance
    member.save!
  end
end
