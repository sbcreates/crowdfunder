FactoryGirl.define do
  factory :user do
    password "helloworld"
    password_confirmation "helloworld"
    email {rand(20000)}.to_s + "@asdf.com"
    admin false
    first_name "marlon"
    last_name "o'neil"

    factory :user2 do
      email {rand(20000)}.to_s + "@asdsafsdaff.com"
      admin false
      first_name "project_owner"
      last_name "o'neil2"
    end
  end
end
