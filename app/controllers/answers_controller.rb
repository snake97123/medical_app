class AnswersController < ApplicationController
    def new
      @answer = Answer.new(question_id: @question_id)
    end

    def create
      # binding.pry
      @answer = Answer.new(answer_params)
      if @answer.save
        redirect_to question_path(@answer.question)
      else
        render :new
      end
    end

    private
    def answer_params
      params.require(:answer).permit(:text).merge(user_id: current_user.id, question_id: params[:question_id])
    end
end
   
