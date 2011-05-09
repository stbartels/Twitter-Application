Factory.define :user do |user|
  user.name                  "Example User"
  user.email                 "example@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  'person-#{n}@example.com'
end

Factory.define :mircropost do |micro|
  micro.content "Foo bar"
  micro.association :user
end