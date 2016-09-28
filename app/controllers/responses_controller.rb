class ResponsesController < ApplicationController
  def create
    new_response = Response.new(name: params["response"]["name"])
    new_response.answers_attributes= whitelisted_answer_params
    if new_response.save
      flash[:success] = "Thank you for taking the survey"
      redirect_to :root
    else
      flash.new[:danger] = "Please correct the errors and resubmit"
      render 'questions/index'
    end
  end

  private
  def whitelisted_answer_params
    temp_arr = []
    survey_id = params["response"]["survey_id"]
    params["survey"].each do |k, v|
      temp_arr << {survey_id: survey_id, question_id: k, option_id: v.join}
    end
    temp_arr
  end
end
