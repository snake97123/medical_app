class QuestionsController < ApplicationController
  before_action :authenticate_user! ,only: [:new] 
  before_action :move_to_index, only: [:edit]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.includes(:user)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path
    else
      render :edit
    end
  end

  def destroy
     @question =Question.find(params[:id])
     @question.destroy if current_user.id == @question.user_id
     redirect_to root_path
  end


  private

  def question_params
    params.require(:question).permit(:title, :content).merge(user_id: current_user.id)
  end
end
