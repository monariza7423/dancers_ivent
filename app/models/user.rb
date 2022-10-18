class User < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
