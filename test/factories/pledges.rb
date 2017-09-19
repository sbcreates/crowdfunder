FactoryGirl.define do

  factory :pledge do
    dollar_amount 99
    # association :user, factory: :user
<<<<<<< HEAD
    project
=======
>>>>>>> f9fe25b40ea467000120862041aea2fc87923395
    association :user, factory: :user
  end

end
