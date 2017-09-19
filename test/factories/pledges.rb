FactoryGirl.define do

  factory :pledge do
    dollar_amount 99
    # association :user, factory: :user
    association :user, factory: :user
  end

end
