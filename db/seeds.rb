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

  users = User.order(:created_at).take(6)
  
  50.times do
    user_id = 1 
    player1 = 2
    location = Faker::Lorem.sentence(5)
    time =  Time.zone.now
    type = "singles"
    public = true

    users.each { |user| user.matches.create!(user_id: user_id, player1: player1, 
      location: location, time: time, type: type, public: public) }
  end
end