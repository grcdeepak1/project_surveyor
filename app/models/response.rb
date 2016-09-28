class Response < ApplicationRecord
  has_many :answers, inverse_of: :response
  accepts_nested_attributes_for :answers
end
