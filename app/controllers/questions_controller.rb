class QuestionsController < ApplicationController

  def index
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    @response = Response.new
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @question = Question.new(survey_id: @survey.id)
  end

  def edit
    @question = Question.find(params[:id])
    @survey = @question.survey
  end

  def create
    new_question = Question.new(whitelisted_question_params)
    if new_question.save
      flash[:success] = "New Question, successfully created"
      redirect_to edit_survey_question_path(new_question.survey_id, new_question)
    else
      @survey = Survey.find(params[:survey_id])
      @question = new_question
      show_errors(@question.errors.messages)
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.number_range?
      @question.options = []
      params["question"]["options_attributes"] =
      num_range_to_options_attributes(params[:min_range], params[:max_range])
    end
    if @question.update(whitelisted_question_params)
      flash[:success] = "yeah, question updated!"
      redirect_to question_edit_options_path(@question)
    else
      show_errors(@question.errors.messages)
      @survey = @question.survey
      render :edit
    end
  end

  def edit_options
    @question = Question.find(params[:id])
    @survey = @question.survey
    @num_options = @question.num_options
    if @question.options.empty?
      @num_options.times { @question.options.build(question_id: @question.id) }
    end
  end

  def update_options
    @question = Question.find(params[:id])
    @survey = @question.survey
    if @question.update(whitelisted_question_params)
      flash[:success] = "yeah, question updated!"
      redirect_to new_survey_question_path(@survey)
    else
      show_errors(@question.errors.messages)
      @survey = @question.survey
      render :edit
    end
  end

  def destroy
    question = Question.find(params[:id])
    survey = question.survey
    if question
      question.destroy
      flash[:success] = "question #{question.text} deleted!"
      redirect_to new_survey_question_path(survey)
    else
      render :edit
    end
  end

  private

  def whitelisted_question_params
    params.require(:question).permit(:text, :question_type, :survey_id, :num_options,
                                    :multi_select, :required,
                                    {
                                      :options_attributes => [:text, :id]
                                    }
      )
  end

  def show_errors(messages)
    flash.now[:danger] = []
    messages.each do |type, errors|
      errors.each do |err|
        flash.now[:danger] << type.to_s.titleize + " " + err
      end
    end
  end

  def num_range_to_options_attributes(min_range, max_range)
    options_attributes = {}
    (min_range..max_range).each_with_index do |n, i|
      options_attributes["#{i}"] = {text: "#{n}"}
    end
    options_attributes
  end
end
