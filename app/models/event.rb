class Event < ApplicationRecord
  has_many :competitions, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  has_one_attached :image
end
