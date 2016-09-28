Survey.destroy_all
Question.destroy_all
Option.destroy_all
Response.destroy_all
Answer.destroy_all

puts "Creating 10 surveys..."
10.times do
  Survey.create(title: Faker::Lorem.sentence, description: Faker::Lorem.sentence )
end

puts "Creating 3 questions in each survey.."
Survey.all.each do |s|
  s.questions << Question.new(survey_id: s.id, text: Faker::Lorem.sentence, num_options: 3,
                              required: true, question_type: 'Multiple Choice', multi_select: false)
  s.questions << Question.new(survey_id: s.id, text: Faker::Lorem.sentence, num_options: 3,
                              required: true, question_type: 'Multiple Choice', multi_select: true)
  s.questions << Question.new(survey_id: s.id, text: Faker::Lorem.sentence,
                              question_type: 'Number Range')
end

puts "Creating 3 options per questions in each survey.."
Question.all.each do |q|
  if q.number_range?
    (1..3).each { |num| Option.create(question_id: q.id, text: num) }
  else
    3.times do
      Option.create(question_id: q.id, text: Faker::Lorem.sentence)
    end
  end
end

puts "Taking last survey"
r = Response.create(name: "Deepak")
s = Survey.last
s.questions.each do |q|
  if q.multi_select?
    Answer.create(question_id: q.id, option_id: q.options.first.id,
                  survey_id: s.id, response_id: r.id)
    Answer.create(question_id: q.id, option_id: q.options.last.id,
                  survey_id: s.id, response_id: r.id)
  else
    Answer.create(question_id: q.id, option_id: q.options.sample.id,
                  survey_id: s.id, response_id: r.id)
  end
end