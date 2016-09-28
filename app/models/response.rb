class Response < ApplicationRecord
  has_many :answers, inverse_of: :response
  has_many :surveys, through: :answers
  accepts_nested_attributes_for :answers
end
