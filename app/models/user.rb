class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :phone_number, presence: true, format: { with: /\A^(0{1}\d{9,10})$\z/ }

  # PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  # validates_format_of :password, with: PASSWORD_REGEX

  has_many  :questions
  has_many  :answers
  has_many  :likes, dependent: :destroy
  has_many  :like_answers, through: :likes, source: :answer


  def self.guest
    find_or_create_by!(email: 'guest@example.com', phone_number: '09033338888', nickname: 'guest') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
