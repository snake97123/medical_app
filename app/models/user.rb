class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :phone_number, presence: true, format: { with: /\A^(0{1}\d{9,10})$\z/ }

  has_many  :questions
  has_many  :answers

  def self.guest
    find_or_create_by!(email: 'guest@example.com', phone_number: '09033338888', nickname: 'guest') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
