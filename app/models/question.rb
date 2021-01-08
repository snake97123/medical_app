class Question < ApplicationRecord
  belongs_to  :user
  has_many    :answers,  dependent: :destroy

  with_options presence: true do
    validates :title
    validates :content
  end

  def self.search(search)
    if search != ''
      Question.where('title LIKE(?) ', "%#{search}%")
    else
      Question.all
    end
  end
end
