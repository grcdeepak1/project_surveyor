class Answer < ApplicationRecord
  belongs_to :option
  belongs_to :question

  validates :question_id, presence: true
  validates :option_id, presence: true, if: :question_required?

  def question_required?
    Question.find(self.question_id).required?
  end

end
