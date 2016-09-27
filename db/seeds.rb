Survey.destroy_all
Question.destroy_all
Option.destroy_all

puts "Creating 10 surveys..."
10.times do
  Survey.create(title: Faker::Lorem.sentence, description: Faker::Lorem.sentence )
end

puts "Creating 2 questions in each survey.."
Survey.all.each do |s|
  2.times do
    s.questions << Question.new(survey_id: s.id, text: Faker::Lorem.sentence, num_options: 3,
                                required: true, question_type: 'multiple choice')
  end
end

puts "Creating 3 options per questions in each survey.."
Question.all.each do |q|
  3.times do
    Option.create(question_id: q.id, text: Faker::Lorem.sentence)
  end
end