FactoryGirl.define do
  factory :user do
    password "helloworld"
    password_confirmation "helloworld"
    email "asdf@asdf.com"
    admin false
    first_name "marlon"
    last_name "o'neil"

    factory :user2 do
      email "asdasdff@asasdfdf.com"
      admin false
      first_name "project_owner"
      last_name "o'neil2"
    end
  end
end
