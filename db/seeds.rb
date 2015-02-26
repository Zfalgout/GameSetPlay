User.create!(name:  "User One",
             email: "User@one.com",
             zip: "12345",
             password:              "CS7000",
             password_confirmation: "CS7000",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@ttu.edu"
  password = "password1"
  zip = "12345"
  User.create!(name:  name,
               email: email,
               zip: zip,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end