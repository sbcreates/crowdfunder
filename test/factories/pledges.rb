FactoryGirl.define do

  factory :pledge do
    dollar_amount 99
    # association :user, factory: :user
    project
    association :user, factory: :user
  end

end
