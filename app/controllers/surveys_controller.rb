class SurveysController < ApplicationController

  def index
    @surveys = Survey.order(created_at: :desc)
  end

  def create
    new_survey = Survey.new(whitelisted_survey_params)
    if new_survey.save
      flash[:success] = "New Survey, successfully created"
      redirect_to new_survey_question_path(new_survey)
    else
      @survey = new_survey
      show_errors(@survey.errors.messages)
      render :new
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def new
    @survey =  Survey.new
  end



  private

  def whitelisted_survey_params
    params.require(:survey).permit(:title, :description)
  end

  def show_errors(messages)
    flash.now[:danger] = []
    messages.each do |type, errors|
      errors.each do |err|
        flash.now[:danger] << type.to_s.titleize + " " + err
      end
    end
  end

end
