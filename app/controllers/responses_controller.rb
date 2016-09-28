class ResponsesController < ApplicationController
  def create
    new_response = Response.new(name: params["response"]["name"])

    new_response.answers_attributes= whitelisted_answer_params
    if validate_response(params) && new_response.save
      flash[:success] = "Thank you for taking the survey"
      redirect_to :root
    else
      @survey = Survey.find(params["response"]["survey_id"])
      @questions = @survey.questions
      @response = Response.new
      flash.now[:danger] = "Please correct the errors and resubmit"
      render 'questions/index'
    end
  end

  def index

  end

  private
  def whitelisted_answer_params
    temp_arr = []
    survey_id = params["response"]["survey_id"]
    params["survey"].each do |k, v|
      v.each do |m_v|
        temp_arr << {survey_id: survey_id, question_id: k, option_id: m_v}
      end
    end
    temp_arr
  end

  def validate_response(params)
    true
  end
end
