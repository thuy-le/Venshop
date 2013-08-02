FactoryGirl.define do
  factory :user do
    name     "Kate Le"
    email    "Kate@mail.com"
    password "password"
    password_confirmation "password"
  end
end
