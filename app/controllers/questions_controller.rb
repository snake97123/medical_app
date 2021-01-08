class QuestionsController < ApplicationController
  before_action :authenticate_user! ,only: [:new] 
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  

  def index
    @questions = Question.all
    @posts = Question.all.count
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
    @answer = Answer.new
    @answers = @question.answers.includes(:user)
    @best = Answer.select(:question_id)
  end

  def search
    @questions = Question.search(params[:keyword])
  end
  

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to question_path
    else
      render :edit
    end
  end

  def destroy
     @question.destroy if current_user.id == @question.user_id
     redirect_to root_path
  end


  private

  def question_params
    params.require(:question).permit(:title, :content, :best_answer_id).merge(user_id: current_user.id)
  end
end

  def set_question
    @question =Question.find(params[:id])
  end
