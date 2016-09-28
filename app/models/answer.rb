class Answer < ApplicationRecord
  belongs_to :option
  belongs_to :question
  belongs_to :response
  belongs_to :survey

  validates :question_id, presence: true
  validates :option_id, presence: true, if: :question_required?

  def question_required?
    Question.find(self.question_id).required?
  end

end
