class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :set_answer, only: [:edit, :uodate, :destroy]

  def new
    @answer = Answer.new(question_id: @question_id)
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question)
    else
      render :new
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@question.id)
    else
      render :edit
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to root_path
  end

  private

  def answer_params
    params.require(:answer).permit(:text).merge(user_id: current_user.id, question_id: params[:question_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
