class Answer < ApplicationRecord
  belongs_to   :user
  belongs_to   :question

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :text, presence: true
end
