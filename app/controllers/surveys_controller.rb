class SurveysController < ApplicationController

  def index
    @surveys = Survey.all
  end

  def create
    new_survey = Survey.new(whitelisted_survey_params)
    if new_survey.save
      flash[:success] = "New Survey, successfully created"
      redirect_to surveys_path
    else
      @survey = new_survey
      show_errors(@survey.errors.messages)
      render :new
    end
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
