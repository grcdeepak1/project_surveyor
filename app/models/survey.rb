class Survey < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :responses, through: :answers
end
