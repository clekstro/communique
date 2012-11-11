FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  factory :user, class: "::User" do |user|
    email
    user.password               "password"
    user.password_confirmation  "password"
    user.username "johndoe"
  end
end
