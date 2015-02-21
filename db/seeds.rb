User.create!(name:  "User One",
             email: "User@one.com",
             password:              "CS7000",
             password_confirmation: "CS7000",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@ttu.edu"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end