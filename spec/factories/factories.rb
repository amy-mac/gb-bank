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
  end

  factory :transaction do
    description "New blaster pistol"
    amount 543.35
    date { Time.zone.yesterday }
    member { FactoryGirl.create(:member) }
  end
end
