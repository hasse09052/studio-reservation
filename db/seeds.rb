User.create!(name:  "テスト太郎",
  email: "first@testreserveapp.com",
  password:              "password",
  password_confirmation: "password",)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@testreserveapp.com"
  password = "password"
  User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password)
end