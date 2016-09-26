Survey.destroy_all

10.times do
  Survey.create(title: Faker::Lorem.sentence, description: Faker::Lorem.sentence )
end