FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  factory :user do |user|
    email
    user.password               "password"
    user.password_confirmation  "password"
  end
end
