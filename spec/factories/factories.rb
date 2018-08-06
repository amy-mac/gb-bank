FactoryGirl.define do
  factory :member do
    name "Leia Organa"
    sequence(:email) { |n| "user_#{n}@gbbank.com" }

    trait :no_email do
      email nil
    end

    trait :no_name do
      name nil
    end

    trait :include_balance do
      balance 32.00
    end
  end

  factory :transaction do
    description "New blaster pistol"
    amount -43.35
    date { Time.zone.yesterday }
    member { FactoryGirl.create(:member) }

    trait :no_member do
      member nil
    end
  end
end
